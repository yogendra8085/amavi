class AccountListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textAddressBook;
  String? textEmpty;
  String? buttonNewAddress;
  String? buttonEdit;
  String? buttonDelete;
  String? buttonBack;
  String? errorWarning;
  String? success;
  List<Addresses>? addresses;
  String? add;
  String? back;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;

  AccountListModel(
      {required this.breadcrumbs,
      required this.headingTitle,
      required this.textAddressBook,
      required this.textEmpty,
      required this.buttonNewAddress,
      required this.buttonEdit,
      required this.buttonDelete,
      required this.buttonBack,
      required this.errorWarning,
      required this.success,
      required this.addresses,
      required this.add,
      required this.back,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.telephone});

  AccountListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textAddressBook = json['text_address_book'];
    textEmpty = json['text_empty'];
    buttonNewAddress = json['button_new_address'];
    buttonEdit = json['button_edit'];
    buttonDelete = json['button_delete'];
    buttonBack = json['button_back'];
    errorWarning = json['error_warning'];
    success = json['success'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses?.add(new Addresses.fromJson(v));
      });
    }
    add = json['add'];
    back = json['back'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_address_book'] = this.textAddressBook;
    data['text_empty'] = this.textEmpty;
    data['button_new_address'] = this.buttonNewAddress;
    data['button_edit'] = this.buttonEdit;
    data['button_delete'] = this.buttonDelete;
    data['button_back'] = this.buttonBack;
    data['error_warning'] = this.errorWarning;
    data['success'] = this.success;
    if (this.addresses != null) {
      data['addresses'] = this.addresses?.map((v) => v.toJson()).toList();
    }
    data['add'] = this.add;
    data['back'] = this.back;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
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

class Addresses {
  String? addressId;
  String? address;
  int? defaults;
  String? update;
  String? delete;

  Addresses(
      {required this.addressId,
      required this.address,
      required this.defaults,
      required this.update,
      required this.delete});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    address = json['address'];
    defaults = json['default'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['address'] = this.address;
    data['default'] = this.defaults;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}
