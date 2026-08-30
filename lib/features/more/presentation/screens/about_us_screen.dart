import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const String urlWebsite = 'https://flexijobapp.com';
  static const String urlInstagram = 'https://www.instagram.com/flexijobapp/';
  static const String urlTiktok = 'https://www.tiktok.com/@flexijobapp';
  static const String urlFacebook = 'https://www.facebook.com/flexijobapp';

  @override
  Widget build(BuildContext context) {
    final TextStyle sectionTitleStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.sp,
      color: Palette.primaryColor,
    );

    final TextStyle bodyStyle = TextStyle(
      fontSize: 16.sp,
      height: 1.45,
      color: Palette.grey_757575,
    );

    return MasterWidget(
      hasScroll: true,
      scaffoldColor: const Color(0xFFF5F6FA),
      appBar: ViewsToolbox.showAppBar(
        title: context.tr(AppLocalizationKeys.aboutTitle),
      ),
      widget: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _AboutSectionCard(
              leading: Icon(Icons.groups_outlined, color: Palette.secondary, size: 22.sp),
              title: context.tr(AppLocalizationKeys.aboutIntroTitle),
              sectionTitleStyle: sectionTitleStyle,
              children: <Widget>[
                Text(
                  context.tr(AppLocalizationKeys.aboutIntroDesc),
                  style: bodyStyle,
                ),
              ],
            ),
            _AboutSectionCard(
              leading: Icon(Icons.timeline_outlined, color: Palette.secondary, size: 22.sp),
              title: context.tr(AppLocalizationKeys.aboutHowItWorksTitle),
              sectionTitleStyle: sectionTitleStyle,
              children: <Widget>[
                _NumberedStep(text: context.tr(AppLocalizationKeys.aboutStep1), index: 1, bodyStyle: bodyStyle),
                _NumberedStep(text: context.tr(AppLocalizationKeys.aboutStep2), index: 2, bodyStyle: bodyStyle),
                _NumberedStep(text: context.tr(AppLocalizationKeys.aboutStep3), index: 3, bodyStyle: bodyStyle),
              ],
            ),
            _AboutSectionCard(
              leading: Icon(Icons.warning_amber_rounded, color: Colors.deepOrange.shade700, size: 22.sp),
              title: context.tr(AppLocalizationKeys.aboutImportantTitle),
              sectionTitleStyle: sectionTitleStyle,
              children: <Widget>[
                _WarningPanel(
                  paragraphs: <String>[
                    context.tr(AppLocalizationKeys.aboutCheckinDesc),
                    context.tr(AppLocalizationKeys.aboutCheckoutDesc),
                  ],
                ),
              ],
            ),
            _AboutSectionCard(
              leading: Icon(Icons.gavel_outlined, color: Colors.deepOrange.shade700, size: 22.sp),
              title: context.tr(AppLocalizationKeys.aboutStrikesTitle),
              sectionTitleStyle: sectionTitleStyle,
              children: <Widget>[
                _WarningPanel(
                  paragraphs: <String>[context.tr(AppLocalizationKeys.aboutStrikesDesc)],
                  footerBullet: context.tr(AppLocalizationKeys.aboutStrikesRule),
                  bodyStyle: bodyStyle,
                ),
              ],
            ),
            _AboutSectionCard(
              leading: Icon(Icons.fact_check_outlined, color: Palette.secondary, size: 22.sp),
              title: context.tr(AppLocalizationKeys.aboutAcceptanceTitle),
              sectionTitleStyle: sectionTitleStyle,
              children: <Widget>[
                Text(
                  context.tr(AppLocalizationKeys.aboutAcceptanceDesc),
                  style: bodyStyle,
                ),
              ],
            ),
            20.heightBox,
            AppText(
              text: context.tr(AppLocalizationKeys.aboutClosing),
              style: AppTextStyle.regular_14,
              textColor: Palette.grey_757575,
              textAlign: TextAlign.center,
            ),
            28.heightBox,
            Text(
              context.tr(AppLocalizationKeys.aboutWebsite),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Palette.blue_344054,
              ),
            ),
            16.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _SocialIconButton(
                  icon: FontAwesomeIcons.instagram,
                  backgroundColor: const Color(0xFFE4405F),
                  semanticLabel: context.tr(AppLocalizationKeys.aboutInstagram),
                  url: urlInstagram,
                ),
                _SocialIconButton(
                  icon: FontAwesomeIcons.tiktok,
                  backgroundColor: Palette.black_111111,
                  semanticLabel: context.tr(AppLocalizationKeys.aboutTiktok),
                  url: urlTiktok,
                ),
                _SocialIconButton(
                  icon: FontAwesomeIcons.facebookF,
                  backgroundColor: const Color(0xFF1877F2),
                  semanticLabel: context.tr(AppLocalizationKeys.aboutFacebook),
                  url: urlFacebook,
                ),
                _SocialIconButton(
                  icon: FontAwesomeIcons.globe,
                  backgroundColor: Palette.primaryColor,
                  semanticLabel: '${context.tr(AppLocalizationKeys.aboutWebsite)} · flexijobapp.com',
                  url: urlWebsite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSectionCard extends StatelessWidget {
  const _AboutSectionCard({
    required this.leading,
    required this.title,
    required this.sectionTitleStyle,
    required this.children,
  });

  final Widget leading;
  final String title;
  final TextStyle sectionTitleStyle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Card(
        elevation: 1.5,
        shadowColor: Palette.jobBoxShadow.withValues(alpha: 0.35),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          leading: leading,
          title: Text(title, style: sectionTitleStyle),
          iconColor: Palette.primaryColor,
          collapsedIconColor: Palette.primaryColor,
          children: children,
        ),
      ),
    );
  }
}

class _NumberedStep extends StatelessWidget {
  const _NumberedStep({
    required this.text,
    required this.index,
    required this.bodyStyle,
  });

  final String text;
  final int index;
  final TextStyle bodyStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 26.w,
            child: Text(
              '$index.',
              style: bodyStyle.copyWith(fontWeight: FontWeight.w700, color: Palette.secondary),
            ),
          ),
          Expanded(child: Text(text, style: bodyStyle)),
        ],
      ),
    );
  }
}

class _WarningPanel extends StatelessWidget {
  const _WarningPanel({
    required this.paragraphs,
    this.footerBullet,
    this.bodyStyle,
  });

  final List<String> paragraphs;
  final String? footerBullet;
  final TextStyle? bodyStyle;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveBody = bodyStyle ??
        TextStyle(
          fontSize: 14.sp,
          height: 1.45,
          color: Palette.grey_757575,
        );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFFD54F)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...paragraphs.map(
            (String p) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(p, style: effectiveBody),
            ),
          ),
          if (footerBullet != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 2.w, right: 8.w),
                  child: Icon(Icons.circle, size: 6.sp, color: Palette.grey_757575),
                ),
                Expanded(child: Text(footerBullet!, style: effectiveBody)),
              ],
            ),
        ],
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    required this.icon,
    required this.backgroundColor,
    required this.semanticLabel,
    required this.url,
  });

  final FaIconData icon;
  final Color backgroundColor;
  final String semanticLabel;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Tooltip(
        message: semanticLabel,
        child: Material(
          color: backgroundColor,
          elevation: 2,
          shadowColor: Colors.black26,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () async {
              try {
                await ViewsToolbox.launchUrlHelper(url);
              } catch (_) {}
            },
            child: SizedBox(
              width: 52.w,
              height: 52.w,
              child: Center(
                child: FaIcon(
                  icon,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
