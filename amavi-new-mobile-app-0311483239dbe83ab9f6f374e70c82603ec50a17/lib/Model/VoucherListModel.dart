class VoucherListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textCheckBalance;
  String? textCardNumber;
  String? textPin;
  List<Vouchers>? vouchers;
  String? continues;

  VoucherListModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textCheckBalance,
      this.textCardNumber,
      this.textPin,
      this.vouchers,
      this.continues});

  VoucherListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textCheckBalance = json['text_check_balance'];
    textCardNumber = json['text_card_number'];
    textPin = json['text_pin'];
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers?.add(new Vouchers.fromJson(v));
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
    data['text_check_balance'] = this.textCheckBalance;
    data['text_card_number'] = this.textCardNumber;
    data['text_pin'] = this.textPin;
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers?.map((v) => v.toJson()).toList();
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

class Vouchers {
  String? code;
  String? pin;

  Vouchers({this.code, this.pin});

  Vouchers.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['pin'] = this.pin;
    return data;
  }
}

class History {
  String? orderId;
  String? amount;
  String? date;

  History({this.orderId, this.amount, this.date});

  History.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['date'] = this.date;
    return data;
  }
}
