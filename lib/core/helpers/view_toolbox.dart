import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flexiJobs/core/utils/log_utils.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:http/http.dart' as http;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:file_picker/file_picker.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:flexiJobs/core/di/dependency_init.dart';
import 'package:flexiJobs/core/routing/routes.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/core/theming/theme.dart';
import 'language_helper.dart';

enum ImageExtension { svg, png }

class ViewsToolbox {
  static Future<bool> checkConnection() async {
    List<ConnectivityResult> result = <ConnectivityResult>[];

    result = await Connectivity().checkConnectivity();

    if (result.first == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  static Future<File> convertBase64ToImage(String base64Str, String fileName) async {
    Uint8List bytes = base64Decode(base64Str);
    final Directory tempDir = await getTemporaryDirectory();
    File file = File('${tempDir.path}/$fileName.png');
    return await file.writeAsBytes(bytes);
  }

  static void dismissDialog({
    required BuildContext dialogContext,
  }) {
    Navigator.pop(dialogContext);
  }

  static void dismissLoading() {
    //CustomLoading.stop();

    EasyLoading.dismiss();
    // if (navigatorKey.currentContext!.canPop()) {
    //   Navigator.of(navigatorKey.currentContext!).pop();
    // }
  }

  static String getDiyarLogo(BuildContext context, {bool forcedLightTheme = false}) {
    if (forcedLightTheme) {
      return "assets/svg/diyar-logo-white.svg";
    } else {
      if (AppTheme.isDarkMode(context)) {
        if (LanguageHelper.isAr(context)) {
          return "assets/png/company_arabic_logo.png";
        } else {
          return "assets/svg/diyar-logo-white.svg";
        }
      } else {
        if (LanguageHelper.isAr(context)) {
          return "assets/png/company_arabic_logo.png";
        } else {
          return "assets/svg/diyar-logo.svg";
        }
      }
    }
  }

  //icon from base64 string
  static Widget iconFromBase64String(
    String base64String, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.string(
      base64String,
      width: width,
      height: height,
      color: color,
    );
  }

  static Image imageFromBase64String(
    String base64String, {
    double? width,
    double? height,
    Color? color,
    BoxFit? boxFit,
  }) {
    return Image.memory(
      base64Decode(base64String),
      width: width,
      height: height,
      color: color,
      fit: boxFit,
    );
  }

  static Future<Uint8List?> loadAndConvertAssetImageToPNG(String assetPath) async {
    try {
      // Load image data from assets as a ByteData object
      ByteData byteData = await rootBundle.load(assetPath);

      // Convert ByteData to Uint8List
      Uint8List imageData = byteData.buffer.asUint8List();

      // Decode the Uint8List into a ui.Image
      ui.Codec codec = await ui.instantiateImageCodec(imageData);
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      ui.Image image = frameInfo.image;

      // Convert the ui.Image to PNG ByteData
      ByteData? pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);

      return pngBytes!.buffer.asUint8List();
    } catch (e) {
      Log.e('Error loading and converting image: $e');
    }
    return null;
  }

  static Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> shareImageAndDelete(File imageFile, String fileName) async {
    try {
      final XFile xFile = XFile(imageFile.path);

      await Share.shareXFiles(
        <XFile>[xFile],
        text: '$fileName Contact',
      );
    } finally {
      if (await imageFile.exists()) {
        await imageFile.delete();
      }
    }
  }

  static void showAwesomeSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
    bool isWarning = false,
    bool isSuccess = false,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        duration: duration,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: AwesomeSnackbarContent(
          title: "",
          //title: "",          //color: Palette.secondaryGreen,
          message: message,
          color: isError
              ? Palette.darkRed
              : isWarning
                  ? Palette.orangeDark
                  : Palette.secondaryGreen,
          contentType: isError
              ? ContentType.failure
              : isWarning
                  ? ContentType.warning
                  : ContentType.success,
        ),
      ),
    );
  }

  static void showBottomSheet({
    double? height,
    Widget? widget,
    Widget? customWidget,
    BorderRadius? borderRadius,
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return customWidget ??
            Container(
              decoration: BoxDecoration(
                color: (AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!)
                    ? Palette.black
                    : Palette.white),
                borderRadius:
                    borderRadius ?? BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r)),
              ),
              height: height ?? 300.h,
              width: 1.sw,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildIndicator(),
                        ],
                      ),
                      widget ?? Container(),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }

  static void showCustomBottomSheet({
    double? height,
    Widget? customWidget,
    bool? removePadding = false,
    bool? isDismissible,
    BorderRadius? borderRadius,
    required BuildContext context,
  }) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      isDismissible: isDismissible ?? true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 50.h,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: (AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!)
                  ? Palette.semiLightBlack
                  : Palette.white),
              borderRadius: borderRadius ??
                  BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
            ),
            height: height ?? 300.h,
            width: 1.sw,
            child: (removePadding ?? false)
                ? customWidget
                : Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.h,
                    ),
                    child: customWidget,
                  ),
          ),
        );
      },
    );
  }

  // static void showWarningDialogContent(
  //   String warningtext,
  //   BuildContext? warningContext,
  //   Function() onCancelTap, {
  //   bool closeIconVisible = true,
  //   bool continueButtonVisible = true,
  //   String? cancelText,
  // }) {
  //   ViewsToolbox.showCustomDialog(
  //     dialogContext: Constant.navigatorKey.currentState!.context,
  //     getDialogContext: (BuildContext dialogContext) {
  //       warningContext = dialogContext;
  //     },
  //     backgroundImagePath: 'assets/images/popup-new-pattern.png',
  //     imageExtension: ImageExtension.png,
  //     showCloseIcon: closeIconVisible,
  //     widgets: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10.h),
  //         child: SvgPicture.asset(
  //           "assets/svg/cancel-joining-alert-icon.svg",
  //           width: 60.w,
  //         ),
  //       ),
  //       Text(
  //         warningtext,
  //         style: AppTheme.textTheme.bodyLarge,
  //         textAlign: TextAlign.center,
  //       ),
  //       25.heightBox,
  //       continueButtonVisible
  //           ? CustomElevatedButton(
  //               text: cancelText ?? "cancel-text".tr(),
  //               borderColor: Palette.black,
  //               textColor: Palette.lightBlack,
  //               backgroundColor: Palette.white,
  //               onPressed: () {
  //                 Navigator.pop(warningContext!);
  //                 onCancelTap();
  //               },
  //             )
  //           : Container(),
  //       20.heightBox,
  //     ],
  //   );
  // }

  // static void showSuccessDialogContent({
  //   String? text,
  //   BuildContext? successContext,
  //   Function()? onContinueTap,
  //   bool closeIconVisible = true,
  //   String? cancelText,
  // }) {
  //   ViewsToolbox.showCustomDialog(
  //     dialogContext: Constant.navigatorKey.currentState!.context,
  //     getDialogContext: (BuildContext dialogContext) {
  //       successContext = dialogContext;
  //     },
  //     backgroundImagePath: 'assets/images/popup-new-pattern.png',
  //     imageExtension: ImageExtension.png,
  //     showCloseIcon: closeIconVisible,
  //     widgets: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10.h),
  //         child: SvgPicture.asset(
  //           "assets/svg/success-dialog-icon.svg",
  //           width: 40.w,
  //         ),
  //       ),
  //       Text(
  //         text ?? "success-request".tr(),
  //         style: AppTheme.textTheme.bodyLarge,
  //         textAlign: TextAlign.center,
  //       ),
  //       20.heightBox,
  //       CustomElevatedButton(
  //         text: "continue-text".tr(),
  //         textColor: Palette.white,
  //         onPressed: () {
  //           Navigator.pop(successContext!);
  //           onContinueTap?.call();
  //         },
  //       ),
  //     ],
  //   );
  // }

  // static void showTimeOutDialogContent(
  //   String warningtext,
  //   BuildContext? warningContext,
  //   Function() onCancelTap, {
  //   bool closeIconVisible = false,
  //   String? cancelText,
  // }) {
  //   ViewsToolbox.showCustomDialog(
  //     dialogContext: Constant.navigatorKey.currentState!.context,
  //     getDialogContext: (BuildContext dialogContext) {
  //       warningContext = dialogContext;
  //     },
  //     backgroundImagePath: 'assets/images/popup-new-pattern.png',
  //     imageExtension: ImageExtension.png,
  //     showCloseIcon: closeIconVisible,
  //     widgets: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10.h),
  //         child: SvgPicture.asset(
  //           "assets/svg/cancel-joining-alert-icon.svg",
  //           width: 60.w,
  //         ),
  //       ),
  //       Text(
  //         warningtext,
  //         style: AppTheme.textTheme.bodyLarge,
  //         textAlign: TextAlign.center,
  //       ),
  //       25.heightBox,
  //       CustomElevatedButton(
  //         text: cancelText ?? "home-text".tr(),
  //         borderColor: Palette.black,
  //         textColor: Palette.lightBlack,
  //         backgroundColor: Palette.white,
  //         onPressed: () {
  //           Navigator.pop(warningContext!);
  //           Constant.navigatorKey.currentContext!
  //               .read<BottomNavigationCubit>()
  //               .changeIndex(0);
  //           Constant.navigatorKey.currentContext!.push(AppRoutes.bottomBar);
  //         },
  //       ),
  //       20.heightBox,
  //     ],
  //   );
  // }

  static Future<void> showCustomDialog({
    required BuildContext dialogContext,
    required List<Widget> widgets,
    required Function(BuildContext) getDialogContext,
    Function()? refresh,
    double? radius,
    String? logoImagePath,
    String? header,
    String? backgroundImagePath,
    ImageExtension? imageExtension,
    ImageExtension? logoExtension,
    Positioned? backgroundPositioned,
    bool showCloseIcon = false,
    Offset? backgroundImageOffset,
    Color? backgroundColorAlertDialog,
    bool? allowDismiss,
  }) async {
    if (refresh != null) {
      refresh();
    }
    final AlertDialog alert = AlertDialog(
      backgroundColor: backgroundColorAlertDialog,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 15.r),
      ),
      content: Directionality(
        textDirection: LanguageHelper.isAr(dialogContext) ? TextDirection.rtl : TextDirection.ltr,
        child: StatefulBuilder(
          builder: (BuildContext builderContext, StateSetter myState) {
            return Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                backgroundImagePath != null
                    ? Positioned(
                        top: backgroundPositioned?.top ?? -19.h,
                        left: 0,
                        right: 0,
                        child: imageExtension == ImageExtension.svg
                            ? SvgPicture.asset(
                                backgroundImagePath,
                              )
                            : Image.asset(
                                backgroundImagePath,
                              ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                showCloseIcon
                    ? Positioned(
                        left: LanguageHelper.isAr(dialogContext) ? -20.w : null,
                        right: LanguageHelper.isEN(dialogContext) ? -20.w : null,
                        top: -15.h,
                        child: IconButton(
                          onPressed: () => ViewsToolbox.dismissDialog(
                            dialogContext: builderContext,
                          ),
                          icon: Icon(
                            Icons.close,
                            textDirection: LanguageHelper.isAr(dialogContext) ? TextDirection.ltr : TextDirection.rtl,
                            size: 27.w,
                            color: AppTheme.isDarkMode(dialogContext) ? Palette.white : Palette.black,
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                header != null
                    ? Positioned(
                        top: 12.h,
                        left: 0,
                        right: 0,
                        child: AppText(
                          textAlign: TextAlign.center,
                          text: header,
                          fontSize: 28,
                          fontWeight: AppFontWeight.bold,
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                Padding(
                  padding: EdgeInsets.only(
                    top: header != null ? 40.h : 0.h,
                  ),
                  child: SizedBox(
                    width: 600.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widgets,
                    ),
                  ),
                ),
                logoImagePath != null
                    ? Transform.translate(
                        offset: LanguageHelper.isAr(dialogContext) ? Offset(-98.w, -96.h) : Offset(102.w, -97.h),
                        child: Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.white,
                          ),
                          child: Center(
                              child: logoExtension == ImageExtension.svg
                                  ? SvgPicture.asset(logoImagePath)
                                  : Image.asset(logoImagePath)),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ],
            );
          },
        ),
      ),
    );

    // show the dialog
    await showDialog(
      context: dialogContext,
      barrierDismissible: allowDismiss ?? false,
      builder: (BuildContext context) {
        getDialogContext(context);
        return alert;
      },
    );
  }

  static void showErrorAwesomeSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 2500),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: AwesomeSnackbarContent(
          title: "",
          //title: "",          //color: Palette.secondaryGreen,
          message: message,
          color: Palette.darkRed,

          contentType: ContentType.failure,
        ),
      ),
    );
  }

  static void showLoading({bool allowClicking = false}) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60.w
      ..textColor =
          AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!) ? Palette.semiLightBlack : Palette.white
      ..radius = 20
      ..backgroundColor =
          AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!) ? Palette.white : Palette.semiTextGrey
      ..maskColor = AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!)
          ? Palette.transparntColor
          : Palette.darkGray
      ..indicatorColor =
          AppTheme.isDarkMode(getIt<AppRouter>().navigatorKey.currentContext!) ? Palette.semiLightBlack : Palette.secondary
      ..userInteractions = false
      ..dismissOnTap = allowClicking
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.circle;
    EasyLoading.show(
      status: getIt<AppRouter>().navigatorKey.currentContext!.tr("loadingTextDialog"),
    );
    // CustomLoading(gif).start(
    //   Constant.navigatorKey.currentContext!,
    //   // overlayColor: Palette.greyBackgroundTheme.withOpacity(0.2),
    //   overlayColor: Colors.transparent,
    // );
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: navigatorKey.currentContext!,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return Container(
    //         child: Center(
    //           child: Image.asset(
    //             "assets/images/hawi.gif",
    //             width: 190.w,
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // });
  }

  static void showSuccessAwesomeSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 2500),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: AwesomeSnackbarContent(
          title: "",
          //title: "",          //color: Palette.secondaryGreen,
          message: message,
          color: Palette.secondaryGreen,
          contentType: ContentType.success,
        ),
      ),
    );
  }

  static void showWarningAwesomeSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 2500),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        content: AwesomeSnackbarContent(
          title: "",
          //title: "",          //color: Palette.secondaryGreen,
          message: message,
          color: Palette.orangeDark,

          contentType: ContentType.warning,
        ),
      ),
    );
  }

  static Container _buildIndicator() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      width: 70.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: Palette.secondary.withOpacity(.3),
        borderRadius: BorderRadius.circular(30.w),
      ),
    );
  }

  static showConfirmationDialog(
      {required BuildContext context,
      required String dialogMessage,
      required void Function() onConfirmCallback,
      String? dialogSubTitleMessage}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(24.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.info,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              AppText(
                text: context.tr(dialogMessage),
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              if (dialogSubTitleMessage != null)
                AppText(
                  text: context.tr(dialogSubTitleMessage),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add your confirmation logic here
              },
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.isDarkMode(context) ? Palette.black : Palette.white,
                // side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: AppText(
                text: context.tr('back'),
              ),
            ),
            CustomElevatedButton(width: 120.w, onPressed: onConfirmCallback, text: context.tr('confirm')),
          ],
        );
      },
    );
  }

  static AppBar showAppBar({required String title}) {
    return AppBar(
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => CustomMainRouter.pop(),
        child: Center(
          child: Transform.flip(
            flipX: LanguageHelper.isAr(getIt<AppRouter>().navigatorKey.currentContext!) ? true : false,
            child: Icon(Icons.arrow_back_ios,color: Palette.primaryColor,size: 20,),
          ),
        ),
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Palette.grey_91919140,
            height: 0.2,
          )),
      backgroundColor: Palette.transparntColor,
      title: AppText(style: AppTextStyle.semiBold_20, textColor: Palette.primaryColor, text: title),
    );
  }

  static AppBar JobDetailsAppBar(String path, BuildContext context) {
    return AppBar(
      toolbarHeight: 70.h,
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Palette.secondary, Palette.blue_9747FF]))),
          path.isEmpty
              ? Container()
              : Transform.translate(
                  offset: LanguageHelper.isAr(context) ? Offset(-0.35.sw, 60.h) : Offset(0.35.sw, 60.h),
                  child: SizedBox(
                    width: 110.w,
                    height: 120.h,
                    child: Card(
                      elevation: 2,
                      shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: CachedNetworkImage(
                            //  height: 200.h,
                            fit: BoxFit.contain,
                            imageUrl: ApiConstants.baseStorageUrlProd + path),
                      ),
                    ),
                  ),
                )
        ],
      ),
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r), bottomRight: Radius.circular(10.r))),
      leading: GestureDetector(
        onTap: () => CustomMainRouter.pop(),
        child: Center(
          child: Transform.flip(
            flipX: LanguageHelper.isAr(getIt<AppRouter>().navigatorKey.currentContext!) ? true : false,
            child: SvgPicture.asset(
              "assets/svg/arrow-left-circle.svg",
              colorFilter: ColorFilter.mode(Palette.white, BlendMode.srcIn),
              width: 25.w,
            ),
          ),
        ),
      ),
    );
  }

  static void selectDateOfBirth(
      {required BuildContext context, required dynamic Function(dynamic)? onSubmit, DateTime? initSelectDate}) {
    BottomPicker.date(
      buttonPadding: 10.w,
      displayCloseIcon: false,
      dismissable: true,
      pickerTitle: Container(),
      onSubmit: onSubmit,
      onCloseButtonPressed: () {
        Log.d('Picker closed');
      },
      buttonContent: AppText(
        textAlign: TextAlign.center,
        textColor: Palette.white,
        text: context.tr(AppLocalizationKeys.done),
      ),
      pickerTextStyle: TextStyle(
        color: Palette.primaryColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      buttonWidth: 200.w,
      buttonStyle: BoxDecoration(color: Palette.primaryColor, borderRadius: BorderRadius.all(Radius.circular(10.r))),
      minDateTime: DateTime(1930, 1, 1),
      maxDateTime: DateTime.now(),
      initialDateTime: initSelectDate,
    ).show(context);
  }

  static Future<void> launchUrlHelper(String url) async {
    final Uri url0 = Uri.parse(url);

    if (!await launchUrl(url0)) {
      throw Exception('Could not launch $url0');
    }
  }

  static Future<bool> checkCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return status.isGranted;
  }

  static Future<bool> checkPermision(Permission permission) async {
    PermissionStatus status = await permission.onPermanentlyDeniedCallback(() {
      openAppSettings();
    }).request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      PermissionStatus status = await permission.request();
      if (status.isGranted) {
        return true;
      }

      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      if (await permission.request().isGranted) {
        return true;
      }
      return false;
    } else {
      ViewsToolbox.showErrorAwesomeSnackBar(
        getIt<AppRouter>().navigatorKey.currentContext!,
        "permission-denied".tr(),
      );
      return false;
    }
  }

  static void showDefualtDialog(
      {required String title,
      required String message,
      required String onYesTapText,
      required String onNoTapText,
      required VoidCallback onYesTap,
      required BuildContext? dialogContext,
      required VoidCallback onNoTap}) {
    ViewsToolbox.showCustomDialog(
        dialogContext: dialogContext!,
        widgets: <Widget>[
          AppText(
            text: title,
            textColor: Palette.primaryColor,
            style: AppTextStyle.bold_17,
            textAlign: TextAlign.center,
          ),
          20.heightBox,
          AppText(
            text: message,
            textColor: Palette.black,
            style: AppTextStyle.medium_14,
            textAlign: TextAlign.center,
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomElevatedButton(
                onPressed: onYesTap,
                width: 0.33.sw,
                height: 30.h,
                showBorder: true,
                backgroundColor: Palette.transparntColor,
                borderColor: Palette.grey_F0F0F0,
                text: onYesTapText,
                textStyle: AppTextStyle.medium_12,
              ),
              10.widthBox,
              CustomElevatedButton(
                onPressed: onNoTap,
                width: 0.33.sw,
                backgroundColor: Palette.secondary,
                height: 30.h,
                text: onNoTapText,
                textStyle: AppTextStyle.medium_12,
              ),
            ],
          )
        ],
        getDialogContext: (BuildContext context) => dialogContext);
  }

  static Future<String> getIdFromScanQr() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#17165E", getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.cancel), false, ScanMode.QR);
    String decodedString = utf8.decode(base64.decode(barcodeScanRes));

    return json.decode(decodedString)["id"];
  }

  static Future<bool> auth() async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      bool isAuth = await auth.authenticate(
        localizedReason:
            getIt<AppRouter>().navigatorKey.currentContext!.tr(AppLocalizationKeys.scanYourFingerprintOrFaceID),
      );
      return isAuth;
    } on PlatformException catch (e) {
      if (e.code == 'NotAvailable' || e.code == 'notAvailable') {
        // Add handling of no hardware here.
      } else if (e.code == 'NotEnrolled' || e.code == 'notEnrolled') {
        // ...
      } else {
        // ...
      }
    }
    return false;
  }

  static Future<void> openMapWithCoords(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<PlatformFile> networkImageToPlatformFile(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception("Failed to load image from network");
    }

    final Directory tempDir = await getTemporaryDirectory();
    final String fileName = imageUrl.split('/').last;
    final String filePath = '${tempDir.path}/$fileName';

    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    final PlatformFile platformFile = PlatformFile(
      name: fileName,
      path: file.path,
      size: await file.length(),
      bytes: null,
    );

    return platformFile;
  }
}



