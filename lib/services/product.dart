class Product {
  int? productId;
  String? barcode;
  String? productName;
  String? sourceName;

  Product({this.productId, this.barcode, this.productName, this.sourceName});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    barcode = json['barcode'];
    productName = json['product_name'];
    sourceName = json['source_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['barcode'] = this.barcode;
    data['product_name'] = this.productName;
    data['source_name'] = this.sourceName;
    return data;
  }
}