class RegistrationModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  bool? loggedIn;
  String? textMessage;
  String? buttonContinue;
  String? continues;
  String? token;
  String? errorMessage;

  RegistrationModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.loggedIn,
      this.textMessage,
      this.buttonContinue,
      this.continues,
      this.token,
      this.errorMessage});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    print("jigar the json model inside we have is " + json.toString());
    // if (json['breadcrumbs'] != null) {
// breadcrumbs = new List<Breadcrumbs>();
// json['breadcrumbs'].forEach((v) { breadcrumbs.add(new Breadcrumbs.fromJson(v)); });
// }
    headingTitle = json['heading_title'];
    loggedIn = json['logged_in'];
    textMessage = json['text_message'];
    buttonContinue = json['button_continue'];
    continues = json['continue'];
    token = json['token'];
    errorMessage = json['error_warning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['logged_in'] = this.loggedIn;
    data['text_message'] = this.textMessage;
    data['button_continue'] = this.buttonContinue;
    data['continue'] = this.continues;
    data['token'] = this.token;
    data['error_warning'] = this.errorMessage;
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
