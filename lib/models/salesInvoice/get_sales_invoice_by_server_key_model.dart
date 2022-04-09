import 'dart:convert';

import 'details.dart';
import 'payments.dart';

GetSalesInvoiceByServerKeyModel getSalesInvoiceByServerKeyModelFromJson(String str) => GetSalesInvoiceByServerKeyModel.fromJson(json.decode(str));

String getSalesInvoiceByServerKeyModelToJson(GetSalesInvoiceByServerKeyModel data) => json.encode(data.toJson());

class GetSalesInvoiceByServerKeyModel {
  int? serveRKEY;
  int? iKEY;
  int? invoiceID;
  int? poSID;
  int? locationID;
  String? locationName;
  int? currentYear;
  int? shiftID;
  int? invoiceType;
  int? invoiceStatus;
  String? note;
  int? customerID;
  double? customerBalance;
  String? customerName;
  double? invoiceHeaderTotalAmount;
  bool? zREADING;
  Null zReadingKey;
  bool? isPosted;
  String? postedAT;
  int? writtenBy;
  String? writtenAt;
  double? invoiceTotalAmount;
  double? invoiceTotalUnCashPayment;
  double? invoiceTotalPayment;
  String? userFullName;
  List<Details>? details;
  List<Payments>? payments;

  GetSalesInvoiceByServerKeyModel(
      {this.serveRKEY,
      this.iKEY,
      this.invoiceID,
      this.poSID,
      this.locationID,
      this.locationName,
      this.currentYear,
      this.shiftID,
      this.invoiceType,
      this.invoiceStatus,
      this.note,
      this.customerID,
      this.customerBalance,
      this.customerName,
      this.invoiceHeaderTotalAmount,
      this.zREADING,
      this.zReadingKey,
      this.isPosted,
      this.postedAT,
      this.writtenBy,
      this.writtenAt,
      this.invoiceTotalAmount,
      this.invoiceTotalUnCashPayment,
      this.invoiceTotalPayment,
      this.userFullName,
      this.details,
      this.payments});

  GetSalesInvoiceByServerKeyModel.fromJson(Map<String, dynamic> json) {
    serveRKEY = json['serveR_KEY'];
    iKEY = json['i_KEY'];
    invoiceID = json['invoice_ID'];
    poSID = json['poS_ID'];
    locationID = json['location_ID'];
    locationName = json['location_Name'];
    currentYear = json['current_Year'];
    shiftID = json['shift_ID'];
    invoiceType = json['invoice_Type'];
    invoiceStatus = json['invoice_Status'];
    note = json['note'];
    customerID = json['customer_ID'];
    customerBalance = json['customer_Balance'];
    customerName = json['customer_Name'];
    invoiceHeaderTotalAmount = json['invoice_Header_Total_Amount'];
    zREADING = json['z_READING'];
    zReadingKey = json['z_Reading_Key'];
    isPosted = json['is_Posted'];
    postedAT = json['posted_AT'];
    writtenBy = json['written_By'];
    writtenAt = json['written_At'];
    invoiceTotalAmount = json['invoice_Total_Amount'];
    invoiceTotalUnCashPayment = json['invoice_Total_UnCash_Payment'];
    invoiceTotalPayment = json['invoice_Total_Payment'];
    userFullName = json['user_Full_Name'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    if (json['payments'] != null) {
      payments = [];
      json['payments'].forEach((v) {
        payments!.add(new Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serveR_KEY'] = this.serveRKEY;
    data['i_KEY'] = this.iKEY;
    data['invoice_ID'] = this.invoiceID;
    data['poS_ID'] = this.poSID;
    data['location_ID'] = this.locationID;
    data['location_Name'] = this.locationName;
    data['current_Year'] = this.currentYear;
    data['shift_ID'] = this.shiftID;
    data['invoice_Type'] = this.invoiceType;
    data['invoice_Status'] = this.invoiceStatus;
    data['note'] = this.note;
    data['customer_ID'] = this.customerID;
    data['customer_Balance'] = this.customerBalance;
    data['customer_Name'] = this.customerName;
    data['invoice_Header_Total_Amount'] = this.invoiceHeaderTotalAmount;
    data['z_READING'] = this.zREADING;
    data['z_Reading_Key'] = this.zReadingKey;
    data['is_Posted'] = this.isPosted;
    data['posted_AT'] = this.postedAT;
    data['written_By'] = this.writtenBy;
    data['written_At'] = this.writtenAt;
    data['invoice_Total_Amount'] = this.invoiceTotalAmount;
    data['invoice_Total_UnCash_Payment'] = this.invoiceTotalUnCashPayment;
    data['invoice_Total_Payment'] = this.invoiceTotalPayment;
    data['user_Full_Name'] = this.userFullName;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
