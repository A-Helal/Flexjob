import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/jobs/domain/entities/attachment_entity.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadProfilePictrueWidget extends StatefulWidget {
  const UploadProfilePictrueWidget({
    super.key,
    required this.allowedExtensions,
    required this.context,
    this.onFilesSelected,
    this.onFileSelected,
    this.isMultiple = false,
    this.isValidateDimension = false,
    this.fileType,
    this.fileSizeInMb,
    this.maxHeight,
    this.isValidateSize = false,
    this.maxWidth,
    this.initialValue,
    required this.keyName,
    this.customFormKey,
    this.disableField,
    this.isRequired = false,
  });
  final List<String> allowedExtensions;
  final Function(List<PlatformFile>? selectedFiles)? onFilesSelected;
  final Function(PlatformFile? selectedFiles)? onFileSelected;
  final bool isMultiple;
  final bool isValidateDimension;
  final bool isValidateSize;
  final FileType? fileType;
  final num? fileSizeInMb;
  final num? maxWidth;
  final num? maxHeight;
  final BuildContext context;
  final String keyName;

  final PlatformFile? initialValue;
  final bool? disableField;
  final bool? isRequired;
  final GlobalKey<FormBuilderState>? customFormKey;

  @override
  State<UploadProfilePictrueWidget> createState() => _UploadProfilePictrueWidgetState();
}

class _UploadProfilePictrueWidgetState extends State<UploadProfilePictrueWidget> {
  PlatformFile? _selectedFile;
  bool _isPicking = false;

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null && _selectedFile == null) {
      _selectedFile = widget.initialValue;
    }
    return FormBuilderField<PlatformFile>(
      name: widget.keyName,
      initialValue: widget.initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.isRequired!
          ? (PlatformFile? value) {
              if (value == null) {
                return context.tr(AppLocalizationKeys.profilePictureRequired);
              }
              return null;
            }
          : null,
      builder: (FormFieldState<PlatformFile> field) => Column(
        children: <Widget>[
          if (_selectedFile != null)
            Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Center(
                    child: CircleAvatar(
                  radius: 60.w,
                  backgroundImage: MemoryImage(File(_selectedFile!.path!).readAsBytesSync()),
                )),
                Positioned(
                  left: LanguageHelper.isAr(context) ? 0 : 60.w,
                  right: LanguageHelper.isAr(context) ? 60.w : 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: _upload,
                    child: GestureDetector(
                      onTap: _upload,
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.primaryColor,
                        ),
                        child: GestureDetector(
                          onTap: _upload,
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Palette.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          _selectedFile != null ? 20.heightBox : Container(),
          if (_selectedFile == null)
            GestureDetector(
              child: SvgPicture.asset(
                "assets/svg/upload-profile.svg",
                width: 100.w,
                fit: BoxFit.cover,
              ),
              onTap: _upload,
            ),
          if (field.hasError)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: AppText(
                text: field.errorText,
                style: AppTextStyle.regular_14,
                textColor: Palette.darkRed,
              ),
            ),
        ],
      ),
    );
  }

  void _upload() async {
    if (_isPicking) return;
    if (Platform.isIOS) {
      bool isValid = await ViewsToolbox.checkPermision(Permission.photos);
      if (!isValid) return;
    }
    _pickFiles();
  }

  void removeFile(int index) {
    setState(() {
      //   _selectedFiles.removeAt(index);
    });
    //  widget.onFilesSelected?.call(_selectedFiles);
  }

  Future<void> _pickFiles() async {
    _isPicking = true;
    try {
    FilePickerResult? pickedFiles;
    FilePickerResult? pickedFile;

    if (widget.isMultiple) {
      pickedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: widget.isMultiple,
        type: FileType.image,
        compressionQuality: 0,
        //  allowedExtensions: widget.allowedExtensions,
      );
    } else {
      pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
        compressionQuality: 0,
      );
    }
    if (pickedFiles != null && widget.isMultiple) {
      // Validate the selected files' extensions
      final List<PlatformFile> validFiles = <PlatformFile>[];
      for (final PlatformFile file in pickedFiles.files) {
        if (widget.allowedExtensions.contains(file.extension)) {
          validFiles.add(file);
        } else {
          // If the file extension is not allowed, show a snackbar message and remove the invalid file
          setState(() {
            ///  _selectedFiles.remove(file);
          });
          ViewsToolbox.showWarningAwesomeSnackBar(
            context,
            "Invalid-file-type".tr(),
          );
        }
      }
      List<PlatformFile> validSelectdFiles = <PlatformFile>[];
      if (validFiles.length >= 2) {
        if (widget.initialValue != null) {
          validSelectdFiles.add(validFiles[0]);
          validSelectdFiles.add(validFiles[1]);
        } else {
          validSelectdFiles.add(validFiles[0]);
        }
      } else {
        validSelectdFiles.addAll(validFiles);
      }
      setState(() {
        //    _selectedFiles.addAll(validSelectdFiles);
      });
      //   widget.onFilesSelected?.call(_selectedFiles);
    } else {
      _selectedFile = pickedFile?.files.first;
      final File file = File(pickedFile!.files.single.path!);

      final Image image = Image.file(file);
      final ImageStream imageStream = image.image.resolve(ImageConfiguration.empty);

      final ImageStreamListener l = ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
        final int width = imageInfo.image.width;
        final int height = imageInfo.image.height;

        if (widget.allowedExtensions.contains(_selectedFile!.extension)) {
          if (widget.isValidateSize && widget.isValidateDimension) {
            if (_selectedFile!.size <= (widget.fileSizeInMb ?? 2) * 1024 * 1024) {
            } else {
              widget.onFileSelected?.call(null);
              ViewsToolbox.showWarningAwesomeSnackBar(
                context,
                "Invalid-file-size".tr() + ": ${widget.fileSizeInMb}" + "mgb".tr(),
              );
            }
            if (widget.isValidateDimension) {
              if (width <= widget.maxWidth! && height <= widget.maxHeight!) {
                widget.onFileSelected?.call(_selectedFile);
              } else {
                widget.onFileSelected?.call(null);

                ViewsToolbox.showWarningAwesomeSnackBar(
                  context,
                  "Invalid-file-dimensions".tr() + " : ${widget.maxWidth}  X  ${widget.maxHeight}" + " Px ",
                );
              }
            }
          } else if (widget.isValidateSize) {
            if (_selectedFile!.size <= (widget.fileSizeInMb ?? 2) * 1024 * 1024) {
              widget.onFileSelected?.call(_selectedFile);
            } else {
              widget.onFileSelected?.call(null);
              ViewsToolbox.showWarningAwesomeSnackBar(
                context,
                "Invalid-file-size".tr() + ": ${widget.fileSizeInMb}" + "mgb".tr(),
              );
            }
          } else if (widget.isValidateDimension) {
            if (width <= widget.maxWidth! && height <= widget.maxHeight!) {
              widget.onFileSelected?.call(_selectedFile);
            } else {
              widget.onFileSelected?.call(null);

              ViewsToolbox.showWarningAwesomeSnackBar(
                context,
                "Invalid-file-dimensions".tr() + ": ${widget.maxWidth} X  ${widget.maxHeight}" + "Px",
              );
            }
          } else {
            widget.onFileSelected?.call(_selectedFile);
          }
        } else {
          widget.onFileSelected?.call(null);
          ViewsToolbox.showWarningAwesomeSnackBar(
            context,
            "Invalid-file-type".tr(),
          );
        }
      });
      setState(() {});
      imageStream.addListener(l);
    }
    } finally {
      _isPicking = false;
    }
  }

}
