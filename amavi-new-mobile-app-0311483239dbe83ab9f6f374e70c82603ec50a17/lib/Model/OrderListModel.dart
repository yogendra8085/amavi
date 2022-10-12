class OrderListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textEmpty;
  String? columnOrderId;
  String? columnCustomer;
  String? columnProduct;
  String? columnTotal;
  String? columnStatus;
  String? columnDateAdded;
  String? buttonView;
  String? buttonContinue;
  List<Orders>? orders;
  String? pagination;
  String? results;
  String? totalOrders;
  int? currentPage;
  int? totalPage;
  String? nextPageUrl;
  String? continues;

  OrderListModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textEmpty,
      this.columnOrderId,
      this.columnCustomer,
      this.columnProduct,
      this.columnTotal,
      this.columnStatus,
      this.columnDateAdded,
      this.buttonView,
      this.buttonContinue,
      this.orders,
      this.pagination,
      this.results,
      this.totalOrders,
      this.currentPage,
      this.totalPage,
      this.nextPageUrl,
      this.continues});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textEmpty = json['text_empty'];
    columnOrderId = json['column_order_id'];
    columnCustomer = json['column_customer'];
    columnProduct = json['column_product'];
    columnTotal = json['column_total'];
    columnStatus = json['column_status'];
    columnDateAdded = json['column_date_added'];
    buttonView = json['button_view'];
    buttonContinue = json['button_continue'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders?.add(new Orders.fromJson(v));
      });
    }
    pagination = json['pagination'];
    results = json['results'];
    totalOrders = json['total_orders'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
    nextPageUrl = json['next_page_url'];
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_empty'] = this.textEmpty;
    data['column_order_id'] = this.columnOrderId;
    data['column_customer'] = this.columnCustomer;
    data['column_product'] = this.columnProduct;
    data['column_total'] = this.columnTotal;
    data['column_status'] = this.columnStatus;
    data['column_date_added'] = this.columnDateAdded;
    data['button_view'] = this.buttonView;
    data['button_continue'] = this.buttonContinue;
    if (this.orders != null) {
      data['orders'] = this.orders?.map((v) => v.toJson()).toList();
    }
    data['pagination'] = this.pagination;
    data['results'] = this.results;
    data['total_orders'] = this.totalOrders;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    data['next_page_url'] = this.nextPageUrl;
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

class Orders {
  String? orderId;
  String? name;
  String? status;
  String? dateAdded;
  int? products;
  String? total;
  String? view;

  Orders(
      {this.orderId,
      this.name,
      this.status,
      this.dateAdded,
      this.products,
      this.total,
      this.view});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    name = json['name'];
    status = json['status'];
    dateAdded = json['date_added'];
    products = json['products'];
    total = json['total'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['date_added'] = this.dateAdded;
    data['products'] = this.products;
    data['total'] = this.total;
    data['view'] = this.view;
    return data;
  }
}
