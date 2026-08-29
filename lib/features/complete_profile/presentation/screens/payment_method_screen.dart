import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flexiJobs/core/app_data/presentation/cubit/user/user_cubit.dart';
import 'package:flexiJobs/core/constants/app_localization_keys.dart';
import 'package:flexiJobs/core/extensions/size_extensions.dart';
import 'package:flexiJobs/core/helpers/language_helper.dart';
import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'package:flexiJobs/core/theming/palette.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/complete_payment_info_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/instapay_request_model.dart';
import 'package:flexiJobs/features/complete_profile/data/models/request/mobile_wallet_request_model.dart';
import 'package:flexiJobs/features/complete_profile/presentation/cubit/complete_profile_cubit.dart';
import 'package:flexiJobs/features/complete_profile/presentation/enum/payment_type.dart';
import 'package:flexiJobs/features/complete_profile/presentation/widgets/list_mobile_type_tag.dart';
import 'package:flexiJobs/core/routing/route_services.dart';
import 'package:flexiJobs/features/shared/data/local_data.dart';
import 'package:flexiJobs/features/shared/widgets/app_text.dart';
import 'package:flexiJobs/features/shared/widgets/custom_elevated_button_widget.dart';
import 'package:flexiJobs/features/shared/widgets/forms/text_field_widget.dart';
import 'package:flexiJobs/features/shared/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.completeProfileCubit, this.viewMode = false});
  final CompleteProfileCubit completeProfileCubit;
  final bool viewMode;
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentType? _currentPaymentType;
  GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  String? serviceName;
  String? data;
  String? instaPayData;
  String? mobileWalletData;
  String? teldaData;

  FocusNode instaPay = FocusNode();
  FocusNode mobileWallet = FocusNode();
  FocusNode telda = FocusNode();

  @override
  void initState() {
    if (LocalData.user?.paymentable?.type == "instapays" || LocalData.user?.paymentable?.payment_address != null) {
      _currentPaymentType = PaymentType.instapPay;
      data = LocalData.user?.paymentable?.payment_address;
      instaPayData = data;
    } else if (LocalData.user?.paymentable?.type == "telda" || LocalData.user?.paymentable?.cardNumber != null) {
      _currentPaymentType = PaymentType.prepaid;
      data = LocalData.user?.paymentable?.cardNumber;
      teldaData = data;
    } else {
      _currentPaymentType = PaymentType.mobileWallet;
      // Remove "_cash" suffix if present to get service name (e.g., "vodafone_cash" -> "vodafone")
      String? userServiceType = LocalData.user?.paymentable?.type;
      if (userServiceType != null && userServiceType.endsWith('_cash')) {
        serviceName = userServiceType.replaceAll('_cash', '');
      } else {
        serviceName = userServiceType;
      }
      data = LocalData.user?.paymentable?.number;
      mobileWalletData = data;
    }

    super.initState();
  }

  @override
  void dispose() {
    instaPay.dispose();
    mobileWallet.dispose();
    telda.dispose();
    super.dispose();
  }

  void _clearOtherPaymentMethods(PaymentType selectedType) {
    // Clear the stored data for other payment methods
    // Use WidgetsBinding to ensure clearing happens after the current frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedType != PaymentType.instapPay) {
        instaPayData = null;
        _key.currentState?.fields[PaymentMethodsConstants.instapayKey]?.didChange('');
      }
      if (selectedType != PaymentType.mobileWallet) {
        mobileWalletData = null;
        _key.currentState?.fields[PaymentMethodsConstants.wallet]?.didChange('');
      }
      if (selectedType != PaymentType.prepaid) {
        teldaData = null;
        _key.currentState?.fields[PaymentMethodsConstants.prePaidCrd]?.didChange('');
      }
    });
  }

  bool _isSubmitEnabled() {
    if (_currentPaymentType == null) return false;

    final formState = _key.currentState;
    if (formState == null) return false;

    // Check if the selected payment method has a non-empty value
    if (_currentPaymentType == PaymentType.instapPay) {
      final value = formState.fields[PaymentMethodsConstants.instapayKey]?.value;
      return value != null && value.toString().trim().isNotEmpty;
    } else if (_currentPaymentType == PaymentType.mobileWallet) {
      final value = formState.fields[PaymentMethodsConstants.wallet]?.value;
      final hasValue = value != null && value.toString().trim().isNotEmpty;
      final hasService = serviceName != null && serviceName!.isNotEmpty;
      return hasValue && hasService;
    } else if (_currentPaymentType == PaymentType.prepaid) {
      final value = formState.fields[PaymentMethodsConstants.prePaidCrd]?.value;
      return value != null && value.toString().trim().isNotEmpty;
    }

    return false;
  }

  String? _fieldValue(String key) {
    final dynamic value = _key.currentState?.fields[key]?.value;
    final String? text = value?.toString().trim();
    return text == null || text.isEmpty ? null : text;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _key,
        child: BlocListener<CompleteProfileCubit, CompleteProfileState>(
          bloc: widget.completeProfileCubit,
          listener: (BuildContext context, CompleteProfileState state) {
            if (state is CompleteProfileLoadingState) {
              ViewsToolbox.showLoading();
            } else if (state is CompleteProfileReadyState) {
              ViewsToolbox.dismissLoading();
              ViewsToolbox.showSuccessAwesomeSnackBar(
                  context, context.tr(AppLocalizationKeys.paymentMethodsAddedSuccessfully));

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
                title: context.tr(AppLocalizationKeys.paymentMethod),
              ),
              widget: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  children: <Widget>[
                    PaymentCard(
                      focusNode: instaPay,
                      keyboardType: TextInputType.text,
                      initalValue: instaPayData,
                      label: context.tr(AppLocalizationKeys.enterYourAccountHandle),
                      paymentType: PaymentType.instapPay,
                      title: context.tr(AppLocalizationKeys.instapay),
                      hint: context.tr(AppLocalizationKeys.instapyHint),
                      OnChanged: (PaymentType? type) {
                        // Only update if switching TO a new payment type
                        if (type != null && _currentPaymentType != type) {
                          _clearOtherPaymentMethods(type);
                        }
                        // Always setState to update button state
                        setState(() {
                          if (type != null && _currentPaymentType != type) {
                            _currentPaymentType = type;
                          }
                        });
                      },
                      currentPaymentType: _currentPaymentType,
                    ),
                    10.heightBox,
                    PaymentCard(
                      focusNode: mobileWallet,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 11,
                      initalValue: mobileWalletData,
                      label: context.tr(AppLocalizationKeys.enterMobileNumber),
                      paymentType: PaymentType.mobileWallet,
                      currentServiesType: serviceName,
                      onServiceChanged: (String? value) {
                        setState(() {
                          serviceName = value;
                        });
                      },
                      hint: context.tr(AppLocalizationKeys.phoneNumberHint),
                      title: context.tr(AppLocalizationKeys.mobileWallet),
                      OnChanged: (PaymentType? type) {
                        // Only update if switching TO a new payment type
                        if (type != null && _currentPaymentType != type) {
                          _clearOtherPaymentMethods(type);
                        }
                        // Always setState to update button state
                        setState(() {
                          if (type != null && _currentPaymentType != type) {
                            _currentPaymentType = type;
                          }
                        });
                      },
                      currentPaymentType: _currentPaymentType,
                    ),
                    10.heightBox,
                    PaymentCard(
                      focusNode: telda,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      isMobileNumberField: true,
                      maxLength: 16,
                      viewMode: widget.viewMode,
                      initalValue: teldaData,
                      label: context.tr(AppLocalizationKeys.cardNumber),
                      hint: context.tr(AppLocalizationKeys.phoneNumberHint),
                      paymentType: PaymentType.prepaid,
                      title: context.tr(AppLocalizationKeys.prepaidCards),
                      OnChanged: (PaymentType? type) {
                        // Only update if switching TO a new payment type
                        if (type != null && _currentPaymentType != type) {
                          _clearOtherPaymentMethods(type);
                        }
                        // Always setState to update button state
                        setState(() {
                          if (type != null && _currentPaymentType != type) {
                            _currentPaymentType = type;
                          }
                        });
                      },
                      currentPaymentType: _currentPaymentType,
                    ),
                    30.heightBox,
                    CustomElevatedButton(
                      onPressed: () {
                        if (!_isSubmitEnabled()) return;

                        if (_currentPaymentType != null) {
                          if (_currentPaymentType == PaymentType.instapPay) {
                            final String? paymentAddress = _fieldValue(PaymentMethodsConstants.instapayKey);
                            if (paymentAddress == null) return;
                            widget.completeProfileCubit.completePaymentInfo(
                                completePaymentInfoRequestModel: CompletePaymentInfoRequestModel(
                                    paymentable_type: getPaymentType.paymentName(PaymentType.instapPay),
                                    instapays: InstapayRequestModel(
                                        payment_address: paymentAddress)));
                          } else if (_currentPaymentType == PaymentType.mobileWallet) {
                            if (serviceName != null && serviceName!.isNotEmpty) {
                              final String? walletNumber = _fieldValue(PaymentMethodsConstants.wallet);
                              if (walletNumber == null) return;
                              final String formattedServiceName = serviceName!;
                              widget.completeProfileCubit.completePaymentInfo(
                                  completePaymentInfoRequestModel: CompletePaymentInfoRequestModel(
                                      paymentable_type: getPaymentType.paymentName(PaymentType.mobileWallet),
                                      mobile_wallets: MobileWalletRequestModel(
                                          number: walletNumber,
                                          type: formattedServiceName)));
                            } else {
                              ViewsToolbox.showWarningAwesomeSnackBar(context, context.tr("selectServiceProvider"));
                            }
                          }
                          if (_currentPaymentType == PaymentType.prepaid) {
                            final String? cardNumber = _fieldValue(PaymentMethodsConstants.prePaidCrd);
                            if (cardNumber == null) return;
                            widget.completeProfileCubit.completePaymentInfo(
                                completePaymentInfoRequestModel: CompletePaymentInfoRequestModel(
                                    paymentable_type: getPaymentType.paymentName(PaymentType.prepaid),
                                    pre_paid_cards: MobileWalletRequestModel(
                                        card_number: cardNumber,
                                        type: "telda")));
                          }
                        }
                      },
                      backgroundColor: _isSubmitEnabled() ? Palette.primaryColor : Palette.grey_F0F0F0,
                      width: 0.9.sw,
                      height: 45.h,
                      text: context.tr(AppLocalizationKeys.submit),
                      textStyle: AppTextStyle.semiBold_16,
                    ),
                    40.heightBox,
                  ],
                ),
              )),
        ));
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard(
      {super.key,
      this.keyboardType,
      required this.title,
      this.hint,
      required this.paymentType,
      this.label,
      this.OnChanged,
      this.onServiceChanged,
      this.viewMode = false,
      this.currentPaymentType,
      this.initalValue,
      this.maxLength,
      this.focusNode,
      this.inputFormatters,
      this.isMobileNumberField = false,
      this.currentServiesType});
  final String title;
  final String? hint;
  final String? label;
  final String? initalValue;
  final bool? isMobileNumberField;
  final bool? viewMode;
  final PaymentType paymentType;
  final PaymentType? currentPaymentType;
  final String? currentServiesType;
  final int? maxLength;
  final Function(PaymentType?)? OnChanged;
  final Function(String?)? onServiceChanged;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.paymentType == PaymentType.mobileWallet ? 290.h : 220.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Stack(
            children: <Widget>[
              Card(
                elevation: 1,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.paymentType == PaymentType.mobileWallet ? 40.heightBox : 10.heightBox,
                      widget.paymentType == PaymentType.mobileWallet
                          ? ListOfMobileServicesType(
                              disabled: false,
                              currentService: widget.currentServiesType,
                              onChanged: (String value) {
                                widget.onServiceChanged?.call(value);
                              },
                            )
                          : Container(),
                      30.heightBox,
                      TextFieldWidget(
                        initalValue: widget.initalValue,
                        labelAboveField: widget.label,
                        maxLength: widget.maxLength,
                        keyboardType: widget.keyboardType ?? TextInputType.number,
                        inputFormatters: widget.inputFormatters,
                        disabled: false,
                        keyName: widget.paymentType == PaymentType.instapPay
                            ? PaymentMethodsConstants.instapayKey
                            : widget.paymentType == PaymentType.mobileWallet
                                ? PaymentMethodsConstants.wallet
                                : PaymentMethodsConstants.prePaidCrd,
                        hintText: widget.hint,
                        onChanged: (String? value) {
                          if (value == null || value.isEmpty) {
                            widget.OnChanged?.call(null);
                            widget.onServiceChanged?.call(value);
                          } else {
                            widget.OnChanged?.call(widget.paymentType);
                          }
                        },
                      ),
                      20.heightBox,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: LanguageHelper.isEN(context) ? 3.w : 0, right: LanguageHelper.isAr(context) ? 3.w : 0),
                child: Container(
                  height: 50.h,
                  width: 0.94.sw,
                  decoration: BoxDecoration(
                      color: widget.currentPaymentType == null
                          ? Palette.transparntColor
                          : !(widget.currentPaymentType == widget.paymentType)
                              ? Palette.transparntColor
                              : Palette.grey_F0F0F0,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
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
                              color: widget.currentPaymentType == widget.paymentType
                                  ? Palette.primaryColor
                                  : Palette.transparntColor,
                              border: widget.currentPaymentType == widget.paymentType
                                  ? null
                                  : Border.all(color: Palette.grey_D0D5DDD)),
                          child: widget.currentPaymentType == widget.paymentType
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
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class PaymentMethodsConstants {
  static const String instapayKey = "instapayKey";
  static const String wallet = "wallet";
  static const String prePaidCrd = "prePaidCrd";
}
