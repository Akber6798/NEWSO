import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/consts/routes.dart';
import 'package:newso/providers/dark_theme_provider.dart';
import 'package:newso/screens/homescreen/home_screen.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/services/auth_service.dart';
import 'package:newso/services/global_services.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      auth.currentUser!.photoURL.toString(),
                    ),
                  ),
                  const VerticalSpacingWidget(height: 5),
                  Text(
                    auth.currentUser!.displayName.toString(),
                    style: AppTextStyle.instance
                        .mainTextStyle(24, FontWeight.bold, context),
                  )
                ],
              ),
            ),
            const VerticalSpacingWidget(height: 20),
            //! drawer home box
            ListTile(
              leading: Icon(
                IconlyBold.home,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                "Home",
                style: AppTextStyle.instance
                    .mainTextStyle(20, FontWeight.w500, context),
              ),
              onTap: () {
                Routes.instance.pushReplaceMent(
                  context: context,
                  newScreen: const HomeScreen(),
                );
              },
            ),
            const VerticalSpacingWidget(height: 10),
            //! drawer logout box
            ListTile(
              leading: Icon(
                IconlyBold.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                "Logout",
                style: AppTextStyle.instance
                    .mainTextStyle(20, FontWeight.w500, context),
              ),
              onTap: () async {
                GlobalServices.instance
                    .appDialogue(context, "Are you sure to LogOut", () async {
                  await AuthService.instance.logOut(context);
                });
              },
            ),
            const VerticalSpacingWidget(height: 10),
            const Divider(
              thickness: 3,
            ),
            //! dark mode switch
            SwitchListTile(
                title: Text(
                  "Dark Mode",
                  style: AppTextStyle.instance
                      .mainTextStyle(20, FontWeight.w500, context),
                ),
                secondary: Icon(
                    themeState.darkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: Theme.of(context).colorScheme.secondary),
                value: themeState.darkTheme,
                onChanged: (value) {
                  themeState.setDarkTheme = value;
                }),
            const VerticalSpacingWidget(height: 180),
            //! app logo
            Image(
              height: 50.h,
              width: 50.w,
              image: const AssetImage("assets/icons/logo.png"),
            ),
            const VerticalSpacingWidget(height: 20),
            //! version test
            Align(
              alignment: Alignment.center,
              child: Text(
                "Version : 1",
                style: GoogleFonts.bitter(
                    fontSize: 20.sp,
                    color: versionTextColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const VerticalSpacingWidget(height: 20),
          ],
        ),
      ),
    );
  }
}
