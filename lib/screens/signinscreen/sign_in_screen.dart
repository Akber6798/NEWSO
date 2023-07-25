import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/services/auth_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacingWidget(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! welcome text
                  Text(
                    "Welcome to\nNewso.......",
                    style: AppTextStyle.instance
                        .mainTextStyle(30, FontWeight.bold, context),
                  ),
                  Image(
                    height: 60.h,
                    width: 60.w,
                    image: const AssetImage(
                      "assets/icons/logo.png",
                    ),
                  )
                ],
              ),
              VerticalSpacingWidget(height: 25.h),
              //! subtest
              Text(
                "Stay up-to-date with the latest breaking news, trending stories, and in-depth coverage from around the world with our cutting-edge news app.",
                style: AppTextStyle.instance
                    .textStyle(18, FontWeight.w300, context),
              ),
              VerticalSpacingWidget(height: 60.h),
              //! animation
              Center(
                child: Lottie.asset(
                  "assets/animations/welcome.json",
                ),
              ),
              VerticalSpacingWidget(height: 90.h),
              //! sign up button
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await AuthService.instance.signUpWithGoogle(context);
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(25),
                    child: Card(
                      elevation: 5,
                      shape: const StadiumBorder(),
                      child: Container(
                        height: 50.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                              height: 30.h,
                              width: 30.w,
                              image:
                                  const AssetImage("assets/icons/google.png"),
                            ),
                            Text(
                              "Sign in",
                              style: AppTextStyle.instance
                                  .textStyle(20, FontWeight.bold, context),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
