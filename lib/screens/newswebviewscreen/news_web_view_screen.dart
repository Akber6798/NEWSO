import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newso/services/global_services.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebViewScreen extends StatefulWidget {
  const NewsWebViewScreen({super.key, required this.newsUrl});

  final String newsUrl;

  @override
  State<NewsWebViewScreen> createState() => _NewsWebViewScreenState();
}

class _NewsWebViewScreenState extends State<NewsWebViewScreen> {
  late WebViewController _webController;
  double _progerss = 0.0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webController.canGoBack()) {
          _webController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrowLeft2, size: 30),
          ),
          actions: [
            //! to show the bottomsheet
            IconButton(
                onPressed: () async {
                  await showModelSheetFuction();
                },
                icon: const Icon(Icons.more_horiz))
          ],
          title: Text(widget.newsUrl),
        ),
        body: Column(
          children: [
            ////! loading
            LinearProgressIndicator(
              value: _progerss,
              color: _progerss == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              //! webview news
              child: WebView(
                initialUrl: widget.newsUrl,
                zoomEnabled: true,
                onProgress: (progess) {
                  setState(() {
                    _progerss = progess / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* bototom sheet
  Future<void> showModelSheetFuction() async {
    scaffoldKey.currentState!.showBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      (context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const VerticalSpacingWidget(height: 15),
              Center(
                child: Container(
                  height: 5.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const VerticalSpacingWidget(height: 15),
              Text(
                "More option",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),
              const VerticalSpacingWidget(height: 15),
              const Divider(thickness: 2),
              const VerticalSpacingWidget(height: 15),
              //! share function
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share"),
                onTap: () async {
                  try {
                    await Share.share(widget.newsUrl,
                        subject: 'Look what I made!');
                  } catch (error) {
                    GlobalServices.instance.errorDialogue(
                        errorMessage: error.toString(), context: context);
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
              //! open browser function
              ListTile(
                leading: const Icon(Icons.open_in_browser),
                title: const Text("Open in Browser"),
                onTap: () async {
                  try {
                    if (!await launchUrl(Uri.parse(widget.newsUrl))) {
                      throw Exception('Could not launch ${widget.newsUrl}');
                    }
                  } catch (error) {
                    GlobalServices.instance.errorDialogue(
                        errorMessage: error.toString(), context: context);
                  } finally {
                    Navigator.pop(context);
                  }
                },
              ),
              //! refresh function
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text("Refresh"),
                onTap: () async {
                  try {
                    await _webController.reload();
                  } catch (error) {
                    GlobalServices.instance.errorDialogue(
                        errorMessage: error.toString(), context: context);
                  } finally {
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
