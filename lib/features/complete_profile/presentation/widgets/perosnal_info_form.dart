// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/phone_number.dart';

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
import 'package:flexiJobs/features/complete_profile/presentation/screens/personal_information_screen.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/phone_field.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/drop_down_field.dart';
import 'package:flexiJobs/features/shared/widgets/forms/text_field_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/upload_profile_picture.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';

class PerosnalInfoForm extends StatefulWidget {
  PerosnalInfoForm({
    Key? key,
    required this.viewMode,
    required this.formKey,
    required this.phoneNumber,
    required this.phoneCode,
    required this.phoneFoucsNode,
    required this.nationalIdFoucsNode,
    required this.nameFoucsNode,
    required this.adresssFoucsNode,
    required this.brithDateFoucsNode,
    required this.brithDate,
    required this.governorateFoucsNode,
    required this.cityFoucsNode,
    required this.gederFoucsNode,
  }) : super(key: key);

  final bool viewMode;
  final GlobalKey<FormBuilderState> formKey;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneCode = TextEditingController();
  TextEditingController brithDate = TextEditingController();
  FocusNode phoneFoucsNode;
  FocusNode nationalIdFoucsNode;
  FocusNode nameFoucsNode;
  FocusNode adresssFoucsNode;
  FocusNode brithDateFoucsNode;
  FocusNode governorateFoucsNode;
  FocusNode cityFoucsNode;
  FocusNode gederFoucsNode;
  @override
  State<PerosnalInfoForm> createState() => _PerosnalInfoFormState();
}

class _PerosnalInfoFormState extends State<PerosnalInfoForm> with AutomaticKeepAliveClientMixin {
  DateTime _selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _phoneCode = TextEditingController();
  List<GovernorateEntity> governorates = <GovernorateEntity>[];
  List<String> genders = <String>[
    "Male",
    "Female",
  ];
  List<CityEntity> cities = <CityEntity>[];
  bool _enableCitiesDropDown = false;
  int? _selectedCity;
  int? _selectGovernate;
  String path = "";
  bool hasImage = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration _) async {
      governorates = await LocalData.getGovernorates();

      if (LocalData.user != null) {
        if (LocalData.user!.birthdate != null) {
          widget.brithDate.text = LocalData.user!.birthdate!;
        }

        if (LocalData.user!.phoneNumber != null) {
          widget.phoneNumber.text = LocalData.user!.phoneNumber!;
        }
        if (LocalData.user!.phoneCode != null && LocalData.user!.phoneCode!.isNotEmpty) {
          widget.phoneNumber.text = LocalData.user!.phoneNumber!;
          widget.phoneCode.text = LocalData.user!.phoneCode!;
        } else {
          // Default to Egypt country code matching the phone field default
          widget.phoneCode.text = '+20';
        }

        _enableCitiesDropDown = true;
        if (LocalData.user!.governorateId != null) {
          cities = governorates
              .firstWhere((GovernorateEntity governorate) => governorate.id == LocalData.user!.governorateId)
              .cities!;
        }
      }
      setState(() {});

      // Initialize form fields with existing user data after form is built
      // This ensures they're registered in form state even if user doesn't interact with them
      // Wait for multiple frames to ensure form is fully built
      await Future.delayed(const Duration(milliseconds: 300));
      _initializeFormFields();
    });
    super.initState();
  }

  void _initializeFormFields() {
    if (LocalData.user != null && widget.formKey.currentState != null && mounted) {
      final fields = widget.formKey.currentState!.fields;

      // Debug: Print which fields exist

      if (LocalData.user!.name != null) {
        if (fields[PersonalInformationFormConstants.fullName] != null) {
          fields[PersonalInformationFormConstants.fullName]!.didChange(LocalData.user!.name);
        } else {
        }
      }

      if (LocalData.user!.gender != null) {
        final genderValue = LocalData.user!.gender == "male" ? "Male" : "Female";
        if (fields[PersonalInformationFormConstants.gender] != null) {
          fields[PersonalInformationFormConstants.gender]!.didChange(genderValue);
        } else {
        }
      }

      if (LocalData.user!.birthdate != null) {
        if (fields[PersonalInformationFormConstants.birth] != null) {
          fields[PersonalInformationFormConstants.birth]!.didChange(LocalData.user!.birthdate);
        } else {
        }
      }

      if (LocalData.user!.nationalId != null) {
        if (fields[PersonalInformationFormConstants.nationalId] != null) {
          fields[PersonalInformationFormConstants.nationalId]!.didChange(LocalData.user!.nationalId);
        } else {
        }
      }

      if (LocalData.user!.address != null) {
        if (fields[PersonalInformationFormConstants.address] != null) {
          fields[PersonalInformationFormConstants.address]!.didChange(LocalData.user!.address);
        } else {
        }
      }

      if (LocalData.user!.governorateId != null) {
        if (fields[PersonalInformationFormConstants.governorate] != null) {
          fields[PersonalInformationFormConstants.governorate]!.didChange(LocalData.user!.governorateId);
        } else {
        }
      }

      if (LocalData.user!.cityId != null) {
        if (fields[PersonalInformationFormConstants.city] != null) {
          fields[PersonalInformationFormConstants.city]!.didChange(LocalData.user!.cityId);
        } else {
        }
      }

    } else {
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
          TextFieldWidget(
            onTap: () {
              unFoucsAll();
              widget.nameFoucsNode.requestFocus();
            },
            focusNode: widget.nameFoucsNode,
            disabled: false,
            initalValue: LocalData.user?.name ?? null,
            keyName: PersonalInformationFormConstants.fullName,
            labelAboveField: context.tr(AppLocalizationKeys.fullName),
            hintText: context.tr(AppLocalizationKeys.fullName),
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(),
            ]),
          ),
          widget.viewMode ? Container() : 10.heightBox,
          widget.viewMode
              ? Container()
              : AppText(
                  text: context.tr(AppLocalizationKeys.fullNameDescription),
                  textColor: Palette.secondary,
                  style: AppTextStyle.medium_13,
                ),
          20.heightBox,
          CustomDropDownField<String>(
            initialValue: LocalData.user?.gender != null
                ? LocalData.user?.gender == "male"
                    ? "Male"
                    : "Female"
                : null,
            disableFiled: false,
            focusNode: widget.gederFoucsNode,
            labelAboveField: context.tr(AppLocalizationKeys.gender),
            keyName: PersonalInformationFormConstants.gender,
            labelText: context.tr(AppLocalizationKeys.gender),
            validator: (String? value) => AppValidator.validatorRequired(
              value,
              context,
            ),
            onOpen: (bool open) {
              if (open) {
                unFoucsAll();
                widget.gederFoucsNode.requestFocus();
              }
            },
            disableSearch: true,
            onChanged: (String? id) {
              setState(() {});
            },
            itemsSearchable: genders.map((String gender) => <String, String>{context.tr(gender): gender}).toList(),
            items: genders
                .map((String gender) => DropdownMenuItem<String>(
                      child: AppText(
                        text: gender == "Male"
                            ? context.tr(AppLocalizationKeys.male)
                            : context.tr(AppLocalizationKeys.female),
                      ),
                      value: gender,
                    ))
                .toList(),
          ),
          20.heightBox,
          TextFieldWidget(
            focusNode: widget.brithDateFoucsNode,
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(),
            ]),
            textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: Colors.black),
            readOnly: true,
            disabled: false,
            onTap: () {
              unFoucsAll();
              widget.brithDateFoucsNode.requestFocus();

              // Parse the current date from the input, or use today if empty
              DateTime initialDate = DateTime.now();
              if (widget.brithDate.text.isNotEmpty) {
                try {
                  initialDate = DateFormat("y-MM-dd", "en").parse(widget.brithDate.text);
                } catch (e) {
                  initialDate = DateTime.now();
                }
              }

              ViewsToolbox.selectDateOfBirth(
                  context: context,
                  onSubmit: (dynamic date) {
                    setState(() {
                      _selectedDate = date;
                      widget.brithDate.text = DateFormat("y-MM-dd", "en").format(date);
                      // Update the form field value
                      widget.formKey.currentState?.fields[PersonalInformationFormConstants.birth]?.didChange(widget.brithDate.text);
                    });
                  },
                  initSelectDate: initialDate);
            },
            keyName: PersonalInformationFormConstants.birth,
            labelAboveField: context.tr(AppLocalizationKeys.dateBirth),
            hintText: context.tr(AppLocalizationKeys.dateBirthHint),
            controller: widget.brithDate,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SvgPicture.asset("assets/svg/calendar_icon.svg"),
            ),
          ),
          20.heightBox,
          AppText(
            text: context.tr(AppLocalizationKeys.phoneNumber),
            textColor: Palette.primaryColor,
            style: AppTextStyle.semiBold_16,
          ),
          10.heightBox,
          _PhoneFieldWrapper(
            key: const ValueKey('phone_field_wrapper'),
            onTap: () {
              unFoucsAll();
              widget.phoneFoucsNode.requestFocus();
            },
            focusNode: widget.phoneFoucsNode,
            initialValue: LocalData.user!.phoneNumber?[0] == "0"
                ? LocalData.user!.phoneNumber!.substring(1)
                : LocalData.user!.phoneNumber ?? null,
            phoneCode: LocalData.user!.phoneCode ?? null,
            keyName: PersonalInformationFormConstants.phone,
            onChanged: (PhoneNumber phone) {
              widget.phoneNumber.text = phone.number;
              widget.phoneCode.text = phone.countryCode;
            },
          ),
          20.heightBox,
          TextFieldWidget(
            onTap: () {
              unFoucsAll();
              widget.nationalIdFoucsNode.requestFocus();
            },
            focusNode: widget.nationalIdFoucsNode,
            maxLength: 14,
            disabled: false,
            initalValue: LocalData.user?.nationalId ?? null,
            keyName: PersonalInformationFormConstants.nationalId,
            keyboardType: TextInputType.number,
            labelAboveField: context.tr(AppLocalizationKeys.nationalId),
            hintText: context.tr(AppLocalizationKeys.nationalId),
            validator: FormBuilderValidators.compose(
                <FormFieldValidator<String>>[FormBuilderValidators.required(), FormBuilderValidators.minLength(14)]),
          ),
          20.heightBox,
          TextFieldWidget(
            onTap: () {
              unFoucsAll();
              widget.adresssFoucsNode.requestFocus();
            },
            focusNode: widget.adresssFoucsNode,
            initalValue: LocalData.user!.address ?? null,
            keyName: PersonalInformationFormConstants.address,
            labelAboveField: context.tr(AppLocalizationKeys.address),
            hintText: context.tr(AppLocalizationKeys.addressHint),
            validator: FormBuilderValidators.compose(<FormFieldValidator<String>>[
              FormBuilderValidators.required(),
            ]),
          ),
          20.heightBox,
          CustomDropDownField<int>(
            disableFiled: false,
            focusNode: widget.governorateFoucsNode,
            initialValue: _selectGovernate ?? LocalData.user!.governorateId ?? null,
            keyName: PersonalInformationFormConstants.governorate,
            labelText: context.tr(AppLocalizationKeys.government),
            validator: (int? value) => AppValidator.validatorRequired(
              value,
              context,
            ),
            onOpen: (bool open) {
              if (open) {
                unFoucsAll();
                widget.governorateFoucsNode.requestFocus();
              }
            },
            onChanged: (int? id) {
              setState(() {
                _enableCitiesDropDown = true;

                _selectGovernate = id;
                cities = governorates.firstWhere((GovernorateEntity governorate) => governorate.id == id).cities!;
                // _selectedCity = cities[0].id;
              });
            },

            itemsSearchable: governorates
                .map((GovernorateEntity governorate) => <String, int>{governorate.name!: governorate.id!})
                .toList(),
            items: governorates
                .map((GovernorateEntity governorate) => DropdownMenuItem<int>(
                      child: AppText(
                        text: governorate.name,
                      ),
                      value: governorate.id,
                    ))
                .toList(),
          ),
          20.heightBox,
          CustomDropDownField<int>(
            focusNode: widget.cityFoucsNode,
            initialValue: _selectedCity ?? LocalData.user!.cityId ?? null,
            keyName: PersonalInformationFormConstants.city,
            labelText: context.tr(AppLocalizationKeys.city),
            validator: (int? value) => AppValidator.validatorRequired(
              value,
              context,
            ),
            onChanged: (int? id) {
              _selectedCity = id;
              setState(() {});
            },
            onOpen: (bool open) {
              if (open) {
                unFoucsAll();
                widget.cityFoucsNode.requestFocus();
              }
            },
            disableFiled: !_enableCitiesDropDown,
            itemsSearchable: cities.map((CityEntity city) => <String, int>{city.name!: city.id!}).toList(),
            items: cities
                .map((CityEntity city) => DropdownMenuItem<int>(
                      child: AppText(
                        text: city.name!,
                      ),
                      value: city.id!,
                    ))
                .toList(),
          ),
          20.heightBox,
        ],
      ),
    );
  }

  unFoucsAll({bool isPhone = false}) {
    // widget.adresssFoucsNode.unfocus();
    // widget.brithDateFoucsNode.unfocus();
    // widget.nameFoucsNode.unfocus();
    // widget.nationalIdFoucsNode.unfocus();
    // widget.phoneFoucsNode.unfocus();
    //  FocusScope.of(context).unfocus();
  }

  @override
  bool get wantKeepAlive => true;
}

// Wrapper widget to prevent phone field from rebuilding
class _PhoneFieldWrapper extends StatefulWidget {
  const _PhoneFieldWrapper({
    Key? key,
    required this.onTap,
    required this.focusNode,
    required this.initialValue,
    required this.phoneCode,
    required this.keyName,
    required this.onChanged,
  }) : super(key: key);

  final Function() onTap;
  final FocusNode focusNode;
  final String? initialValue;
  final String? phoneCode;
  final String keyName;
  final void Function(PhoneNumber) onChanged;

  @override
  State<_PhoneFieldWrapper> createState() => _PhoneFieldWrapperState();
}

class _PhoneFieldWrapperState extends State<_PhoneFieldWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PhoneField(
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      initialValue: widget.initialValue,
      phoneCode: widget.phoneCode,
      keyName: widget.keyName,
      onChanged: widget.onChanged,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
