class RewardHistoryListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? columnOrderId;
  String? columnPointsGained;
  String? columnPointsRedeemed;
  String? columnDateAdded;
  String? columnDescription;
  String? columnPoints;
  String? textTotal;
  String? textEmpty;
  String? buttonContinue;
  List<Rewards>? rewards;
  String? pagination;
  String? results;
  int? total;
  String? continues;

  RewardHistoryListModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.columnOrderId,
      this.columnPointsGained,
      this.columnPointsRedeemed,
      this.columnDateAdded,
      this.columnDescription,
      this.columnPoints,
      this.textTotal,
      this.textEmpty,
      this.buttonContinue,
      this.rewards,
      this.pagination,
      this.results,
      this.total,
      this.continues});

  RewardHistoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    columnOrderId = json['column_order_id'];
    columnPointsGained = json['column_points_gained'];
    columnPointsRedeemed = json['column_points_redeemed'];
    columnDateAdded = json['column_date_added'];
    columnDescription = json['column_description'];
    columnPoints = json['column_points'];
    textTotal = json['text_total'];
    textEmpty = json['text_empty'];
    buttonContinue = json['button_continue'];
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards?.add(new Rewards.fromJson(v));
      });
    }
    pagination = json['pagination'];
    results = json['results'];
    total = json['total'];
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['column_order_id'] = this.columnOrderId;
    data['column_points_gained'] = this.columnPointsGained;
    data['column_points_redeemed'] = this.columnPointsRedeemed;
    data['column_date_added'] = this.columnDateAdded;
    data['column_description'] = this.columnDescription;
    data['column_points'] = this.columnPoints;
    data['text_total'] = this.textTotal;
    data['text_empty'] = this.textEmpty;
    data['button_continue'] = this.buttonContinue;
    if (this.rewards != null) {
      data['rewards'] = this.rewards?.map((v) => v.toJson()).toList();
    }
    data['pagination'] = this.pagination;
    data['results'] = this.results;
    data['total'] = this.total;
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

class Rewards {
  String? orderId;
  String? orderAmt;
  var used;
  var received;
  String? description;
  String? dateAdded;
  String? href;

  Rewards(
      {this.orderId,
      this.orderAmt,
      this.used,
      this.received,
      this.description,
      this.dateAdded,
      this.href});

  Rewards.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderAmt = json['order_amt'];
    used = json['used'];
    received = json['received'];
    description = json['description'];
    dateAdded = json['date_added'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_amt'] = this.orderAmt;
    data['used'] = this.used;
    data['received'] = this.received;
    data['description'] = this.description;
    data['date_added'] = this.dateAdded;
    data['href'] = this.href;
    return data;
  }
}
