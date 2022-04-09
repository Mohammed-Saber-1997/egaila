class Details {
  int? ser;
  String? barcode;
  String? itemCode;
  int? itemLocation;
  double? factor;
  int? itemType;
  String? itemShortDescription;
  double? qty;
  double? itemPrice;
  double? oPrice;
  int? pID;
  int? pType;
  double? cost;
  bool? isWeighing;
  String? weightID;
  double? totalItemPrice;

  Details(
      {this.ser,
      this.barcode,
      this.itemCode,
      this.itemLocation,
      this.factor,
      this.itemType,
      this.itemShortDescription,
      this.qty,
      this.itemPrice,
      this.oPrice,
      this.pID,
      this.pType,
      this.cost,
      this.isWeighing,
      this.weightID,
      this.totalItemPrice});

  Details.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    barcode = json['barcode'];
    itemCode = json['item_Code'];
    itemLocation = json['item_Location'];
    factor = json['factor'];
    itemType = json['item_Type'];
    itemShortDescription = json['item_Short_Description'];
    qty = json['qty'];
    itemPrice = json['item_Price'];
    oPrice = json['o_Price'];
    pID = json['p_ID'];
    pType = json['p_Type'];
    cost = json['cost'];
    isWeighing = json['is_Weighing'];
    weightID = json['weight_ID'];
    totalItemPrice = json['total_Item_Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['barcode'] = this.barcode;
    data['item_Code'] = this.itemCode;
    data['item_Location'] = this.itemLocation;
    data['factor'] = this.factor;
    data['item_Type'] = this.itemType;
    data['item_Short_Description'] = this.itemShortDescription;
    data['qty'] = this.qty;
    data['item_Price'] = this.itemPrice;
    data['o_Price'] = this.oPrice;
    data['p_ID'] = this.pID;
    data['p_Type'] = this.pType;
    data['cost'] = this.cost;
    data['is_Weighing'] = this.isWeighing;
    data['weight_ID'] = this.weightID;
    data['total_Item_Price'] = this.totalItemPrice;
    return data;
  }
}
