enum PaymentType { prepaid, mobileWallet,instapPay }

extension getPaymentType on PaymentType {
  static String paymentName(PaymentType type) {
    switch (type) {
      case PaymentType.prepaid:
        return "pre_paid_cards";
      case PaymentType.instapPay:
        return "instapays";
      case PaymentType.mobileWallet:
        return "mobile_wallets";
    }
  }
}
