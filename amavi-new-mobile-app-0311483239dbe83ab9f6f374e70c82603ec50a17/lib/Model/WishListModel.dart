class WishListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textEmpty;
  String? columnImage;
  String? columnName;
  String? columnModel;
  String? columnStock;
  String? columnPrice;
  String? columnAction;
  String? buttonContinue;
  String? buttonCart;
  String? buttonRemove;
  String? success;
  List<Products>? products;
  String? stock;

  WishListModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textEmpty,
      this.columnImage,
      this.columnName,
      this.columnModel,
      this.columnStock,
      this.columnPrice,
      this.columnAction,
      this.buttonContinue,
      this.buttonCart,
      this.buttonRemove,
      this.success,
      this.products,
      this.stock});

  WishListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textEmpty = json['text_empty'];
    columnImage = json['column_image'];
    columnName = json['column_name'];
    columnModel = json['column_model'];
    columnStock = json['column_stock'];
    columnPrice = json['column_price'];
    columnAction = json['column_action'];
    buttonContinue = json['button_continue'];
    buttonCart = json['button_cart'];
    buttonRemove = json['button_remove'];
    success = json['success'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_empty'] = this.textEmpty;
    data['column_image'] = this.columnImage;
    data['column_name'] = this.columnName;
    data['column_model'] = this.columnModel;
    data['column_stock'] = this.columnStock;
    data['column_price'] = this.columnPrice;
    data['column_action'] = this.columnAction;
    data['button_continue'] = this.buttonContinue;
    data['button_cart'] = this.buttonCart;
    data['button_remove'] = this.buttonRemove;
    data['success'] = this.success;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    data['stock'] = this.stock;
    return data;
  }
}

class Breadcrumbs {
  String? text;
  String? href;

  Breadcrumbs({this.text, this.href});

  Breadcrumbs.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['href'] = this.href;
    return data;
  }
}

class Products {
  String? productId;
  String? stock;
  String? quantity;
  String? thumb;
  String? name;
  String? model;
  String? price;
  var special;
  String? href;
  String? remove;

  Products(
      {this.productId,
      this.stock,
      this.quantity,
      this.thumb,
      this.name,
      this.model,
      this.price,
      this.special,
      this.href,
      this.remove});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    stock = json['stock'];
    quantity = json['quantity'];
    thumb = json['thumb'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    special = json['special'];
    href = json['href'];
    remove = json['remove'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['stock'] = this.stock;
    data['quantity'] = this.quantity;
    data['thumb'] = this.thumb;
    data['name'] = this.name;
    data['model'] = this.model;
    data['price'] = this.price;
    data['special'] = this.special;
    data['href'] = this.href;
    data['remove'] = this.remove;
    return data;
  }
}
