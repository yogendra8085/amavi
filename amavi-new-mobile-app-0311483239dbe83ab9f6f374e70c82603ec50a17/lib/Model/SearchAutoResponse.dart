class SearchAutoResponse {
  String? productId;
  String? name;
  String? model;
  String? price;

  SearchAutoResponse({this.productId, this.name, this.model, this.price});

  SearchAutoResponse.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['model'] = this.model;
    data['price'] = this.price;
    return data;
  }
}
