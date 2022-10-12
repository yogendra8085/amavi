class ChangePasswordModel {
  List<Breadcrumbs>? breadcrumbs;
  String? success;
  bool? status;
  String? headingTitle;
  bool? loggedIn;
  String? token;
  Customerinfo? customerinfo;
  String? textMyAccount;
  String? textMyOrders;
  String? textMyNewsletter;
  String? textEdit;
  String? textPassword;
  String? textAddress;
  String? textCreditCard;
  String? textWishlist;
  String? textOrder;
  String? textDownload;
  String? textReward;
  String? textReturn;
  String? textTransaction;
  String? textNewsletter;
  String? textRecurring;
  String? edit;
  String? password;
  String? address;
  List<Null>? creditCards;
  String? wishlist;
  String? order;
  String? download;
  String? reward;
  String? returns;
  String? transaction;
  String? newsletter;
  String? recurring;
  ColumnRight? columnRight;

  ChangePasswordModel(
      {this.breadcrumbs,
      this.success,
      this.status,
      this.headingTitle,
      this.loggedIn,
      this.token,
      this.customerinfo,
      this.textMyAccount,
      this.textMyOrders,
      this.textMyNewsletter,
      this.textEdit,
      this.textPassword,
      this.textAddress,
      this.textCreditCard,
      this.textWishlist,
      this.textOrder,
      this.textDownload,
      this.textReward,
      this.textReturn,
      this.textTransaction,
      this.textNewsletter,
      this.textRecurring,
      this.edit,
      this.password,
      this.address,
      this.creditCards,
      this.wishlist,
      this.order,
      this.download,
      this.reward,
      this.returns,
      this.transaction,
      this.newsletter,
      this.recurring,
      this.columnRight});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
    headingTitle = json['heading_title'];
    loggedIn = json['logged_in'];
    token = json['token'];
    customerinfo = json['customerinfo'] != null
        ? new Customerinfo.fromJson(json['customerinfo'])
        : null;
    textMyAccount = json['text_my_account'];
    textMyOrders = json['text_my_orders'];
    textMyNewsletter = json['text_my_newsletter'];
    textEdit = json['text_edit'];
    textPassword = json['text_password'];
    textAddress = json['text_address'];
    textCreditCard = json['text_credit_card'];
    textWishlist = json['text_wishlist'];
    textOrder = json['text_order'];
    textDownload = json['text_download'];
    textReward = json['text_reward'];
    textReturn = json['text_return'];
    textTransaction = json['text_transaction'];
    textNewsletter = json['text_newsletter'];
    textRecurring = json['text_recurring'];
    edit = json['edit'];
    password = json['password'];
    address = json['address'];
    if (json['credit_cards'] != null) {
      creditCards = <Null>[];
//json['credit_cards'].forEach((v) { creditCards.add(new Null.fromJson(v)); });
    }
    wishlist = json['wishlist'];
    order = json['order'];
    download = json['download'];
    reward = json['reward'];
    returns = json['return'];
    transaction = json['transaction'];
    newsletter = json['newsletter'];
    recurring = json['recurring'];
    columnRight = json['column_right'] != null
        ? new ColumnRight.fromJson(json['column_right'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    data['heading_title'] = this.headingTitle;
    data['logged_in'] = this.loggedIn;
    data['token'] = this.token;
    if (this.customerinfo != null) {
      data['customerinfo'] = this.customerinfo?.toJson();
    }
    data['text_my_account'] = this.textMyAccount;
    data['text_my_orders'] = this.textMyOrders;
    data['text_my_newsletter'] = this.textMyNewsletter;
    data['text_edit'] = this.textEdit;
    data['text_password'] = this.textPassword;
    data['text_address'] = this.textAddress;
    data['text_credit_card'] = this.textCreditCard;
    data['text_wishlist'] = this.textWishlist;
    data['text_order'] = this.textOrder;
    data['text_download'] = this.textDownload;
    data['text_reward'] = this.textReward;
    data['text_return'] = this.textReturn;
    data['text_transaction'] = this.textTransaction;
    data['text_newsletter'] = this.textNewsletter;
    data['text_recurring'] = this.textRecurring;
    data['edit'] = this.edit;
    data['password'] = this.password;
    data['address'] = this.address;
    if (this.creditCards != null) {
      // data['credit_cards'] = this.creditCards.map((v) => v.toJson()).toList();
    }
    data['wishlist'] = this.wishlist;
    data['order'] = this.order;
    data['download'] = this.download;
    data['reward'] = this.reward;
    data['return'] = this.returns;
    data['transaction'] = this.transaction;
    data['newsletter'] = this.newsletter;
    data['recurring'] = this.recurring;
    if (this.columnRight != null) {
      data['column_right'] = this.columnRight?.toJson();
    }
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

class Customerinfo {
  String? customerId;
  String? firstname;
  String? lastname;
  String? email;

  Customerinfo({this.customerId, this.firstname, this.lastname, this.email});

  Customerinfo.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    return data;
  }
}

class ColumnRight {
  List<Null>? modules;

  ColumnRight({this.modules});

  ColumnRight.fromJson(Map<String, dynamic> json) {
    if (json['modules'] != null) {
      modules = <Null>[];
//      json['modules'].forEach((v) { modules.add(new Null.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.modules != null) {
      //    data['modules'] = this.modules.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
