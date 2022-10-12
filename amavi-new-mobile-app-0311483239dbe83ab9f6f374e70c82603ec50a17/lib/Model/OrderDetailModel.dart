class OrderDetailModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textOrderDetail;
  String? textInvoiceNo;
  String? textOrderId;
  String? textDateAdded;
  String? textShippingMethod;
  String? textShippingAddress;
  String? textPaymentMethod;
  String? textPaymentAddress;
  String? textHistory;
  String? textComment;
  String? textNoResults;
  String? columnName;
  String? columnModel;
  String? columnQuantity;
  String? columnPrice;
  String? columnTotal;
  String? columnAction;
  String? columnDateAdded;
  String? columnStatus;
  String? columnComment;
  String? buttonReorder;
  String? buttonReturn;
  String? buttonContinue;
  String? errorWarning;
  String? success;
  String? invoiceNo;
  String? orderId;
  String? dateAdded;
  String? paymentAddress;
  String? paymentMethod;
  String? shippingAddress;
  String? shippingMethod;
  List<Products>? products;
  List<Null>? vouchers;
  List<Totals>? totals;
  String? comment;
  List<Histories>? histories;
  String? continues;

  OrderDetailModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textOrderDetail,
      this.textInvoiceNo,
      this.textOrderId,
      this.textDateAdded,
      this.textShippingMethod,
      this.textShippingAddress,
      this.textPaymentMethod,
      this.textPaymentAddress,
      this.textHistory,
      this.textComment,
      this.textNoResults,
      this.columnName,
      this.columnModel,
      this.columnQuantity,
      this.columnPrice,
      this.columnTotal,
      this.columnAction,
      this.columnDateAdded,
      this.columnStatus,
      this.columnComment,
      this.buttonReorder,
      this.buttonReturn,
      this.buttonContinue,
      this.errorWarning,
      this.success,
      this.invoiceNo,
      this.orderId,
      this.dateAdded,
      this.paymentAddress,
      this.paymentMethod,
      this.shippingAddress,
      this.shippingMethod,
      this.products,
      this.vouchers,
      this.totals,
      this.comment,
      this.histories,
      this.continues});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textOrderDetail = json['text_order_detail'];
    textInvoiceNo = json['text_invoice_no'];
    textOrderId = json['text_order_id'];
    textDateAdded = json['text_date_added'];
    textShippingMethod = json['text_shipping_method'];
    textShippingAddress = json['text_shipping_address'];
    textPaymentMethod = json['text_payment_method'];
    textPaymentAddress = json['text_payment_address'];
    textHistory = json['text_history'];
    textComment = json['text_comment'];
    textNoResults = json['text_no_results'];
    columnName = json['column_name'];
    columnModel = json['column_model'];
    columnQuantity = json['column_quantity'];
    columnPrice = json['column_price'];
    columnTotal = json['column_total'];
    columnAction = json['column_action'];
    columnDateAdded = json['column_date_added'];
    columnStatus = json['column_status'];
    columnComment = json['column_comment'];
    buttonReorder = json['button_reorder'];
    buttonReturn = json['button_return'];
    buttonContinue = json['button_continue'];
    errorWarning = json['error_warning'];
    success = json['success'];
    invoiceNo = json['invoice_no'];
    orderId = json['order_id'];
    dateAdded = json['date_added'];
    paymentAddress = json['payment_address'];
    paymentMethod = json['payment_method'];
    shippingAddress = json['shipping_address'];
    shippingMethod = json['shipping_method'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = [];
//json['vouchers'].forEach((v) { vouchers.add(new Null.fromJson(v)); });
    }
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals?.add(new Totals.fromJson(v));
      });
    }
    comment = json['comment'];
    if (json['histories'] != null) {
      histories = <Histories>[];
      json['histories'].forEach((v) {
        histories?.add(new Histories.fromJson(v));
      });
    }
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_order_detail'] = this.textOrderDetail;
    data['text_invoice_no'] = this.textInvoiceNo;
    data['text_order_id'] = this.textOrderId;
    data['text_date_added'] = this.textDateAdded;
    data['text_shipping_method'] = this.textShippingMethod;
    data['text_shipping_address'] = this.textShippingAddress;
    data['text_payment_method'] = this.textPaymentMethod;
    data['text_payment_address'] = this.textPaymentAddress;
    data['text_history'] = this.textHistory;
    data['text_comment'] = this.textComment;
    data['text_no_results'] = this.textNoResults;
    data['column_name'] = this.columnName;
    data['column_model'] = this.columnModel;
    data['column_quantity'] = this.columnQuantity;
    data['column_price'] = this.columnPrice;
    data['column_total'] = this.columnTotal;
    data['column_action'] = this.columnAction;
    data['column_date_added'] = this.columnDateAdded;
    data['column_status'] = this.columnStatus;
    data['column_comment'] = this.columnComment;
    data['button_reorder'] = this.buttonReorder;
    data['button_return'] = this.buttonReturn;
    data['button_continue'] = this.buttonContinue;
    data['error_warning'] = this.errorWarning;
    data['success'] = this.success;
    data['invoice_no'] = this.invoiceNo;
    data['order_id'] = this.orderId;
    data['date_added'] = this.dateAdded;
    data['payment_address'] = this.paymentAddress;
    data['payment_method'] = this.paymentMethod;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_method'] = this.shippingMethod;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
//    data['vouchers'] = this.vouchers.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals?.map((v) => v.toJson()).toList();
    }
    data['comment'] = this.comment;
    if (this.histories != null) {
      data['histories'] = this.histories?.map((v) => v.toJson()).toList();
    }
    data['continue'] = this.continues;
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
  String? name;
  String? model;
  List<Null>? option;
  String? quantity;
  String? price;
  String? total;
  String? reorder;
  String? returns;

  Products(
      {this.name,
      this.model,
      this.option,
      this.quantity,
      this.price,
      this.total,
      this.reorder,
      this.returns});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    model = json['model'];
    if (json['option'] != null) {
      option = <Null>[];
//json['option'].forEach((v) { option.add(new Null.fromJson(v)); });
    }
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    reorder = json['reorder'];
    returns = json['return'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['model'] = this.model;
    if (this.option != null) {
//    data['option'] = this.option.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total'] = this.total;
    data['reorder'] = this.reorder;
    data['return'] = this.returns;
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

class Histories {
  String? dateAdded;
  String? status;
  String? comment;

  Histories({this.dateAdded, this.status, this.comment});

  Histories.fromJson(Map<String, dynamic> json) {
    dateAdded = json['date_added'];
    status = json['status'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_added'] = this.dateAdded;
    data['status'] = this.status;
    data['comment'] = this.comment;
    return data;
  }
}
