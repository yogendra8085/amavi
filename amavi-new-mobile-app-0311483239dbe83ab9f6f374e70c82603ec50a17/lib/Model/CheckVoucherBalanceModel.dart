class CheckVoucherBalanceModel {
  Voucher? voucher;

  CheckVoucherBalanceModel({this.voucher});

  CheckVoucherBalanceModel.fromJson(Map<String, dynamic> json) {
    voucher =
        json['voucher'] != null ? new Voucher.fromJson(json['voucher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.voucher != null) {
      data['voucher'] = this.voucher?.toJson();
    }
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

class Voucher {
  List<History>? history;
  String? total;
  String? used;
  String? remaining;

  Voucher({this.history, this.total, this.used, this.remaining});

  Voucher.fromJson(Map<String, dynamic> json) {
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history?.add(new History.fromJson(v));
      });
    }
    total = json['total'];
    used = json['used'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history != null) {
//      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['used'] = this.used;
    data['remaining'] = this.remaining;
    return data;
  }
}
