import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/constants/general_constants.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'no_internet_connection.dart';

class MasterWidget extends StatefulWidget {
  const MasterWidget({
    super.key,
    this.path,
    this.patternExtension,
    required this.widget,
    this.patternHeight,
    this.hasScroll = true,
    this.hasFoucs = false,
    this.hasInternet,
    this.isSupportOffline = false,
    this.screenTitle,
    this.appBar,
    this.showActionsIcon = true,
    this.showLeading = true,
    this.floatingActionButton,
    this.scaffoldColor,
    this.scrollController,
  });

  final Widget? floatingActionButton;
  final String? path;
  final PatternExtension? patternExtension;
  final Widget widget;
  final double? patternHeight;
  final bool? hasScroll;
  final bool? hasFoucs;
  final bool? isSupportOffline;
  final Function(bool)? hasInternet;
  final String? screenTitle;
  final AppBar? appBar;
  final bool showActionsIcon;
  final Color? scaffoldColor;
  final bool showLeading;
  final ScrollController? scrollController;
  @override
  State<MasterWidget> createState() => _MasterWidgetState();
}

enum PatternExtension { png, svg }

class _MasterWidgetState extends State<MasterWidget> {
  List<ConnectivityResult> connectionResult = <ConnectivityResult>[];
  ValueNotifier<bool> hasInternet = ValueNotifier<bool>(true);
  late StreamSubscription<bool> keyboardSubscription;
  ValueNotifier<bool> isKeyboardVisible = ValueNotifier<bool>(false);
  final KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) async {
      hasInternet.value = await ViewsToolbox.checkConnection();
    });

    // Log the initial keyboard visibility state.

    // Subscribe to keyboard visibility changes.
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      isKeyboardVisible.value = visible;

    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    hasInternet.dispose();
    isKeyboardVisible.dispose();
    super.dispose();
  }

  bool _isOffline(List<ConnectivityResult>? results) =>
      results != null && results.isNotEmpty && results.every((ConnectivityResult result) => result == ConnectivityResult.none);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: widget.scaffoldColor,
          floatingActionButton: widget.floatingActionButton,
          appBar: widget.appBar,

          //  backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Container(
              width: 1.sw,
              child: StreamBuilder<List<ConnectivityResult>>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (BuildContext context, AsyncSnapshot<List<ConnectivityResult>> snapshot) {
                    final bool isOffline = _isOffline(snapshot.data);
                    if (snapshot.data != null) {
                      if (isOffline) {
                        ViewsToolbox.dismissLoading();
                        GeneralConstants.hasConnection = false;

                        widget.hasInternet?.call(false);
                        if (GeneralConstants.hasConnection == true) {
                          GeneralConstants.hasConnection = false;
                        }
                      } else {
                        hasInternet.value = true;

                        if (hasInternet.value && GeneralConstants.hasConnection == false) {
                          widget.hasInternet?.call(true);
                        }
                        if (GeneralConstants.hasConnection == false) {
                          GeneralConstants.hasConnection = true;
                        }
                      }
                    }
                    return ValueListenableBuilder<bool>(
                      valueListenable: hasInternet,
                      builder: (BuildContext context, bool value, Widget? child) => widget.hasScroll!
                          ? SingleChildScrollView(
                              controller: widget.scrollController,
                              reverse: isKeyboardVisible.value ? true : false,
                              child: widget.isSupportOffline!
                                  ? widget.widget
                                  : isOffline || !hasInternet.value
                                      ? const NoInternetConnection()
                                      : widget.widget,
                            )
                          : widget.isSupportOffline!
                              ? widget.widget
                              : isOffline || !hasInternet.value
                                  ? const NoInternetConnection()
                                  : widget.widget,
                    );
                  }),
            ),
          )),
    );
  }
}
