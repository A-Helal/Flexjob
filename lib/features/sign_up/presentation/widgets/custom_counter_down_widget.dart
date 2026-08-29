import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/index.dart';

typedef CountdownTimerWidgetBuilder = Widget Function(BuildContext context, CurrentRemainingTime? time);

/// A Countdown.
class CustomCounterDownWidget extends StatefulWidget {
  CustomCounterDownWidget({
    Key? key,
    this.endWidget = const Center(
      child: Text('The current time has expired'),
    ),
    this.widgetBuilder,
    this.controller,
    this.textStyle,
    this.endTime,
    this.onEnd,
  })  : assert(endTime != null || controller != null),
        super(key: key);

  ///Widget displayed after the countdown
  final Widget endWidget;

  ///Used to customize the countdown style widget
  final CountdownTimerWidgetBuilder? widgetBuilder;

  ///Countdown controller, can end the countdown event early
  final CountdownTimerController? controller;

  ///Countdown text style
  final TextStyle? textStyle;

  ///Event called after the countdown ends
  final VoidCallback? onEnd;

  ///The end time of the countdown.
  final int? endTime;

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CustomCounterDownWidget> {
  late CountdownTimerController controller;

  CurrentRemainingTime? get currentRemainingTime => controller.currentRemainingTime;

  Widget get endWidget => widget.endWidget;

  CountdownTimerWidgetBuilder get widgetBuilder => widget.widgetBuilder ?? builderCountdownTimer;

  TextStyle? get textStyle => widget.textStyle;

  @override
  void initState() {
    super.initState();
    initController();
  }

  ///Generate countdown controller.
  initController() {
    controller = widget.controller ?? CountdownTimerController(endTime: widget.endTime!, onEnd: widget.onEnd);
    if (controller.isRunning == false) {
      controller.start();
    }
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // @override
  // void didUpdateWidget(CustomCounterDownWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.endTime != widget.endTime || widget.controller != oldWidget.controller) {
  //     controller.dispose();
  //     initController();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(context, currentRemainingTime);
  }

  Widget builderCountdownTimer(BuildContext context, CurrentRemainingTime? time) {
    if (time == null) {
      return endWidget;
    }
    String value = '';
    if (time.days != null) {
      String days = _getNumberAddZero(time.days!);
      value = '$value$days days ';
    }
    String hours = _getNumberAddZero(time.hours ?? 0);
    value = '$value$hours : ';
    String min = _getNumberAddZero(time.min ?? 0);
    value = '$value$min : ';
    String sec = _getNumberAddZero(time.sec ?? 0);
    value = '$value$sec';
    return Text(
      value,
      textAlign: TextAlign.left,
      style: textStyle,
    );
  }

  /// 1 -> 01
  String _getNumberAddZero(int number) {
    if (number < 10) {
      return "0" + number.toString();
    }
    return number.toString();
  }
}
