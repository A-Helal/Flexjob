library flutter_pw_validator;

import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_condition_helper.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_validation_text_widget.dart';
import 'package:flexiJobs/features/sign_up/presentation/widgets/pwd_validator/custom_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFlutterPwValidator extends StatefulWidget {
  CustomFlutterPwValidator(
      {required this.width,
      required this.height,
      required this.minLength,
      required this.onSuccess,
      required this.controller,
      this.secondcontroller,
      this.uppercaseCharCount = 0,
      this.lowercaseCharCount = 0,
      this.numericCharCount = 0,
      this.specialCharCount = 0,
      this.matches = 0,
      this.normalCharCount = 0,
      this.defaultColor = Palette.grey_A5A5A5,
      this.successColor = Palette.primaryColor,
      this.failureColor = Palette.grey_A5A5A5,
      this.strings,
      this.onFail,
      this.key}) {
    //Initial entered size for global use
  }
  final int minLength,
      normalCharCount,
      uppercaseCharCount,
      lowercaseCharCount,
      numericCharCount,
      matches,
      specialCharCount;
  final Color defaultColor, successColor, failureColor;
  final double width, height;
  final Function onSuccess;
  final Function? onFail;
  final TextEditingController controller;
  final TextEditingController? secondcontroller;
  final CustomFlutterPwValidatorStrings? strings;
  final Key? key;

  @override
  State<StatefulWidget> createState() => new CustomFlutterPwValidatorState();

  CustomFlutterPwValidatorStrings get translatedStrings => this.strings ?? CustomFlutterPwValidatorStrings();
}

@protected
class CustomFlutterPwValidatorState extends State<CustomFlutterPwValidator> {
  /// Estimate that this the first run or not
  late bool _isFirstRun;

  /// Variables that hold current condition states
  dynamic _hasMinLength,
      _hasMinNormalChar,
      _hasMinUppercaseChar,
      _hasMinLowercaseChar,
      _hasMinNumericChar,
      _matches,
      _hasMinSpecialChar;

  //Initial instances of ConditionHelper and Validator class
  late final CustomConditionsHelper _conditionsHelper;
  CustomValidator _validator = new CustomValidator();

  /// Get called each time that user entered a character in EditText
  void validate() {
    /// For each condition we called validators and get their new state
    _hasMinLength = _conditionsHelper.checkCondition(
        widget.minLength, _validator.hasMinLength, widget.controller, widget.translatedStrings.atLeast, _hasMinLength);

    _hasMinUppercaseChar = _conditionsHelper.checkCondition(
        widget.uppercaseCharCount,
        _validator.hasMinUppercaseAndHasMinLowerCase,
        userRequestedValues: <int>[widget.uppercaseCharCount, widget.lowercaseCharCount],
        widget.controller,
        widget.translatedStrings.uppercaseLettersAndLowerCase,
        _hasMinUppercaseChar);

    _hasMinNumericChar = _conditionsHelper.checkCondition(
        widget.numericCharCount,
        _validator.hasMinNumericCharAndHasMinSpecialChar,
        widget.controller,
        userRequestedValues: <int>[widget.numericCharCount, widget.specialCharCount],
        widget.translatedStrings.numericCharactersAndSpecialCharacters,
        _hasMinNumericChar);

    if (widget.secondcontroller != null)
      _matches = _conditionsHelper.checkConfirmMatch(
          widget.controller.text, widget.secondcontroller?.text, widget.translatedStrings.hasMatch, _matches ?? false);

    /// Checks if all condition are true then call the onSuccess and if not, calls onFail method
    int conditionsCount = _conditionsHelper.getter()!.length;
    int trueCondition = 0;
    for (bool value in _conditionsHelper.getter()!.values) {
      if (value == true) trueCondition += 1;
    }
    if (conditionsCount == trueCondition)
      widget.onSuccess();
    else if (widget.onFail != null) widget.onFail!();

    //To prevent from calling the setState() after dispose()
    if (!mounted) return;

    //Rebuild the UI
    setState(() => null);
    trueCondition = 0;
  }

  @override
  void initState() {
    super.initState();
    _isFirstRun = true;

    _conditionsHelper = CustomConditionsHelper(widget.translatedStrings);

    /// Sets user entered value for each condition
    _conditionsHelper.setSelectedCondition(widget.minLength, widget.normalCharCount, widget.uppercaseCharCount,
        widget.lowercaseCharCount, widget.numericCharCount, widget.specialCharCount, widget.matches);

    /// Adds a listener callback on TextField to run after input get changed
    widget.controller.addListener(() {
      _isFirstRun = false;
      validate();
    });
    if (widget.secondcontroller != null) {
      widget.secondcontroller?.addListener(() {
        _isFirstRun = false;
        validate();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: new Container(
        width: 1.sw,
        height: 120.h,
        child: new Column(
          children: <Widget>[
            // new Flexible(
            //   flex: 3,
            //   child: new Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       // Iterate through the conditions map values to check if there is any true values then create green ValidationBarComponent.
            //       for (bool value in _conditionsHelper.getter()!.values)
            //         if (value == true)
            //           new ValidationBarComponent(color: widget.successColor),

            //       // Iterate through the conditions map values to check if there is any false values then create red ValidationBarComponent.
            //       for (bool value in _conditionsHelper.getter()!.values)
            //         if (value == false)
            //           new ValidationBarComponent(color: widget.defaultColor)
            //     ],
            //   ),
            // ),
            new Column(

                //Iterate through the condition map entries and generate new ValidationTextWidget for each item in Green or Red Color
                children: _conditionsHelper.getter()!.entries.map((MapEntry<String, bool> entry) {
              int? value;
              if (entry.key == widget.translatedStrings.atLeast) value = widget.minLength;

              if (entry.key == widget.translatedStrings.uppercaseLettersAndLowerCase) value = widget.uppercaseCharCount;

              if (entry.key == widget.translatedStrings.numericCharactersAndSpecialCharacters)
                value = widget.numericCharCount;
              if (entry.key == widget.translatedStrings.hasMatch) value = widget.matches;

              return SizedBox(
                height: 30.h,
                child: new CustomValidationTextWidget(
                  color: _isFirstRun
                      ? widget.defaultColor
                      : entry.value
                          ? widget.successColor
                          : widget.failureColor,
                  text: entry.key,
                  value: value,
                ),
              );
            }).toList())
          ],
        ),
      ),
    );
  }
}
