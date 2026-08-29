import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flexiJobs/core/network/api/network_apis_constants.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/attachment_request_model.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/enum/document_type.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/confirm_to_update_profile.dart';
import 'package:flexiJobs/features/jobs/data/models/response/attachment_dto.dart';
import 'package:flexiJobs/features/jobs/domain/entities/attachment_entity.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/image_uploader.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key, required this.completeProfileCubit, this.viewMode = false});
  final CompleteProfileCubit completeProfileCubit;
  final bool viewMode;

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  List<PlatformFile> _selectedNationalIdFiles = <PlatformFile>[];
  List<AttachmentDto> _iniSelectedNationalIdFiles = <AttachmentDto>[];
  List<AttachmentDto> _iniStudentFiles = <AttachmentDto>[];
  List<PlatformFile> _selectedStudentIdFiles = <PlatformFile>[];
  List<AttachmentEntity> _selectedNationalIdImages = <AttachmentEntity>[];
  List<AttachmentEntity> _selectedStudentIdImages = <AttachmentEntity>[];
  List<AttachmentRequestModel> _selectedAllImages = <AttachmentRequestModel>[];
  bool hasImage = false;
  @override
  void initState() {
    super.initState();
    hasImage = LocalData.user?.attachments != null &&
        LocalData.user!.attachments!.isNotEmpty &&
        LocalData.user!.attachments!.where((AttachmentDto e) => e.type == "national_id").isNotEmpty;

    if (hasImage) {
      WidgetsBinding.instance.addPostFrameCallback((Duration Duration) async {
        ViewsToolbox.showLoading();
        _iniSelectedNationalIdFiles =
            LocalData.user!.attachments!.where((AttachmentDto e) => e.type == "national_id").toList();
        _iniStudentFiles =
            LocalData.user!.attachments!.where((AttachmentDto e) => e.type == "student_id").toList();

        await Future.forEach(_iniSelectedNationalIdFiles, (AttachmentDto element) async {
          PlatformFile f = await ViewsToolbox.networkImageToPlatformFile(ApiConstants.baseStorageUrlProd + element.path);

          _selectedNationalIdFiles.add(f);
        });
        await Future.forEach(_iniStudentFiles, (AttachmentDto element) async {
          PlatformFile f = await ViewsToolbox.networkImageToPlatformFile(ApiConstants.baseStorageUrlProd + element.path);

          _selectedStudentIdFiles.add(f);
        });

        setState(() {});
        ViewsToolbox.dismissLoading();
      });
    }
  }

  List<AttachmentEntity> _existingAttachments(String type) =>
      LocalData.user?.attachments
          ?.where((AttachmentDto attachment) => attachment.type == type)
          .map((AttachmentDto attachment) => attachment.toEntity())
          .toList() ??
      <AttachmentEntity>[];

  void _uploadDocuments() {
    _selectedNationalIdImages.clear();
    _selectedStudentIdImages.clear();
    _selectedAllImages.clear();

    _selectedNationalIdImages.addAll(_selectedNationalIdFiles
        .map((PlatformFile file) => AttachmentEntity(
            id: 0,
            path: file.path ?? '',
            fileName: file.name,
            type: getDocumentType.documentName(DocumentType.nationalId)))
        .toList());
    _selectedStudentIdImages.addAll(_selectedStudentIdFiles
        .map(
          (PlatformFile file) => AttachmentEntity(
              id: 0,
              path: file.path ?? '',
              fileName: file.name,
              type: getDocumentType.documentName(DocumentType.studentId)),
        )
        .toList());
    _selectedAllImages.addAll(_selectedNationalIdImages
        .map((AttachmentEntity attachment) => AttachmentRequestModel(filePath: attachment.path, type: attachment.type!)));
    _selectedAllImages.addAll(_selectedStudentIdImages
        .map((AttachmentEntity attachment) => AttachmentRequestModel(filePath: attachment.path, type: attachment.type!)));

    widget.completeProfileCubit.uploadDocuments(listAttachments: _selectedAllImages);
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
                context, context.tr(AppLocalizationKeys.documentsAddedSuccessfully));
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
              title: context.tr(AppLocalizationKeys.uploadDocument),
            ),
            widget: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: <Widget>[
                  UploadCard(
                    // isViewMode: widget.viewMode,
                    title: context.tr(AppLocalizationKeys.uploadYourNationalID),
                    type: DocumentType.nationalId,
                    attachments: _existingAttachments("national_id"),
                    selectedFiles: _selectedNationalIdFiles,
                    onFilesSelected: (List<PlatformFile>? selectedFiles) {
                      setState(() {
                        _selectedNationalIdFiles = selectedFiles ?? <PlatformFile>[];
                      });
                    },
                  ),
                  20.heightBox,
                  UploadCard(
                    attachments: _existingAttachments("student_id"),
                    // isViewMode: widget.viewMode,
                    title: context.tr(AppLocalizationKeys.studentID),
                    type: DocumentType.studentId,
                    selectedFiles: _selectedStudentIdFiles,
                    onFilesSelected: (List<PlatformFile>? selectedFiles) {
                      setState(() {
                        _selectedStudentIdFiles = selectedFiles ?? <PlatformFile>[];
                      });
                    },
                  ),
                  40.heightBox,
                  CustomElevatedButton(
                    onPressed: _selectedNationalIdFiles.length == 2 && _selectedStudentIdFiles.length == 2
                        ? () {
                            // If user already has documents and is editing, show confirmation popup
                            if (hasImage) {
                              UpdateProfilePopUp.showConfirmPopUp(
                                context,
                                onYesTap: () {
                                  CustomMainRouter.pop(); // Close the popup
                                  _uploadDocuments();
                                },
                              );
                            } else {
                              // First time upload, no popup needed
                              _uploadDocuments();
                            }
                          }
                        : () {},
                    width: 0.9.sw,
                    height: 45.h,
                    backgroundColor: _selectedNationalIdFiles.length == 2 && _selectedStudentIdFiles.length == 2
                        ? null
                        : Palette.grey_F0F0F0,
                    text: context.tr(AppLocalizationKeys.upload),
                    textStyle: AppTextStyle.semiBold_16,
                  ),
                ],
              ),
            )));
  }
}

class UploadCard extends StatefulWidget {
  const UploadCard(
      {super.key,
      required this.title,
      required this.type,
      required this.onFilesSelected,
      required this.selectedFiles,
      this.attachments,
      this.isViewMode = false});
  final String title;
  final Function(List<PlatformFile>? selectedFiles)? onFilesSelected;
  final DocumentType type;
  final bool? isViewMode;

  final List<PlatformFile> selectedFiles;
  final List<AttachmentEntity>? attachments;
  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.selectedFiles.isEmpty ? 170.h : 300.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Card(
            elevation: 1,
            shape:
                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      AppText(
                        text: widget.title,
                        style: AppTextStyle.medium_17,
                        textColor: Palette.primaryColor,
                      ),
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.selectedFiles.length == 2 ? Palette.primaryColor : Palette.transparntColor,
                            border: widget.selectedFiles.length == 2 ? null : Border.all(color: Palette.grey_D0D5DDD)),
                        child: widget.selectedFiles.length == 2
                            ? Center(
                                child: Icon(
                                  Icons.check,
                                  size: 15.w,
                                  color: Palette.white,
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  20.heightBox,
                  AppText(
                    text: context.tr(AppLocalizationKeys.attachAPhotoStudentID),
                    style: AppTextStyle.medium_15,
                  ),
                  // widget.isViewMode! ? 20.heightBox : Container(),
                  // widget.isViewMode!
                  //     ? GridView.count(
                  //         shrinkWrap: true,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         childAspectRatio: 3.w / 4.h,
                  //         crossAxisSpacing: 20.w,
                  //         mainAxisSpacing: 40.h,
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: 10.w,
                  //           vertical: 2.h,
                  //         ),
                  //         crossAxisCount: 4,
                  //         children: widget.attachments!
                  //             .mapIndexed((int index, AttachmentEntity element) => ClipRRect(
                  //                   borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  //                   child: CachedNetworkImage(
                  //                     fit: BoxFit.cover,
                  //                     placeholder: (BuildContext context, String url) => Center(
                  //                       child: CircularProgressIndicator(),
                  //                     ),
                  //                     imageUrl: ApiConstants.baseStorageUrl + element.path!,
                  //                     errorWidget: (BuildContext context, String url, Object error) => Container(),
                  //                   ),
                  //                 ))
                  //             .toList())
                  //     : Container(),
                  widget.selectedFiles.isNotEmpty ? 20.heightBox : 20.heightBox,
                  CustomImageUploader(
                    keyName: "d",
                    isMultiple: false,
                    initialValue: widget.selectedFiles,
                    allowedExtensions: <String>["png", "jpg", "jpeg"],
                    context: context,
                    onFilesSelected: (List<PlatformFile>? selectedFiles) {
                      widget.onFilesSelected?.call(selectedFiles);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
