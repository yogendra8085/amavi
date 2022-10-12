class AddMailVoucherModel {
  List<Breadcrumbs>? breadcrumbs;
  String? voucherBalanceLink;
  String? headingTitle;
  String? headingVoucherBalance;
  String? textVoucherBalance;
  String? textDescription;
  String? textAgree;
  String? textMailRecipient;
  String? textVoucherBalanceApp;
  String? textVoucherAdd;
  String? textSelfDeliver;
  String? textDeliverRecipient;
  String? textPickAddress;
  String? textAddressBook;
  String? textSelect;
  String? entryToName;
  String? entryToEmail;
  String? entryFromName;
  String? entryFromMobile;
  String? entryFromEmail;
  String? entryTheme;
  String? entryMessage;
  String? entryAmount;
  String? entryDelivery;
  String? entryToAddress;
  String? entryMobile;
  String? entryCity;
  String? entryCountry;
  String? entryZone;
  String? helpMessage;
  String? helpAmount;
  String? buttonContinue;
  List<Addresses>? addresses;
  String? errorWarning;
  String? errorToName;
  String? errorToEmail;
  String? errorFromMobile;
  String? errorToAddress;
  String? errorMobile;
  String? errorCity;
  String? errorZone;
  String? errorFromName;
  String? errorFromEmail;
  String? errorTheme;
  String? errorAmount;
  String? action;
  String? toName;
  String? toEmail;
  String? fromMobile;
  String? voucherDelivery;
  String? toAddressClass;
  String? toAddress;
  String? mobile;
  String? city;
  String? country;
  String? zone;
  String? fromName;
  String? fromEmail;
  List<VoucherThemes>? voucherThemes;
  List<Vouchers>? vouchers;
  String? voucherThemeId;
  String? voucherId;
  String? message;
  var amount;
  List<Countries>? countries;
  var agree;

  AddMailVoucherModel(
      {this.breadcrumbs,
      this.voucherBalanceLink,
      this.headingTitle,
      this.headingVoucherBalance,
      this.textVoucherAdd,
      this.textVoucherBalanceApp,
      this.textVoucherBalance,
      this.textDescription,
      this.textAgree,
      this.textMailRecipient,
      this.textSelfDeliver,
      this.textDeliverRecipient,
      this.textPickAddress,
      this.textAddressBook,
      this.textSelect,
      this.entryToName,
      this.entryToEmail,
      this.entryFromName,
      this.entryFromMobile,
      this.entryFromEmail,
      this.entryTheme,
      this.entryMessage,
      this.entryAmount,
      this.entryDelivery,
      this.entryToAddress,
      this.entryMobile,
      this.entryCity,
      this.entryCountry,
      this.entryZone,
      this.helpMessage,
      this.helpAmount,
      this.buttonContinue,
      this.addresses,
      this.errorWarning,
      this.errorToName,
      this.errorToEmail,
      this.errorFromMobile,
      this.errorToAddress,
      this.errorMobile,
      this.errorCity,
      this.errorZone,
      this.errorFromName,
      this.errorFromEmail,
      this.errorTheme,
      this.errorAmount,
      this.action,
      this.toName,
      this.toEmail,
      this.fromMobile,
      this.voucherDelivery,
      this.toAddressClass,
      this.toAddress,
      this.mobile,
      this.city,
      this.country,
      this.zone,
      this.fromName,
      this.fromEmail,
      this.voucherThemes,
      this.vouchers,
      this.voucherThemeId,
      this.voucherId,
      this.message,
      this.amount,
      this.countries,
      this.agree});

  AddMailVoucherModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    voucherBalanceLink = json['voucher_balance_link'];
    headingTitle = json['heading_title'];
    headingVoucherBalance = json['heading_voucher_balance'];
    textVoucherAdd = json['text_voucher_add'];
    textVoucherBalanceApp = json['text_voucher_balance_app'];
    textVoucherBalance = json['text_voucher_balance'];
    textDescription = json['text_description'];
    textAgree = json['text_agree'];
    textMailRecipient = json['text_mail_recipient'];
    textSelfDeliver = json['text_self_deliver'];
    textDeliverRecipient = json['text_deliver_recipient'];
    textPickAddress = json['text_pick_address'];
    textAddressBook = json['text_address_book'];
    textSelect = json['text_select'];
    entryToName = json['entry_to_name'];
    entryToEmail = json['entry_to_email'];
    entryFromName = json['entry_from_name'];
    entryFromMobile = json['entry_from_mobile'];
    entryFromEmail = json['entry_from_email'];
    entryTheme = json['entry_theme'];
    entryMessage = json['entry_message'];
    entryAmount = json['entry_amount'];
    entryDelivery = json['entry_delivery'];
    entryToAddress = json['entry_to_address'];
    entryMobile = json['entry_mobile'];
    entryCity = json['entry_city'];
    entryCountry = json['entry_country'];
    entryZone = json['entry_zone'];
    helpMessage = json['help_message'];
    helpAmount = json['help_amount'];
    buttonContinue = json['button_continue'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses?.add(new Addresses.fromJson(v));
      });
    }
    errorWarning = json['error_warning'];
    errorToName = json['error_to_name'];
    errorToEmail = json['error_to_email'];
    errorFromMobile = json['error_from_mobile'];
    errorToAddress = json['error_to_address'];
    errorMobile = json['error_mobile'];
    errorCity = json['error_city'];
    errorZone = json['error_zone'];
    errorFromName = json['error_from_name'];
    errorFromEmail = json['error_from_email'];
    errorTheme = json['error_theme'];
    errorAmount = json['error_amount'];
    action = json['action'];
    toName = json['to_name'];
    toEmail = json['to_email'];
    fromMobile = json['from_mobile'];
    voucherDelivery = json['voucher_delivery'];
    toAddressClass = json['to_address_class'];
    toAddress = json['to_address'];
    mobile = json['mobile'];
    city = json['city'];
    country = json['country'];
    zone = json['zone'];
    fromName = json['from_name'];
    fromEmail = json['from_email'];
    if (json['voucher_themes'] != null) {
      voucherThemes = <VoucherThemes>[];
      json['voucher_themes'].forEach((v) {
        voucherThemes?.add(new VoucherThemes.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers?.add(new Vouchers.fromJson(v));
      });
    }
    voucherThemeId = json['voucher_theme_id'];
    voucherId = json['voucher_id'];
    message = json['message'];
    amount = json['amount'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries?.add(new Countries.fromJson(v));
      });
    }
    agree = json['agree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['voucher_balance_link'] = this.voucherBalanceLink;
    data['heading_title'] = this.headingTitle;
    data['heading_voucher_balance'] = this.headingVoucherBalance;
    data['text_voucher_add'] = this.textVoucherAdd;
    data['text_voucher_balance_app'] = this.textVoucherBalanceApp;
    data['text_voucher_balance'] = this.textVoucherBalance;
    data['text_description'] = this.textDescription;
    data['text_agree'] = this.textAgree;
    data['text_mail_recipient'] = this.textMailRecipient;
    data['text_self_deliver'] = this.textSelfDeliver;
    data['text_deliver_recipient'] = this.textDeliverRecipient;
    data['text_pick_address'] = this.textPickAddress;
    data['text_address_book'] = this.textAddressBook;
    data['text_select'] = this.textSelect;
    data['entry_to_name'] = this.entryToName;
    data['entry_to_email'] = this.entryToEmail;
    data['entry_from_name'] = this.entryFromName;
    data['entry_from_mobile'] = this.entryFromMobile;
    data['entry_from_email'] = this.entryFromEmail;
    data['entry_theme'] = this.entryTheme;
    data['entry_message'] = this.entryMessage;
    data['entry_amount'] = this.entryAmount;
    data['entry_delivery'] = this.entryDelivery;
    data['entry_to_address'] = this.entryToAddress;
    data['entry_mobile'] = this.entryMobile;
    data['entry_city'] = this.entryCity;
    data['entry_country'] = this.entryCountry;
    data['entry_zone'] = this.entryZone;
    data['help_message'] = this.helpMessage;
    data['help_amount'] = this.helpAmount;
    data['button_continue'] = this.buttonContinue;
    if (this.addresses != null) {
      data['addresses'] = this.addresses?.map((v) => v.toJson()).toList();
    }
    data['error_warning'] = this.errorWarning;
    data['error_to_name'] = this.errorToName;
    data['error_to_email'] = this.errorToEmail;
    data['error_from_mobile'] = this.errorFromMobile;
    data['error_to_address'] = this.errorToAddress;
    data['error_mobile'] = this.errorMobile;
    data['error_city'] = this.errorCity;
    data['error_zone'] = this.errorZone;
    data['error_from_name'] = this.errorFromName;
    data['error_from_email'] = this.errorFromEmail;
    data['error_theme'] = this.errorTheme;
    data['error_amount'] = this.errorAmount;
    data['action'] = this.action;
    data['to_name'] = this.toName;
    data['to_email'] = this.toEmail;
    data['from_mobile'] = this.fromMobile;
    data['voucher_delivery'] = this.voucherDelivery;
    data['to_address_class'] = this.toAddressClass;
    data['to_address'] = this.toAddress;
    data['mobile'] = this.mobile;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zone'] = this.zone;
    data['from_name'] = this.fromName;
    data['from_email'] = this.fromEmail;
    if (this.voucherThemes != null) {
      data['voucher_themes'] =
          this.voucherThemes?.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers?.map((v) => v.toJson()).toList();
    }
    data['voucher_theme_id'] = this.voucherThemeId;
    data['voucher_id'] = this.voucherId;
    data['message'] = this.message;
    data['amount'] = this.amount;
    if (this.countries != null) {
      data['countries'] = this.countries?.map((v) => v.toJson()).toList();
    }
    data['agree'] = this.agree;
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
  String? address;
  String? city;
  String? countryId;
  String? country;
  String? zone;
  String? zoneId;
  bool? isChecked = false;

  Addresses(
      {this.address,
      this.city,
      this.countryId,
      this.country,
      this.zone,
      this.zoneId,
      this.isChecked});

  Addresses.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    countryId = json['country_id'];
    country = json['country'];
    zone = json['zone'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['country'] = this.country;
    data['zone'] = this.zone;
    data['zone_id'] = this.zoneId;
    return data;
  }
}

class VoucherThemes {
  String? voucherThemeId;
  String? image;
  String? languageId;
  String? name;

  VoucherThemes({this.voucherThemeId, this.image, this.languageId, this.name});

  VoucherThemes.fromJson(Map<String, dynamic> json) {
    voucherThemeId = json['voucher_theme_id'];
    image = json['image'];
    languageId = json['language_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucher_theme_id'] = this.voucherThemeId;
    data['image'] = this.image;
    data['language_id'] = this.languageId;
    data['name'] = this.name;
    return data;
  }
}

class Vouchers {
  String? voucherId;
  String? model;
  String? name;
  String? amount;

  Vouchers({this.voucherId, this.model, this.name, this.amount});

  Vouchers.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucher_id'];
    model = json['model'];
    name = json['name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucher_id'] = this.voucherId;
    data['model'] = this.model;
    data['name'] = this.name;
    data['amount'] = this.amount;
    return data;
  }
}

class Countries {
  String? countryId;
  String? name;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  String? postcodeRequired;
  String? status;
  String? arName;

  Countries(
      {this.countryId,
      this.name,
      this.isoCode2,
      this.isoCode3,
      this.addressFormat,
      this.postcodeRequired,
      this.status,
      this.arName});

  Countries.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormat = json['address_format'];
    postcodeRequired = json['postcode_required'];
    status = json['status'];
    arName = json['ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['iso_code_2'] = this.isoCode2;
    data['iso_code_3'] = this.isoCode3;
    data['address_format'] = this.addressFormat;
    data['postcode_required'] = this.postcodeRequired;
    data['status'] = this.status;
    data['ar_name'] = this.arName;
    return data;
  }
}
