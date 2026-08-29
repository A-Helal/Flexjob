import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/domain/entities/governorate_entity.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/governorate_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GovernorateDropDownListBottomSheet extends StatefulWidget {
  const GovernorateDropDownListBottomSheet({
    super.key,
    required this.onGovernorate,
  });

  final void Function(GovernorateEntity) onGovernorate;

  @override
  State<GovernorateDropDownListBottomSheet> createState() =>
      _GovernorateDropDownListBottomSheetState();
}

class _GovernorateDropDownListBottomSheetState
    extends State<GovernorateDropDownListBottomSheet> {
  GovernorateEntity? _selected;
  List<GovernorateEntity> _all = <GovernorateEntity>[];
  List<GovernorateEntity> _filtered = <GovernorateEntity>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final List<GovernorateEntity> list = await LocalData.getGovernorates();
      if (mounted) setState(() => _all = list);
    });
  }

  List<GovernorateEntity> get _display =>
      _filtered.isNotEmpty ? _filtered : _all;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Palette.grey_D1D1D1,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),
          GovernorateSearchField(onChanged: _onSearch),
          SizedBox(height: 8.h),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 0.48 * MediaQuery.of(context).size.height),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _display.length,
              itemBuilder: (BuildContext ctx, int index) {
                final GovernorateEntity item = _display[index];
                final bool isSelected = _selected?.id == item.id;
                return GestureDetector(
                  onTap: () => setState(() => _selected = item),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: AppText(
                      text: item.name ?? '',
                      style: isSelected
                          ? AppTextStyle.bold_20
                          : AppTextStyle.medium_20,
                      textColor: isSelected
                          ? Palette.primaryColor
                          : Palette.grey_4C4C4C,
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(color: Palette.grey_919191, thickness: 0.2),
          SizedBox(height: 10.h),
          CustomElevatedButton(
            onPressed: _selected != null
                ? () => widget.onGovernorate(_selected!)
                : () {},
            width: 0.7.sw,
            height: 45.h,
            backgroundColor: _selected != null ? null : Palette.grey_F0F0F0,
            text: context.tr(AppLocalizationKeys.applyFilter),
            textStyle: AppTextStyle.semiBold_16,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  void _onSearch(String? value) {
    setState(() {
      if (value != null && value.isNotEmpty) {
        _filtered = _all
            .where((GovernorateEntity e) =>
                (e.name ?? '').toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        _filtered = <GovernorateEntity>[];
      }
    });
  }
}
