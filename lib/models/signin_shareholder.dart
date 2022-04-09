import 'dart:convert';

List<SignInShareholderModel> shareholderModelFromJson(String str) =>
    List<SignInShareholderModel>.from(
        json.decode(str).map((x) => SignInShareholderModel.fromJson(x)));

String shareholderModelToJson(List<SignInShareholderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SignInShareholderModel {
  int? shhId;
  int? shhMembershipId;
  String? shhTitle;
  String? shhNameTitle;
  String? shhName;
  String? shhFamilyName;
  String? shhCivilId;
  String? shhBirthdate;
  bool? shhGender;
  String? genderName;
  int? shhMaritalStatusId;
  String? maritalStatusDescription;
  int? shhJobTitleId;
  String? jobTitleName;
  int? shhAreaId;
  String? areaName;
  int? shhSectionId;
  String? sectionName;
  String? shhStreet;
  String? shhAvenuNo;
  String? shhHomeNo;
  String? shhFloorNo;
  String? shhApartmentNo;
  String? shhPostalBoxNo;
  String? shhPostalCode;
  String? shhHomePhoneNo;
  String? shhWorkPhone;
  String? shhMobile;
  String? shhMobile2;
  String? shhWorkAt;
  String? shhWorkAddress;
  String? shhEmail;
  int? shhTypeId;
  String? shareholderTypeDesc;
  int? shhStatusId;
  String? shareholderStatusDesc;
  int? shhBankId;
  String? bankName;
  String? bankENName;
  String? bankCode;
  String? shhAccountNo;
  String? shhGuardianName;
  int? shhKinshipId;
  String? kinshipName;
  String? shhSessionNo;
  String? shhSessionDate;
  bool? shhIsInActiveOnPOS;
  bool? shhPrintNameOnInvoice;
  bool? shhHasProfits;
  bool? shhIsDataCompleted;
  String? shhPOSName;
  String? shhNotes;
  String? fC;
  int? sharesCount;
  String? addressID;
  bool? isSubscribedInAdministration;
  String? voucherNumber;
  String? voucherDate;
  int? writtenBy;
  String? writtenAt;
  int? lastUpdatedBy;
  String? lastUpdatedAt;

  SignInShareholderModel(
      {this.shhId,
      this.shhMembershipId,
      this.shhTitle,
      this.shhNameTitle,
      this.shhName,
      this.shhFamilyName,
      this.shhCivilId,
      this.shhBirthdate,
      this.shhGender,
      this.genderName,
      this.shhMaritalStatusId,
      this.maritalStatusDescription,
      this.shhJobTitleId,
      this.jobTitleName,
      this.shhAreaId,
      this.areaName,
      this.shhSectionId,
      this.sectionName,
      this.shhStreet,
      this.shhAvenuNo,
      this.shhHomeNo,
      this.shhFloorNo,
      this.shhApartmentNo,
      this.shhPostalBoxNo,
      this.shhPostalCode,
      this.shhHomePhoneNo,
      this.shhWorkPhone,
      this.shhMobile,
      this.shhMobile2,
      this.shhWorkAt,
      this.shhWorkAddress,
      this.shhEmail,
      this.shhTypeId,
      this.shareholderTypeDesc,
      this.shhStatusId,
      this.shareholderStatusDesc,
      this.shhBankId,
      this.bankName,
      this.bankENName,
      this.bankCode,
      this.shhAccountNo,
      this.shhGuardianName,
      this.shhKinshipId,
      this.kinshipName,
      this.shhSessionNo,
      this.shhSessionDate,
      this.shhIsInActiveOnPOS,
      this.shhPrintNameOnInvoice,
      this.shhHasProfits,
      this.shhIsDataCompleted,
      this.shhPOSName,
      this.shhNotes,
      this.fC,
      this.sharesCount,
      this.addressID,
      this.isSubscribedInAdministration,
      this.voucherNumber,
      this.voucherDate,
      this.writtenBy,
      this.writtenAt,
      this.lastUpdatedBy,
      this.lastUpdatedAt});

  SignInShareholderModel.fromJson(Map<String, dynamic> json) {
    shhId = json['shh_Id'];
    shhMembershipId = json['shh_Membership_Id'];
    shhTitle = json['shh_Title'];
    shhNameTitle = json['shh_Name_Title'];
    shhName = json['shh_Name'];
    shhFamilyName = json['shh_FamilyName'];
    shhCivilId = json['shh_Civil_Id'];
    shhBirthdate = json['shh_birthdate'];
    shhGender = json['shh_Gender'];
    genderName = json['gender_Name'];
    shhMaritalStatusId = json['shh_Marital_Status_Id'];
    maritalStatusDescription = json['marital_Status_Description'];
    shhJobTitleId = json['shh_JobTitle_Id'];
    jobTitleName = json['job_Title_Name'];
    shhAreaId = json['shh_Area_Id'];
    areaName = json['area_Name'];
    shhSectionId = json['shh_Section_Id'];
    sectionName = json['section_Name'];
    shhStreet = json['shh_Street'];
    shhAvenuNo = json['shh_Avenu_No'];
    shhHomeNo = json['shh_Home_No'];
    shhFloorNo = json['shh_Floor_No'];
    shhApartmentNo = json['shh_Apartment_No'];
    shhPostalBoxNo = json['shh_PostalBox_No'];
    shhPostalCode = json['shh_Postal_Code'];
    shhHomePhoneNo = json['shh_Home_Phone_No'];
    shhWorkPhone = json['shh_Work_Phone'];
    shhMobile = json['shh_Mobile'];
    shhMobile2 = json['shh_Mobile2'];
    shhWorkAt = json['shh_Work_At'];
    shhWorkAddress = json['shh_Work_Address'];
    shhEmail = json['shh_Email'];
    shhTypeId = json['shh_Type_Id'];
    shareholderTypeDesc = json['shareholder_Type_Desc'];
    shhStatusId = json['shh_Status_Id'];
    shareholderStatusDesc = json['shareholder_Status_Desc'];
    shhBankId = json['shh_Bank_Id'];
    bankName = json['bank_Name'];
    bankENName = json['bank_EN_Name'];
    bankCode = json['bank_Code'];
    shhAccountNo = json['shh_Account_No'];
    shhGuardianName = json['shh_Guardian_Name'];
    shhKinshipId = json['shh_Kinship_Id'];
    kinshipName = json['kinship_Name'];
    shhSessionNo = json['shh_Session_No'];
    shhSessionDate = json['shh_Session_Date'];
    shhIsInActiveOnPOS = json['shh_IsInActiveOnPOS'];
    shhPrintNameOnInvoice = json['shh_PrintNameOnInvoice'];
    shhHasProfits = json['shh_HasProfits'];
    shhIsDataCompleted = json['shh_IsDataCompleted'];
    shhPOSName = json['shh_POSName'];
    shhNotes = json['shh_Notes'];
    fC = json['f_C'];
    sharesCount = json['sharesCount'];
    addressID = json['address_ID'];
    isSubscribedInAdministration = json['is_Subscribed_in_Administration'];
    voucherNumber = json['voucherNumber'];
    voucherDate = json['voucherDate'];
    writtenBy = json['written_By'];
    writtenAt = json['written_At'];
    lastUpdatedBy = json['last_Updated_By'];
    lastUpdatedAt = json['last_Updated_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shh_Id'] = this.shhId;
    data['shh_Membership_Id'] = this.shhMembershipId;
    data['shh_Title'] = this.shhTitle;
    data['shh_Name_Title'] = this.shhNameTitle;
    data['shh_Name'] = this.shhName;
    data['shh_FamilyName'] = this.shhFamilyName;
    data['shh_Civil_Id'] = this.shhCivilId;
    data['shh_birthdate'] = this.shhBirthdate;
    data['shh_Gender'] = this.shhGender;
    data['gender_Name'] = this.genderName;
    data['shh_Marital_Status_Id'] = this.shhMaritalStatusId;
    data['marital_Status_Description'] = this.maritalStatusDescription;
    data['shh_JobTitle_Id'] = this.shhJobTitleId;
    data['job_Title_Name'] = this.jobTitleName;
    data['shh_Area_Id'] = this.shhAreaId;
    data['area_Name'] = this.areaName;
    data['shh_Section_Id'] = this.shhSectionId;
    data['section_Name'] = this.sectionName;
    data['shh_Street'] = this.shhStreet;
    data['shh_Avenu_No'] = this.shhAvenuNo;
    data['shh_Home_No'] = this.shhHomeNo;
    data['shh_Floor_No'] = this.shhFloorNo;
    data['shh_Apartment_No'] = this.shhApartmentNo;
    data['shh_PostalBox_No'] = this.shhPostalBoxNo;
    data['shh_Postal_Code'] = this.shhPostalCode;
    data['shh_Home_Phone_No'] = this.shhHomePhoneNo;
    data['shh_Work_Phone'] = this.shhWorkPhone;
    data['shh_Mobile'] = this.shhMobile;
    data['shh_Mobile2'] = this.shhMobile2;
    data['shh_Work_At'] = this.shhWorkAt;
    data['shh_Work_Address'] = this.shhWorkAddress;
    data['shh_Email'] = this.shhEmail;
    data['shh_Type_Id'] = this.shhTypeId;
    data['shareholder_Type_Desc'] = this.shareholderTypeDesc;
    data['shh_Status_Id'] = this.shhStatusId;
    data['shareholder_Status_Desc'] = this.shareholderStatusDesc;
    data['shh_Bank_Id'] = this.shhBankId;
    data['bank_Name'] = this.bankName;
    data['bank_EN_Name'] = this.bankENName;
    data['bank_Code'] = this.bankCode;
    data['shh_Account_No'] = this.shhAccountNo;
    data['shh_Guardian_Name'] = this.shhGuardianName;
    data['shh_Kinship_Id'] = this.shhKinshipId;
    data['kinship_Name'] = this.kinshipName;
    data['shh_Session_No'] = this.shhSessionNo;
    data['shh_Session_Date'] = this.shhSessionDate;
    data['shh_IsInActiveOnPOS'] = this.shhIsInActiveOnPOS;
    data['shh_PrintNameOnInvoice'] = this.shhPrintNameOnInvoice;
    data['shh_HasProfits'] = this.shhHasProfits;
    data['shh_IsDataCompleted'] = this.shhIsDataCompleted;
    data['shh_POSName'] = this.shhPOSName;
    data['shh_Notes'] = this.shhNotes;
    data['f_C'] = this.fC;
    data['sharesCount'] = this.sharesCount;
    data['address_ID'] = this.addressID;
    data['is_Subscribed_in_Administration'] = this.isSubscribedInAdministration;
    data['voucherNumber'] = this.voucherNumber;
    data['voucherDate'] = this.voucherDate;
    data['written_By'] = this.writtenBy;
    data['written_At'] = this.writtenAt;
    data['last_Updated_By'] = this.lastUpdatedBy;
    data['last_Updated_At'] = this.lastUpdatedAt;
    return data;
  }
}
