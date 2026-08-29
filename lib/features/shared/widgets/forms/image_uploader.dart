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
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomImageUploader extends StatefulWidget {
  const CustomImageUploader({
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

  final List<PlatformFile>? initialValue;
  final bool? disableField;
  final GlobalKey<FormBuilderState>? customFormKey;

  @override
  State<CustomImageUploader> createState() => _CustomImageUploaderState();
}

class _CustomImageUploaderState extends State<CustomImageUploader> {
  List<PlatformFile> _selectedFiles = <PlatformFile>[];
  PlatformFile? _selectedFile;
  bool _isInitialized = false;
  bool _isPicking = false;

  @override
  Widget build(BuildContext context) {
    // Sync with initialValue when it changes from parent
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      if (!_isInitialized || _selectedFiles.length != widget.initialValue!.length) {
        _selectedFiles = <PlatformFile>[...widget.initialValue!];
        _isInitialized = true;
        widget.customFormKey?.currentState?.fields[widget.keyName]?.didChange(widget.initialValue);
      }
    }
    return FormBuilderField<List<PlatformFile>>(
      name: widget.keyName,
      builder: (FormFieldState<List<PlatformFile>> field) => Column(
        children: <Widget>[
          _selectedFiles.isNotEmpty
              ? GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 3.w / 4.h,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 40.h,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 2.h,
            ),
            crossAxisCount: 4,
            children: _selectedFiles
                .mapIndexed(
                  (int index, PlatformFile element) => Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Center(
                    child: Image.file(
                      height: 60.h,
                      width: 70.w,
                      fit: BoxFit.cover,
                      File(
                        _selectedFiles[index].path!,
                      ),
                    ),
                  ),
                  Positioned(
                    left: LanguageHelper.isAr(context) ? -10.w : null,
                    right: LanguageHelper.isEN(context) ? -10.w : null,
                    child: GestureDetector(
                      onTap: () => removeFile(
                        index,
                      ),
                      child: GestureDetector(
                        onTap: () => removeFile(
                          index,
                        ),
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primaryColor,
                          ),
                          child: GestureDetector(
                            onTap: () => removeFile(
                              index,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
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
            )
                .toList(),
          )
              : Container(),
          _selectedFiles.isNotEmpty ? 20.heightBox : Container(),
          CustomElevatedButton(
            onPressed: _selectedFiles.isNotEmpty && _selectedFiles.length == 2
                ? () {}
                : () async {
              if (_isPicking) return;
              if (Platform.isIOS) {
                bool isValid = await ViewsToolbox.checkPermision(Permission.photos);
                if (!isValid) return;
              }
              _pickFiles();
            },
            width: 0.9.sw,
            height: 45.h,
            backgroundColor: _selectedFiles.isNotEmpty && _selectedFiles.length == 2 ? Palette.grey_F0F0F0 : null,
            text: context.tr(AppLocalizationKeys.upload),
            textStyle: AppTextStyle.semiBold_16,
          ),
        ],
      ),
    );
  }

  void removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
    widget.onFilesSelected?.call(_selectedFiles);
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
        allowMultiple: widget.isMultiple,
        type: FileType.image,
        compressionQuality: 0,
        // allowedExtensions: widget.allowedExtensions,
      );
    }
    if (pickedFiles != null) {
      // Validate the selected files' extensions
      final List<PlatformFile> validFiles = <PlatformFile>[];
      for (final PlatformFile file in pickedFiles.files) {
        if (widget.allowedExtensions.contains(file.extension)) {
          validFiles.add(file);
        } else {
          // If the file extension is not allowed, show a snackbar message and remove the invalid file
          setState(() {
            _selectedFiles.remove(file);
          });
          ViewsToolbox.showWarningAwesomeSnackBar(
            context,
            "Invalid-file-type".tr(),
          );
        }
      }
      List<PlatformFile> validSelectdFiles = <PlatformFile>[];

      // Calculate how many more files we can add (max 2 total)
      int remainingSlots = 2 - _selectedFiles.length;

      if (remainingSlots > 0) {
        if (validFiles.length >= 2 && _selectedFiles.isEmpty) {
          // If no files selected and user picks 2+, take first 2
          validSelectdFiles.add(validFiles[0]);
          validSelectdFiles.add(validFiles[1]);
        } else {
          // Add files up to the remaining slots
          for (int i = 0; i < validFiles.length && i < remainingSlots; i++) {
            validSelectdFiles.add(validFiles[i]);
          }
        }
      }

      setState(() {
        _selectedFiles.addAll(validSelectdFiles);
      });
      widget.onFilesSelected?.call(_selectedFiles);
    } else if (pickedFile != null) {
      // Handle single file selection
      final List<PlatformFile> validFiles = <PlatformFile>[];

      if (widget.allowedExtensions.contains(pickedFile.files.first.extension)) {
        // Only add if we have space (max 2 files)
        if (_selectedFiles.length < 2) {
          validFiles.add(pickedFile.files.first);

          setState(() {
            _selectedFiles.addAll(validFiles);
          });
          widget.onFilesSelected?.call(_selectedFiles);
        }
      } else {
        // If the file extension is not allowed, show a snackbar message
        ViewsToolbox.showWarningAwesomeSnackBar(
          context,
          "Invalid-file-type".tr(),
        );
      }
    }
    } finally {
      _isPicking = false;
    }
  }

  List<AttachmentEntity> addMedias() {
    final List<AttachmentEntity> medias = <AttachmentEntity>[];
    _selectedFiles.forEach((PlatformFile element) {
      final File file = File(element.path!);
      final List<int> bytes = file.readAsBytesSync();
      final String base64String = base64.encode(bytes);
      medias.add(
        AttachmentEntity(id: 0, fileName: element.name, path: element.path ?? ''),
      );
    });
    return medias;
  }
}

