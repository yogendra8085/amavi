class AddToCartModel {
  var success;
  var total;
  //ApiId apiId;
  var sessionId;
  List<Cart>? cart;

  AddToCartModel({this.success, this.total, this.sessionId, this.cart});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    total = json['total'];
    // apiId = json['api_id'] != null ? new ApiId.fromJson(json['api_id']) : null;
    sessionId = json['session_id'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart?.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['total'] = this.total;
    // if (this.apiId != null) {
    //   data['api_id'] = this.apiId.toJson();
    // }
    data['session_id'] = this.sessionId;
    if (this.cart != null) {
      data['cart'] = this.cart?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApiId {
  var sessionId;
  Data? data;
  Adaptor? adaptor;

  ApiId({this.sessionId, this.data, this.adaptor});

  ApiId.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    adaptor =
        json['adaptor'] != null ? new Adaptor.fromJson(json['adaptor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    if (this.adaptor != null) {
      data['adaptor'] = this.adaptor?.toJson();
    }
    return data;
  }
}

class Data {
  var language;
  var currency;
  var customerId;
  bool? shippingAddress;

  Data({this.language, this.currency, this.customerId, this.shippingAddress});

  Data.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    currency = json['currency'];
    customerId = json['customer_id'];
    shippingAddress = json['shipping_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['currency'] = this.currency;
    data['customer_id'] = this.customerId;
    data['shipping_address'] = this.shippingAddress;
    return data;
  }
}

class Adaptor {
//  Adaptor({});

  Adaptor.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Cart {
  var cartId;
  var thumb;
  var id;
  var name;
  var model;
  List<Null>? option;
  var recurring;
  var quantity;
  bool? stock;
  var reward;
  var price;
  var total;
  var href;

  Cart(
      {this.cartId,
      this.thumb,
      this.id,
      this.name,
      this.model,
      this.option,
      this.recurring,
      this.quantity,
      this.stock,
      this.reward,
      this.price,
      this.total,
      this.href});

  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    thumb = json['thumb'];
    id = json['id'];
    name = json['name'];
    model = json['model'];
    // if (json['option'] != null) {
    //   option = new List<Null>();
    //   json['option'].forEach((v) { option.add(new Null.fromJson(v)); });
    // }
    recurring = json['recurring'];
    quantity = json['quantity'];
    stock = json['stock'];
    reward = json['reward'];
    price = json['price'];
    total = json['total'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['thumb'] = this.thumb;
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    // if (this.option != null) {
    //   data['option'] = this.option.map((v) => v.toJson()).toList();
//    }
    data['recurring'] = this.recurring;
    data['quantity'] = this.quantity;
    data['stock'] = this.stock;
    data['reward'] = this.reward;
    data['price'] = this.price;
    data['total'] = this.total;
    data['href'] = this.href;
    return data;
  }
}
