class ConfirmOrderModel {
  int? orderId;
  String? textRecurringItem;
  String? textPaymentRecurring;
  String? columnName;
  String? columnModel;
  String? columnQuantity;
  String? columnPrice;
  String? columnTotal;
  List<Products>? products;
  List<Null>? vouchers;
  List<Totals>? totals;
  Payment? payment;
  String? paymentCode;

  ConfirmOrderModel(
      {this.orderId,
      this.textRecurringItem,
      this.textPaymentRecurring,
      this.columnName,
      this.columnModel,
      this.columnQuantity,
      this.columnPrice,
      this.columnTotal,
      this.products,
      this.vouchers,
      this.totals,
      this.payment,
      this.paymentCode});

  ConfirmOrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    textRecurringItem = json['text_recurring_item'];
    textPaymentRecurring = json['text_payment_recurring'];
    columnName = json['column_name'];
    columnModel = json['column_model'];
    columnQuantity = json['column_quantity'];
    columnPrice = json['column_price'];
    columnTotal = json['column_total'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      // vouchers = new List<Null>();
      // json['vouchers'].forEach((v) { vouchers.add(new Null.fromJson(v)); });
    }
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals?.add(new Totals.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    paymentCode = json['payment_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['text_recurring_item'] = this.textRecurringItem;
    data['text_payment_recurring'] = this.textPaymentRecurring;
    data['column_name'] = this.columnName;
    data['column_model'] = this.columnModel;
    data['column_quantity'] = this.columnQuantity;
    data['column_price'] = this.columnPrice;
    data['column_total'] = this.columnTotal;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
      //   data['vouchers'] = this.vouchers.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals?.map((v) => v.toJson()).toList();
    }
    if (this.payment != null) {
      data['payment'] = this.payment?.toJson();
    }
    data['payment_code'] = this.paymentCode;
    return data;
  }
}

class Products {
  String? cartId;
  String? productId;
  String? name;
  String? model;
  List<Option>? option;
  String? recurring;
  String? quantity;
  String? subtract;
  String? price;
  String? total;
  String? href;

  Products(
      {this.cartId,
      this.productId,
      this.name,
      this.model,
      this.option,
      this.recurring,
      this.quantity,
      this.subtract,
      this.price,
      this.total,
      this.href});

  Products.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    name = json['name'];
    model = json['model'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option?.add(new Option.fromJson(v));
      });
    }
    recurring = json['recurring'];
    quantity = json['quantity'];
    subtract = json['subtract'];
    price = json['price'];
    total = json['total'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.option != null) {
      data['option'] = this.option?.map((v) => v.toJson()).toList();
    }
    data['recurring'] = this.recurring;
    data['quantity'] = this.quantity;
    data['subtract'] = this.subtract;
    data['price'] = this.price;
    data['total'] = this.total;
    data['href'] = this.href;
    return data;
  }
}

class Option {
  String? name;
  String? value;

  Option({this.name, this.value});

  Option.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class Totals {
  String? title;
  String? text;

  Totals({this.title, this.text});

  Totals.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    return data;
  }
}

class Payment {
  String? buttonConfirm;
  String? textLoading;
  String? continues;

  Payment({this.buttonConfirm, this.textLoading, this.continues});

  Payment.fromJson(Map<String, dynamic> json) {
    buttonConfirm = json['button_confirm'];
    textLoading = json['text_loading'];
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['button_confirm'] = this.buttonConfirm;
    data['text_loading'] = this.textLoading;
    data['continue'] = this.continues;
    return data;
  }
}
