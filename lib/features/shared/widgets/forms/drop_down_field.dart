import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';

class CustomDropDownField<T> extends StatefulWidget {
  const CustomDropDownField(
      {super.key,
      required this.keyName,
      this.initialValue,
      required this.labelText,
      required this.items,
      this.menuMaxHeight,
      this.validator,
      this.onChanged,
      this.labelAboveField,
      this.itemsSearchable,
      this.disableFiled = false,
      this.onOpen,
      this.disableSearch = false,
      this.isNotRequired = false,
      this.focusNode});
  final String keyName;
  final T? initialValue;
  final String labelText;
  final List<DropdownMenuItem<T>> items;
  final List<Map<String, T>>? itemsSearchable;
  final String? Function(T?)? validator;
  final String? labelAboveField;
  final double? menuMaxHeight;
  final bool disableSearch;
  final void Function(T?)? onChanged;

  final void Function(bool)? onOpen;
  final bool? disableFiled;
  final bool? isNotRequired;
  final FocusNode? focusNode;

  @override
  State<CustomDropDownField<T>> createState() => _CustomDropDownFieldState<T>();
}

class _CustomDropDownFieldState<T> extends State<CustomDropDownField<T>> {
  T? selectedInialValue;
  final TextEditingController textEditingController = TextEditingController();
  // final GlobalKey<DropdownButton2State> dropDownKey =
  //     GlobalKey<DropdownButton2State>();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedInialValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.labelAboveField != null)
          AppText(
            text: widget.labelAboveField,
            style: AppTextStyle.semiBold_16,
          ),
        10.heightBox,
        DropdownButtonHideUnderline(
          child: FormBuilderField<T>(
            validator: widget.isNotRequired!
                ? null
                : widget.validator ??
                    (T? value) {
                      if (value == null) {
                        return 'emptyError'.tr();
                      }
                      return null;
                    },
            onChanged: (T? value) {
              //dropDownKey.currentState?.did;
              setState(() {
                selectedInialValue = value != null ? value : null;
              });
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            enabled: !(widget.disableFiled ?? false),
            initialValue: widget.initialValue,
            name: widget.keyName,
            builder: (FormFieldState<T> fieldState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MediaQuery.removePadding(
                    context: context,
                    removeBottom: true,
                    child: DropdownButtonFormField2<T>(
                      // dropdownButtonKey: dropDownKey,
                      focusNode: widget.focusNode,
                      isExpanded: true,
                      isDense: true,

                      onChanged: widget.disableFiled!
                          ? null
                          : (T? value) {
                              widget.onChanged?.call(value);
                              //Log.d("Selected Item");
                              fieldState.didChange(value);
                            },
                      // menuMaxHeight: widget.menuMaxHeight ?? 300,
                      // iconEnabledColor: Palette.primaryColor,
                      // iconDisabledColor: Palette.primaryColor,
                      //   dropdownStyleData: const DropdownStyleData(
                      //   maxHeight: 200,
                      // ),

                      dropdownStyleData: DropdownStyleData(
                        maxHeight: widget.menuMaxHeight ?? 600.h,
                      ),

                      dropdownSearchData: widget.disableSearch
                          ? null
                          : DropdownSearchData<T>(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  // expands: true,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: context.tr("searchHere"),
                                  ),
                                ),
                              ),
                              searchMatchFn: (DropdownMenuItem<T> item, String searchValue) {
                                return widget.itemsSearchable!
                                    .firstWhere(
                                      (Map<String, T> element) => element.values.first == item.value,
                                    )
                                    .keys
                                    .first
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase());
                              },
                            ),

                      onMenuStateChange: (bool isOpen) {
                        widget.onOpen?.call(isOpen);
                        if (!isOpen) {
                          if (textEditingController.text.isNotEmpty) textEditingController.clear();
                        }
                      },

                      // menuItemStyleData: MenuItemStyleData(
                      //   height: widget.menuMaxHeight ?? 300,
                      // ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18.h,
                          horizontal: 20.w,
                        ),
                        hintText: widget.labelText,
                      ),
                      value: selectedInialValue,

                      items: widget.items,
                    ),
                  ),
                  if (fieldState.hasError)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        5.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppText(
                            text: fieldState.errorText,
                            style: AppTextStyle.regular_14,
                            textColor: Palette.darkRed,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class CustomDropDownModel<T> extends Equatable {
  const CustomDropDownModel({required this.text, required this.value});

  final String text;
  final T value;

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[
        text,
        value,
      ];
}
