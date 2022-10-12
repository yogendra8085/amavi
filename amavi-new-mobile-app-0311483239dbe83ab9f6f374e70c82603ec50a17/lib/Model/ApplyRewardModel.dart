class ApplyRewardModel {
  bool? success;
  PaymentMethods? paymentMethods;
  Tap? paymentMethod;
  List<Totals>? totals;

  ApplyRewardModel(
      {this.success, this.paymentMethods, this.paymentMethod, this.totals});

  ApplyRewardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    paymentMethods = json['payment_methods'] != null
        ? new PaymentMethods.fromJson(json['payment_methods'])
        : null;
    paymentMethod = json['payment_method'] != null
        ? new Tap.fromJson(json['payment_method'])
        : null;
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals?.add(new Totals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.paymentMethods != null) {
      data['payment_methods'] = this.paymentMethods?.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod?.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  Tap? tap;

  PaymentMethods({this.tap});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    tap = json['tap'] != null ? new Tap.fromJson(json['tap']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tap != null) {
      data['tap'] = this.tap?.toJson();
    }
    return data;
  }
}

class Tap {
  String? code;
  String? terms;
  String? title;
  String? sortOrder;

  Tap({this.code, this.terms, this.title, this.sortOrder});

  Tap.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    terms = json['terms'];
    title = json['title'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['terms'] = this.terms;
    data['title'] = this.title;
    data['sort_order'] = this.sortOrder;
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
