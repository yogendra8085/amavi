class CheckoutSuccessModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textMessage;
  String? text;
  String? buttonContinue;
  String? continues;
  bool? status;

  CheckoutSuccessModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textMessage,
      this.text,
      this.buttonContinue,
      this.continues,
      this.status});

  CheckoutSuccessModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textMessage = json['text_message'];
    text = json['text'];
    buttonContinue = json['button_continue'];
    continues = json['continue'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_message'] = this.textMessage;
    data['text'] = this.text;
    data['button_continue'] = this.buttonContinue;
    data['continue'] = this.continues;
    data['status'] = this.status;
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
