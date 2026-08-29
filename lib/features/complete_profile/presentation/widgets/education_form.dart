import 'package:flexiJobs/features/complete_profile/presentation/screens/personal_information_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/domain/entities/city_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/app_validator.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/phone_field.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/drop_down_field.dart';
import 'package:flexiJobs/features/shared/widgets/forms/text_field_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/upload_profile_picture.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/phone_number.dart';

class EducationInfoForm extends StatefulWidget {
  const EducationInfoForm(
      {super.key,
      this.viewMode = false,
      required this.formKey,
      required this.facultyFoucsNode,
      required this.universtityFoucsNode,
      required this.majorFoucsNode});

  final bool viewMode;
  final GlobalKey<FormBuilderState> formKey;

  final FocusNode facultyFoucsNode;
  final FocusNode majorFoucsNode;
  final FocusNode universtityFoucsNode;
  @override
  State<EducationInfoForm> createState() => _EducationInfoFormState();
}

class _EducationInfoFormState extends State<EducationInfoForm> with AutomaticKeepAliveClientMixin {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _phoneCode = TextEditingController();
  List<GovernorateEntity> universities = <GovernorateEntity>[];
  bool _showCustomUniversityField = false;
  List<Map<String, int>>? _cachedItemsSearchable;
  List<DropdownMenuItem<int>>? _cachedDropdownItems;
  int? _cachedInitialUniversityId;

  // Cache validator to prevent recreation on every build
  List<FormFieldValidator<String>>? _universityNameValidators;

  List<FormFieldValidator<String>> get universityNameValidators {
    _universityNameValidators ??= <FormFieldValidator<String>>[
      FormBuilderValidators.required(),
      (String? value) {
        if (value != null && value.trim().isEmpty) {
          return context.tr('emptyError');
        }
        return null;
      },
    ];
    return _universityNameValidators!;
  }

  List<String> genders = <String>[
    AppLocalizationKeys.male,
    AppLocalizationKeys.female,
  ];
  List<CityEntity> cities = <CityEntity>[];
  bool _enableCitiesDropDown = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) async {
      final loadedUniversities = await LocalData.getUniversites();

      // Create a new list and remove duplicates based on ID
      final Map<int, GovernorateEntity> uniqueMap = {};
      for (var uni in loadedUniversities) {
        if (uni.id != null) {
          uniqueMap[uni.id!] = uni;
        }
      }
      universities = uniqueMap.values.toList();

      // Cache dropdown items to prevent rebuilding on every render
      _cachedItemsSearchable = universities.map((GovernorateEntity uni) => <String, int>{uni.name!: uni.id!}).toList();
      _cachedDropdownItems = universities
          .map((GovernorateEntity uni) => DropdownMenuItem<int>(
                child: AppText(
                  text: uni.name!,
                ),
                value: uni.id!,
              ))
          .toList();

      // Cache initial university value check
      if (LocalData.user!.universityId != null && universities.any((uni) => uni.id == LocalData.user!.universityId)) {
        _cachedInitialUniversityId = LocalData.user!.universityId;
      }

      setState(() {});

      // Initialize form fields with existing user data after form is built
      // This ensures they're registered in form state even if user doesn't interact with them
      await Future.delayed(const Duration(milliseconds: 300));
      _initializeFormFields();
    });
    super.initState();
  }

  // Helper method to check if a university is the "Other" option
  bool _isOtherOption(int? universityId) {
    if (universityId == null) return false;
    final university = universities.firstWhere(
      (uni) => uni.id == universityId,
      orElse: () => GovernorateEntity(),
    );
    // Check if the name matches "Other" in English or Arabic
    return university.name?.toLowerCase() == 'other' ||
           university.name?.toLowerCase() == 'others' ||
           university.name == 'أخرى' ||
           university.name == 'اخرى';
  }

  void _initializeFormFields() {
    if (LocalData.user != null && widget.formKey.currentState != null && mounted) {
      final fields = widget.formKey.currentState!.fields;

      // Only set university if it exists in the loaded universities list
      if (LocalData.user!.universityId != null &&
          fields[PersonalInformationFormConstants.university] != null &&
          universities.any((uni) => uni.id == LocalData.user!.universityId)) {
        fields[PersonalInformationFormConstants.university]!.didChange(LocalData.user!.universityId);

        // Show custom field if "Other" option is selected
        if (_isOtherOption(LocalData.user!.universityId)) {
          setState(() {
            _showCustomUniversityField = true;
          });

          // Set the custom university name value after a short delay to ensure field is built
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && LocalData.user!.universityName != null) {
              widget.formKey.currentState?.fields[PersonalInformationFormConstants.universityName]
                  ?.didChange(LocalData.user!.universityName);
            }
          });
        }
      }

      if (LocalData.user!.universityFaculty != null && fields[PersonalInformationFormConstants.faculty] != null) {
        fields[PersonalInformationFormConstants.faculty]!.didChange(LocalData.user!.universityFaculty);
      }

      if (LocalData.user!.universityMajor != null && fields[PersonalInformationFormConstants.major] != null) {
        fields[PersonalInformationFormConstants.major]!.didChange(LocalData.user!.universityMajor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          20.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.collage),
            textColor: Palette.primaryColor,
            style: AppTextStyle.semiBold_16,
          ),
          10.heightBox,
          if (universities.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
              decoration: BoxDecoration(
                border: Border.all(color: Palette.grey_C6C6C6),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AppText(
                text: context.tr(AppLocalizationKeys.collage),
                textColor: Palette.grey_919191,
                style: AppTextStyle.regular_14,
              ),
            )
          else
            CustomDropDownField<int>(
              key: ValueKey('university_dropdown_${universities.length}'),
              focusNode: widget.universtityFoucsNode,
              initialValue: _cachedInitialUniversityId,
              keyName: PersonalInformationFormConstants.university,
              labelText: context.tr(AppLocalizationKeys.collage),
              validator: (int? value) => AppValidator.validatorRequired(value, context),
              onChanged: (int? value) {
                final isOther = _isOtherOption(value);

                if (value != null) {
                  final selectedUni = universities.firstWhere(
                    (uni) => uni.id == value,
                    orElse: () => GovernorateEntity(),
                  );
                }

                // Always clear the custom university name field when changing selection
                widget.formKey.currentState?.fields[PersonalInformationFormConstants.universityName]?.didChange('');

                setState(() {
                  _showCustomUniversityField = isOther;
                });
              },
              onOpen: (bool open) {
                if (open) {

                widget.universtityFoucsNode.requestFocus();
                }
              },
              disableSearch: true,
              itemsSearchable: _cachedItemsSearchable ?? [],
              items: _cachedDropdownItems ?? [],
            ),
          if (_showCustomUniversityField) ...[
            20.heightBox,
            TextFieldWidget(
              key: const ValueKey('custom_university_name_field'),
              keyName: PersonalInformationFormConstants.universityName,
              labelAboveField: context.tr(AppLocalizationKeys.universityName),
              hintText: context.tr(AppLocalizationKeys.universityNameHint),
              validator: FormBuilderValidators.compose(universityNameValidators),
            ),
          ],
          20.heightBox,
          TextFieldWidget(
            onTap: () {

              widget.facultyFoucsNode.requestFocus();
            },
            focusNode: widget.facultyFoucsNode,
            initalValue: LocalData.user!.universityFaculty ?? null,
            keyName: PersonalInformationFormConstants.faculty,
            labelAboveField: context.tr(AppLocalizationKeys.faculty),
            hintText: context.tr(AppLocalizationKeys.faculty),
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(),
            ]),
          ),
          20.heightBox,
          TextFieldWidget(
            onTap: () {
           
              widget.majorFoucsNode.requestFocus();
            },
            focusNode: widget.majorFoucsNode,
            initalValue: LocalData.user!.universityMajor ?? null,
            keyName: PersonalInformationFormConstants.major,
            labelAboveField: context.tr(AppLocalizationKeys.major),
            hintText: context.tr(AppLocalizationKeys.major),
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(),
            ]),
          ),
          70.heightBox,
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
