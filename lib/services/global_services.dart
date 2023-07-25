import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/consts/app_text_style.dart';
import 'package:newso/services/get_theme_color_service.dart';

class GlobalServices {
  static GlobalServices instance = GlobalServices();

  //* for formating date
  String formatDate(String publishedAt) {
    final parseDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parseDate);
    DateTime publishedDate =
        DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);
    return "${publishedDate.day}-${publishedDate.month}-${publishedDate.year} ON ${publishedDate.hour}:${publishedDate.minute}";
  }

  //* error dialogue
  Future<void> errorDialogue(
      {required String errorMessage, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
          title: Row(
            children: [
              const Icon(IconlyBold.danger, color: Colors.red),
              SizedBox(width: 5.w),
              const Text("An error occured")
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Ok"),
            )
          ],
        );
      },
    );
  }

  //* loading dailogue
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Builder(builder: (context) {
        return SizedBox(
          width: 100.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: GetThemeColorService(context).getPaginationColor,
              ),
              SizedBox(
                height: 18.h,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: Text(
                  "Loading...",
                  style: AppTextStyle.instance
                      .mainTextStyle(15, FontWeight.bold, context),
                ),
              ),
            ],
          ),
        );
      }),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //* closing dialogue
  appDialogue(
      BuildContext context, String title, void Function()? yesFunction) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          content: Text(
            title,
            style: AppTextStyle.instance
                .mainTextStyle(20, FontWeight.bold, context),
          ),
          actions: [
            TextButton(
              child: Text(
                "No",
                style: TextStyle(
                    color: versionTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: yesFunction,
              child: Text(
                "Yes",
                style: TextStyle(
                    color: versionTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      }),
    );
  }
}
