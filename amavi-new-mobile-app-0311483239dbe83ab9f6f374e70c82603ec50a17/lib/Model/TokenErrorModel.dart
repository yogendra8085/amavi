class TokenErrorModel {
  String? tokenError;

  TokenErrorModel({this.tokenError});

  TokenErrorModel.fromJson(Map<String, dynamic> json) {
    tokenError = json['token_error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_error'] = this.tokenError;
    return data;
  }
}
