import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 120.w,
            height: 42.h,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () async {
                  await LocalData.clearAllData();
                  CustomMainRouter.push(LoginRoute());
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.red.shade100, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppText(
                        text: context.tr(AppLocalizationKeys.logout),
                        style: AppTextStyle.semiBold_16,
                        textColor: Colors.red.shade400,
                      ),
                      10.widthBox,
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.red.shade400,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
