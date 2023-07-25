import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/consts/theme_style.dart';
import 'package:newso/providers/dark_theme_provider.dart';
import 'package:newso/providers/news_provider.dart';
import 'package:newso/screens/homescreen/home_screen.dart';
import 'package:newso/screens/newsdetailscreen/news_detail_screen.dart';
import 'package:newso/screens/signinscreen/sign_in_screen.dart';
import 'package:newso/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  //! for portrait screen only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeController = DarkThemeProvider();

  //* get current theme (dark or light)
  void getCurrentAppTheme() async {
    themeChangeController.setDarkTheme =
        await themeChangeController.darkThemeSetting.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => themeChangeController),
            ChangeNotifierProvider(create: (_) => NewsProvider()),
          ],
          //* current theme
          child: Consumer<DarkThemeProvider>(
            builder: (context, newValue, child) {
              return MaterialApp(
                theme: ThemeStyle.themeData(newValue.darkTheme, context),
                debugShowCheckedModeBanner: false,
                home: StreamBuilder(
                    stream: AuthService.instance.getAuthChange,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return const HomeScreen();
                      } else {
                        return const SignInScreen();
                      }
                    })),
                routes: {
                  NewsDetailScreen.routeName: (ctx) => const NewsDetailScreen(),
                },
              );
            },
          ),
        );
      }),
    );
  }
}
