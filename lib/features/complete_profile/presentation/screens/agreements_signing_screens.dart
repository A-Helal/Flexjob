import 'package:auto_route/auto_route.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/core/routing/routes.gr.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'dart:ui' as ui;

@RoutePage()
class AgreementsSigningScreens extends StatefulWidget {
  const AgreementsSigningScreens(
      {super.key, required this.completeProfileCubit, this.viewMode = false});
  final CompleteProfileCubit completeProfileCubit;
  final bool viewMode;
  @override
  State<AgreementsSigningScreens> createState() =>
      _AgreementsSigningScreensState();
}

class _AgreementsSigningScreensState extends State<AgreementsSigningScreens> {
  bool isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
        bloc: widget.completeProfileCubit,
        listener: (context, state) {
          if (state is CompleteProfileLoadingState) {
            ViewsToolbox.showLoading();
          } else if (state is CompleteProfileReadyState) {
            ViewsToolbox.dismissLoading();

            CustomMainRouter.push(NavigationMainRoute(children: [JobsRoute()]));

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
              title: context.tr(AppLocalizationKeys.agreementSigning),
            ),
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  PolicyCard(
                    viewMode: widget.viewMode,
                    onAgreed: (bool agreed) {
                      isAgreed = agreed;
                      setState(() {});
                    },
                    currentAgreement: widget.viewMode ? true : isAgreed,
                    title: context.tr(AppLocalizationKeys.signTheAgreement),
                  ),
                  widget.viewMode ? Container() : 500.heightBox,
                  widget.viewMode
                      ? Container()
                      : CustomElevatedButton(
                          onPressed: isAgreed
                              ? () {
                                  widget.completeProfileCubit.completeProfile();
                                }
                              : () {},
                          width: 0.9.sw,
                          backgroundColor: isAgreed
                              ? Palette.primaryColor
                              : Palette.grey_F0F0F0,
                          height: 45.h,
                          text: context.tr(AppLocalizationKeys.submit),
                          textStyle: AppTextStyle.semiBold_16,
                        )
                ],
              ),
            )));
  }
}

class PolicyCard extends StatefulWidget {
  const PolicyCard({
    super.key,
    required this.title,
    this.hint,
    this.label,
    this.currentAgreement = false,
    this.viewMode = false,
    required this.onAgreed,
  });
  final String title;
  final String? hint;
  final String? label;
  final bool? currentAgreement;
  final bool? viewMode;
  final Function(bool)? onAgreed;
  @override
  State<PolicyCard> createState() => _PolicyCardState();
}

class _PolicyCardState extends State<PolicyCard> {
  bool isAgreed = false;
  final String _htmlText = '''
<!DOCTYPE html>
<html lang="ar">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <style>
        body {
            font-family: Arial, sans-serif;
            direction: rtl;
            text-align: right;
            margin: 20px;
            line-height: 1.8;
        }
        h1 {
            text-align: center;
            margin:auto
            
        }
        p {
            margin: 10px 0;
        }
        .section-title {
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1 style="     text-align: center;">عقد اتفاق</h1>
    <p>
        تحرر هذا العقد بين كل من:
    </p>
    <p>
        أولاً: فليكس جوب للمستقرين - <strong>طرف أول</strong><br>
        ثانياً: - <strong>طرف ثاني</strong>
    </p>

    <h2>تمهيد</h2>
    <p>
        حيث يمتلك الطرف الأول الفرصة في توفير فرصة عمل للطرف الثاني لما يتمتع به الطرف الأول من خبرة في ذلك، فقد قبل الطرف الثاني ووافق على ذلك طبقاً للقوانين واللوائح المعمول بها داخل جمهورية مصر العربية، واتفقا على ما يلي بعد أن أقر بأهليتهما على التصرف والتعاقد.
    </p>

    <p class="section-title">أولاً:</p>
    <p>التمهيد السابق جزء لا يتجزأ من هذا الاتفاق ومكملاً له.</p>

    <p class="section-title">ثانياً:</p>
    <p>
        يقوم الطرف الأول بتوفير فرصة عمل للطرف الثاني طبقاً للشروط التي يحددها بمعرفته وطبقاً للأحكام المعمول بها، على أن لا تكون مخالفة للقانون، وأن يقبل الطرف الثاني ذلك دون قيد أو شرط أو اعتراض، ويعتبر توقيعه بمثابة موافقة تامة.
    </p>

    <p class="section-title">ثالثاً:</p>
    <p>
        يقوم الطرف الأول بتوفير فرصة عمل للطرف الثاني بصفة مؤقتة طبقاً للمواعيد التي يحددها الطرف الأول بإرادته المنفردة. ولا تخضع هذه الفرصة لامتيازات الوظيفة العامة أو الخاصة حيث إنها بصفة مؤقتة ومتقطعة وليست باستمرارية ولا تخضع لمزايا الموظفين ولا تخضع لقانون العمل المعمول به.
    </p>

    <p class="section-title">رابعاً:</p>
    <p>
        على الطرف الثاني قبول فرصة العمل طبقاً للشروط والمهام التي يحددها الطرف الأول، على أن يتمتع الطرف الثاني بحسن الخلق والأمانة والاحترافية، وعليه أن ينصاع إلى تعليمات الطرف الأول فيما تتطلبه الفرصة من الالتزام بالمواعيد المقررة لأوقات وفترات العمل والانصياع لجميع المتطلبات والأحكام القانونية المعمول بها داخل مصر.
    </p>

    <p class="section-title">خامساً:</p>
    <p>
        يقوم الطرف الأول بتحديد مكافأة مالية تُقدر حسب طبيعة العمل ووقته وحسن الأداء طبقاً لما يحدده الطرف الأول.
    </p>

    <p class="section-title">سادساً:</p>
    <p>
        في حالة وجود مشاكل أو معوقات، على الطرف الثاني التواصل مباشرة مع الطرف الأول للعمل على حلها بصفة فورية دون تدخل من الطرف الثاني لعدم تفاقم الأمور.
    </p>

    <p class="section-title">سابعاً:</p>
    <p>
        يتم إنهاء المأمورية الخاصة بفرصة العمل من جانب الطرف الأول في حالة مخالفة الشروط أو انتهاكها أو إخلال الطرف الثاني بالالتزامات المتعلقة بالفرصة. وفي حالة رغبة الطرف الثاني في الإنهاء، عليه التواصل مع الطرف الأول وإخطاره بمدة كافية.
    </p>

    <p class="section-title">ثامناً:</p>
    <p>
        يلتزم الطرف الأول بالحفاظ على سرية بيانات الطرف الثاني، كما يتحمل المسئولية الناتجة عن الأضرار التي تلحق بالطرف الثاني أثناء فرصة العمل أو بسببها.
    </p>

    <p class="section-title">تاسعاً:</p>
    <p>
        يلتزم الطرف الأول باتخاذ التدابير اللازمة والضرورية للحفاظ على أمن وسلامة الطرف الثاني بما لا يعرضه للإصابة أو الضرر أياً كان نوعه ودفع الأذى عنه.
    </p>

    <p class="section-title">عاشراً:</p>
    <p>
        يلتزم ويتعهد الطرف الثاني بالمحافظة على مقتضيات الوظيفة، وأن يبذل عنايته قدر المستطاع وقصارى جهده، وأن يلتزم بالبرنامج الزمني الموضح بصدر التطبيق دون أدنى تعديل.
    </p>
</body>
</html>

''';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 170.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Stack(
            children: [
              Card(
                elevation: 1,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      55.heightBox,
                      RichText(
                          text: TextSpan(
                              text: context.tr("readTheAgreement"),
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                            const TextSpan(text: "  "),
                            TextSpan(
                                text: context.tr("agreement"),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ViewsToolbox.showBottomSheet(
                                        height: 0.85.sh,
                                        context: context,
                                        widget: Directionality(
                                            textDirection: ui.TextDirection.rtl,
                                            child: HtmlWidget(_htmlText)));
                                  },
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    color: Palette.purpleNavyColor)),
                          ])),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.viewMode!
                    ? () {}
                    : () {
                        isAgreed = !isAgreed;
                        widget.onAgreed?.call(isAgreed);
                        setState(() {});
                      },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: LanguageHelper.isEN(context) ? 3.w : 0,
                      right: LanguageHelper.isAr(context) ? 3.w : 0),
                  child: Container(
                    height: 50.h,
                    width: 0.9.sw,
                    decoration: BoxDecoration(
                        color: widget.viewMode! || isAgreed
                            ? Palette.grey_F0F0F0
                            : Palette.transparntColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AppText(
                            text: widget.title,
                            style: AppTextStyle.medium_17,
                            textColor: Palette.blue_344054,
                          ),
                          Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.viewMode! || isAgreed
                                      ? Palette.primaryColor
                                      : Palette.transparntColor,
                                  border: Border.all(
                                      color: isAgreed
                                          ? Palette.transparntColor
                                          : Palette.grey_D0D5DDD)),
                              child: widget.viewMode! || isAgreed
                                  ? Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 15.w,
                                        color: Palette.white,
                                      ),
                                    )
                                  : Container())
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
