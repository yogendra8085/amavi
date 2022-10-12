class AddToWishListModel {
  var success;
  String? successMsg;
  String? total;

  AddToWishListModel({this.success, this.successMsg, this.total});

  AddToWishListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    successMsg = json['success-msg'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['success-msg'] = this.successMsg;
    data['total'] = this.total;
    return data;
  }
}
