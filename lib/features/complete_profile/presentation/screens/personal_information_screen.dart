import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/app_data/domain/entities/city_entity.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_personal_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/confirm_to_update_profile.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/education_form.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/perosnal_info_form.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/upload_profile_picture.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flexiJobs/features/shifts/presentation/screens/shifts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProfileInfo {
  personal,
  education,
}

@RoutePage()
class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen(
      {super.key, required this.completeProfileCubit, this.viewMode = false, this.fromUpdatePopup = false});
  final CompleteProfileCubit completeProfileCubit;
  final bool viewMode;
  final bool fromUpdatePopup;
  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  GlobalKey<FormBuilderState> _educationKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> _perosonalKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _phoneCode = TextEditingController();
  TextEditingController _brithDate = TextEditingController();
  List<GovernorateEntity> governorates = <GovernorateEntity>[];
  FocusNode _phoneFoucsNode = FocusNode();
  FocusNode _brithDateFoucsNode = FocusNode();
  FocusNode _nationalIdFoucsNode = FocusNode();
  FocusNode _nameFoucsNode = FocusNode();
  FocusNode _adresssFoucsNode = FocusNode();
  FocusNode _cityFoucsNode = FocusNode();
  FocusNode _governorateFoucsNode = FocusNode();
  FocusNode _universityFoucsNode = FocusNode();

  FocusNode _facultyFoucsNode = FocusNode();
  FocusNode _majorFoucsNode = FocusNode();
  FocusNode _genderFoucsNode = FocusNode();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _phoneNumber.dispose();
    _phoneCode.dispose();
    _brithDate.dispose();
    _phoneFoucsNode.dispose();
    _brithDateFoucsNode.dispose();
    _nationalIdFoucsNode.dispose();
    _nameFoucsNode.dispose();
    _adresssFoucsNode.dispose();
    _cityFoucsNode.dispose();
    _governorateFoucsNode.dispose();
    _universityFoucsNode.dispose();
    _facultyFoucsNode.dispose();
    _majorFoucsNode.dispose();
    _genderFoucsNode.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<String> genders = <String>[
    AppLocalizationKeys.male,
    AppLocalizationKeys.female,
  ];
  List<CityEntity> cities = <CityEntity>[];
  ProfileInfo profileInfo = ProfileInfo.personal;
  String path = "";
  bool hasImage = false;

  PlatformFile? _initImage;
  @override
  void initState() {
    hasImage = LocalData.user?.attachments != null &&
        LocalData.user!.attachments!.isNotEmpty &&
        LocalData.user!.attachments!.where((AttachmentDto e) => e.type == "profile_picture").isNotEmpty;

    if (hasImage) {
      AttachmentDto image =
          LocalData.user!.attachments!.firstWhere((AttachmentDto e) => e.type == "profile_picture");

      path = image.path;
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) async {
      if (widget.fromUpdatePopup) {
        _onPressed();
      }
      if (hasImage) {
        PlatformFile? cached = await LocalData.getImageProfile();
        if (cached != null &&
            cached.path != null &&
            File(cached.path!).existsSync()) {
          _initImage = cached;
          setState(() {});
        } else {
          if (LocalData.user != null) {
            ViewsToolbox.showLoading();
            await LocalData.downloadAndSetProfileImage(LocalData.user!);
            _initImage = await LocalData.getImageProfile();
            if (_initImage != null) setState(() {});
            ViewsToolbox.dismissLoading();
          }
        }
      }

      // After loading image, initialize profile picture form field
      if (_initImage != null && _key.currentState != null) {
        await Future.delayed(const Duration(milliseconds: 100));
        _key.currentState?.fields[PersonalInformationFormConstants.profilePicture]?.didChange(_initImage);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      bloc: widget.completeProfileCubit,
      listener: (BuildContext context, CompleteProfileState state) {
        if (state is CompleteProfileLoadingState) {
          ViewsToolbox.showLoading();
        } else if (state is CompleteProfileReadyState) {
          ViewsToolbox.dismissLoading();
          ViewsToolbox.showSuccessAwesomeSnackBar(
              context, context.tr(AppLocalizationKeys.personalInfoAddedSuccessfully));
          CustomMainRouter.pop();
        }
        if (state is CompleteProfileErrorState) {
          ViewsToolbox.dismissLoading();
          ViewsToolbox.showErrorAwesomeSnackBar(context, state.message);
        }
      },
      child: MasterWidget(
        scaffoldColor: Palette.grey_FAFAFA,
        appBar: ViewsToolbox.showAppBar(
          title: context.tr(AppLocalizationKeys.personalInformation),
        ),
        widget: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              20.heightBox,
              FormBuilder(
                key: _key,
                child: UploadProfilePictrueWidget(
                  onFileSelected: (PlatformFile? selectedFiles) {
                    _key.currentState?.fields[PersonalInformationFormConstants.profilePicture]!
                        .didChange(selectedFiles);
                  },
                  customFormKey: _key,
                  initialValue: _initImage,
                  allowedExtensions: <String>["png", "jpg", "jpeg"],
                  context: context,
                  isRequired: true,
                  isMultiple: false,
                  keyName: PersonalInformationFormConstants.profilePicture,
                ),
              ),
              10.heightBox,
              Center(
                child: AppText(
                  text: context.tr(AppLocalizationKeys.uploadSelfie),
                  textColor: Palette.secondary,
                  style: AppTextStyle.medium_13,
                ),
              ),
              30.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Tag(
                    text: context.tr(AppLocalizationKeys.personalInfo),
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(0);
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileInfo = ProfileInfo.personal;
                      });
                    },
                    isSelected: profileInfo == ProfileInfo.personal,
                  ),
                  20.widthBox,
                  Tag(
                    text: context.tr(AppLocalizationKeys.educationInfo),
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(1);
                        FocusManager.instance.primaryFocus?.unfocus();

                        profileInfo = ProfileInfo.education;
                      });
                    },
                    isSelected: profileInfo == ProfileInfo.education,
                  ),
                ],
              ),
              ExpandablePageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  PerosnalInfoForm(
                    gederFoucsNode: _genderFoucsNode,
                    governorateFoucsNode: _governorateFoucsNode,
                    cityFoucsNode: _cityFoucsNode,
                    brithDate: _brithDate,
                    adresssFoucsNode: _adresssFoucsNode,
                    brithDateFoucsNode: _brithDateFoucsNode,
                    nameFoucsNode: _nameFoucsNode,
                    nationalIdFoucsNode: _nationalIdFoucsNode,
                    phoneFoucsNode: _phoneFoucsNode,
                    viewMode: widget.viewMode,
                    formKey: _perosonalKey,
                    phoneCode: _phoneCode,
                    phoneNumber: _phoneNumber,
                  ),
                  EducationInfoForm(
                    viewMode: widget.viewMode,
                    formKey: _educationKey,
                    universtityFoucsNode: _universityFoucsNode,
                    facultyFoucsNode: _facultyFoucsNode,
                    majorFoucsNode: _majorFoucsNode,
                  ),
                ],
              ),
              50.heightBox,
              CustomElevatedButton(
                onPressed: () async {
                  _onPressed();
                },
                width: 0.9.sw,
                height: 45.h,
                text: context.tr(AppLocalizationKeys.submit),
                textStyle: AppTextStyle.semiBold_16,
              ),
              10.heightBox
            ],
          ),
        ),
      ),
    );
  }

  String _genderApiValue(dynamic value) {
    final String normalized = value?.toString().trim().toLowerCase() ?? '';
    if (normalized == 'male' || normalized == 'ذكر' || normalized == 'Ø°ÙƒØ±') {
      return 'male';
    }
    if (normalized == 'female' || normalized == 'أنثى' || normalized == 'Ø£Ù†Ø«Ù‰') {
      return 'female';
    }
    return LocalData.user?.gender ?? 'male';
  }

  void _onPressed() async {
    unFoucsAll();

    // Save all form states to ensure current values are captured
    _perosonalKey.currentState?.save();
    _educationKey.currentState?.save();
    _key.currentState?.save();

    if (_educationKey.currentState != null && !_educationKey.currentState!.validate() && _pageController.page == 1) {
      _educationKey.currentState!.validate();
    } else {
      final bool personalFormValid = _perosonalKey.currentState!.validate();

      if (personalFormValid) {
        bool educationValid = false;

        if (_educationKey.currentState != null) {
          educationValid = _educationKey.currentState!.validate();
        } else {
          if (LocalData.user != null &&
              LocalData.user!.universityId != null &&
              LocalData.user!.universityMajor != null &&
              LocalData.user!.universityFaculty != null) {
            educationValid = true;
          }
        }

        if (educationValid || (LocalData.user != null &&
                LocalData.user!.universityId != null &&
                LocalData.user!.universityMajor != null &&
                LocalData.user!.universityFaculty != null)) {


          bool profilePictureValid = false;
          if (_key.currentState != null) {
            profilePictureValid = _key.currentState!.validate();
          }

          if ((_key.currentState != null && profilePictureValid) || _initImage != null) {
            MultipartFile multipartFile;
            FormData formData = FormData();
            if (_key.currentState != null &&
                _key.currentState!.fields[PersonalInformationFormConstants.profilePicture]!.value != null) {
              multipartFile = await MultipartFile.fromFile(
                _key.currentState!.fields[PersonalInformationFormConstants.profilePicture]!.value.path,
                filename: _key.currentState!.fields[PersonalInformationFormConstants.profilePicture]!.value.name,
              );
            } else {
              multipartFile = await MultipartFile.fromFile(
                _initImage!.path!,
                filename: _initImage!.name,
              );
            }

            formData.files.add(MapEntry("attachment[file]", multipartFile));

            formData.fields.add(MapEntry("attachment[type]", "profile_picture"));
            await CachedNetworkImage.evictFromCache(ApiConstants.baseStorageUrlProd + path);

            // Get birthdate from form field or controller
            String birthdate = _perosonalKey.currentState!.fields[PersonalInformationFormConstants.birth]!.value ?? _brithDate.text;

            // Get phone number and code - use controller values as they're updated by PhoneField
            String phoneNumber = _phoneNumber.text;
            String phoneCode = _phoneCode.text;

            // Handle university selection
            int? selectedUniversityId = _educationKey.currentState?.fields[PersonalInformationFormConstants.university]?.value;
            int? universityId;
            String? universityName;

            // Check if "Other" option by looking at the custom university name field
            String? customUniversityName = _educationKey.currentState?.fields[PersonalInformationFormConstants.universityName]?.value;
            bool isOther = customUniversityName != null && customUniversityName.trim().isNotEmpty;

            if (selectedUniversityId != null && isOther) {
              // "Other" option is selected - send both ID and custom name
              universityId = selectedUniversityId;

              if (customUniversityName.trim().isEmpty) {
                ViewsToolbox.showErrorAwesomeSnackBar(context, context.tr('emptyError'));
                return;
              }

              universityName = customUniversityName.trim();
            } else if (selectedUniversityId != null) {
              // Normal university selected - send empty string so API doesn't complain about missing field
              universityId = selectedUniversityId;
              universityName = "";
            } else {
              // Use existing user data
              universityId = LocalData.user!.universityId;
              universityName = LocalData.user?.universityName ?? "";
            }

            if (LocalData.user!.status == "approved") {
              UpdateProfilePopUp.showConfirmPopUp(
                context,
                onYesTap: () {
                  CustomMainRouter.pop();
                  widget.completeProfileCubit.completePersonalInfo(
                      completePersonalInfoRequestModel: CompletePersonalInfoRequestModel(
                          name: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.fullName]!.value,
                          gender: _genderApiValue(
                            _perosonalKey.currentState!.fields[PersonalInformationFormConstants.gender]!.value,
                          ),
                          national_id:
                              _perosonalKey.currentState!.fields[PersonalInformationFormConstants.nationalId]!.value,
                          attachment: formData,
                          university_faculty:
                              _educationKey.currentState?.fields[PersonalInformationFormConstants.faculty]!.value == null
                                  ? LocalData.user!.universityFaculty
                                  : _educationKey.currentState!.fields[PersonalInformationFormConstants.faculty]!.value,
                          university_major:
                              _educationKey.currentState?.fields[PersonalInformationFormConstants.faculty]!.value == null
                                  ? LocalData.user!.universityMajor
                                  : _educationKey.currentState!.fields[PersonalInformationFormConstants.major]!.value,
                          university_id: universityId,
                          university_name: universityName,
                          birthdate: birthdate,
                          address: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.address]!.value,
                          phone_code: phoneCode,
                          phone_number: phoneNumber,
                          governorate_id:
                              _perosonalKey.currentState!.fields[PersonalInformationFormConstants.governorate]!.value,
                          city_id: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.city]!.value));
                },
              );
            } else {
              widget.completeProfileCubit.completePersonalInfo(
                  completePersonalInfoRequestModel: CompletePersonalInfoRequestModel(
                      name: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.fullName]!.value,
                      gender: _genderApiValue(
                        _perosonalKey.currentState!.fields[PersonalInformationFormConstants.gender]!.value,
                      ),
                      national_id:
                          _perosonalKey.currentState!.fields[PersonalInformationFormConstants.nationalId]!.value,
                      attachment: formData,
                      university_faculty:
                          _educationKey.currentState?.fields[PersonalInformationFormConstants.faculty]!.value == null
                              ? LocalData.user!.universityFaculty
                              : _educationKey.currentState!.fields[PersonalInformationFormConstants.faculty]!.value,
                      university_major:
                          _educationKey.currentState?.fields[PersonalInformationFormConstants.faculty]!.value == null
                              ? LocalData.user!.universityMajor
                              : _educationKey.currentState!.fields[PersonalInformationFormConstants.major]!.value,
                      university_id: universityId,
                      university_name: universityName,
                      birthdate: birthdate,
                      address: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.address]!.value,
                      phone_code: phoneCode,
                      phone_number: phoneNumber,
                      governorate_id:
                          _perosonalKey.currentState!.fields[PersonalInformationFormConstants.governorate]!.value,
                      city_id: _perosonalKey.currentState!.fields[PersonalInformationFormConstants.city]!.value));
            }
          }
        } else {
          setState(() {
            _pageController.jumpToPage(1);
            FocusManager.instance.primaryFocus?.unfocus();

            profileInfo = ProfileInfo.education;
          });
          Future.delayed(const Duration(milliseconds: 200), () {
            if (_perosonalKey.currentState != null && _perosonalKey.currentState!.validate()) {
              _educationKey.currentState?.validate();
            }
          });
        }
      } else {
        if (_pageController.page == 1) {
          setState(() {
            _pageController.jumpToPage(0);
            FocusManager.instance.primaryFocus?.unfocus();

            profileInfo = ProfileInfo.personal;
          });
        }
      }
    }
  }

  unFoucsAll() {
    _adresssFoucsNode.unfocus();
    _phoneFoucsNode.unfocus();
    _nameFoucsNode.unfocus();
    _brithDateFoucsNode.unfocus();
    _majorFoucsNode.unfocus();
    _facultyFoucsNode.unfocus();
    _nationalIdFoucsNode.unfocus();
    _cityFoucsNode.unfocus();
    _governorateFoucsNode.unfocus();
    _universityFoucsNode.unfocus();
    _genderFoucsNode.unfocus();
  }
}

class PersonalInformationFormConstants {
  static const String fullName = "FullName";
  static const String university = "university";
  static const String universityName = "universityName";
  static const String birth = "birth";
  static const String phone = "phone";
  static const String address = "address";
  static const String governorate = "governorate";
  static const String city = "city";
  static const String gender = "gender";
  static const String nationalId = "nationalId";
  static const String profilePicture = "profilePicture";
  static const String faculty = "faculty";
  static const String major = "major";
}
