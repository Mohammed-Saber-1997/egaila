class Payments {
  int? paymentSerial;
  double? paidAmount;
  int? paymentType;
  String? paymentTypeName;
  String? cardID;
  String? receiptID;

  Payments(
      {this.paymentSerial,
      this.paidAmount,
      this.paymentType,
      this.paymentTypeName,
      this.cardID,
      this.receiptID});

  Payments.fromJson(Map<String, dynamic> json) {
    paymentSerial = json['payment_Serial'];
    paidAmount = json['paid_Amount'];
    paymentType = json['payment_Type'];
    paymentTypeName = json['payment_Type_Name'];
    cardID = json['card_ID'];
    receiptID = json['receipt_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_Serial'] = this.paymentSerial;
    data['paid_Amount'] = this.paidAmount;
    data['payment_Type'] = this.paymentType;
    data['payment_Type_Name'] = this.paymentTypeName;
    data['card_ID'] = this.cardID;
    data['receipt_ID'] = this.receiptID;
    return data;
  }
}
