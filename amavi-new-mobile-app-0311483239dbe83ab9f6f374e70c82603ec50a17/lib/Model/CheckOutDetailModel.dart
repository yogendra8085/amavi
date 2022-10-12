class CheckOutDetailModel {
  String? textSignIn;
  String? textSignUp;
  String? textConfirmOrder;
  String? textAgreeApp;
  String? textCommentApp;
  String? textUseCoupon;
  String? textUseVoucher;
  double? maxRedeemablePoints;
  String? textUseReward;
  String? textRedeem;
  String? textUsePin;

  String? entryReward;
  List<Breadcrumbs>? breadcrumbs;
  int? textCount;
  String? headingTitle;
  String? textShippingAddress;
  String? textPaymentAddress;
  String? textRecurringItem;
  String? textNext;
  String? textNextChoice;
  String? columnImage;
  String? columnName;
  String? columnModel;
  String? columnQuantity;
  String? columnPrice;
  String? columnTotal;
  String? buttonUpdate;
  String? buttonRemove;
  String? buttonShopping;
  String? buttonCheckout;
  String? errorWarning;
  String? attention;
  String? success;
  String? action;
  String? weight;
  List<Products>? products;
  List<Vouchers>? vouchers;
  List<Totals>? totals;
  List<Modules>? modules;
  List<Addresses>? addresses;
  PaymentMethods? paymentMethods;
  Cod? paymentMethod;
  //paymentMethod;
  String? textAgree;
  String? agreeLink;
  String? agreeTitle;

  CheckOutDetailModel(
      {this.textSignIn,
      this.textSignUp,
      this.textConfirmOrder,
      this.textAgreeApp,
      this.textCommentApp,
      this.textUseCoupon,
      this.textUseVoucher,
      this.maxRedeemablePoints,
      this.textUseReward,
      this.textRedeem,
      this.textUsePin,
      this.entryReward,
      this.breadcrumbs,
      this.textCount,
      this.headingTitle,
      this.textShippingAddress,
      this.textPaymentAddress,
      this.textRecurringItem,
      this.textNext,
      this.textNextChoice,
      this.columnImage,
      this.columnName,
      this.columnModel,
      this.columnQuantity,
      this.columnPrice,
      this.columnTotal,
      this.buttonUpdate,
      this.buttonRemove,
      this.buttonShopping,
      this.buttonCheckout,
      this.errorWarning,
      this.attention,
      this.success,
      this.action,
      this.weight,
      this.products,
      this.vouchers,
      this.totals,
      this.modules,
      this.addresses,
      this.paymentMethods,
      this.paymentMethod,
      this.textAgree,
      this.agreeLink,
      this.agreeTitle});

  CheckOutDetailModel.fromJson(Map<String, dynamic> json) {
    textAgreeApp = json['text_agree_app'];
    textCommentApp = json['text_comment_app'];
    textUseCoupon = json['text_use_coupon'];
    textUseVoucher = json['text_use_voucher'];
    maxRedeemablePoints = json['max_redeemable_points'];
    textUseReward = json['text_use_reward'];
    textRedeem = json['text_redeem'];
    textUsePin = json['text_use_pin'];
    entryReward = json['entry_reward'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    textCount = json['text_count'];
    headingTitle = json['heading_title'];
    textShippingAddress = json['text_shipping_address'];
    textPaymentAddress = json['text_payment_address'];
    textRecurringItem = json['text_recurring_item'];
    textNext = json['text_next'];
    textNextChoice = json['text_next_choice'];
    columnImage = json['column_image'];
    columnName = json['column_name'];
    columnModel = json['column_model'];
    columnQuantity = json['column_quantity'];
    columnPrice = json['column_price'];
    columnTotal = json['column_total'];
    buttonUpdate = json['button_update'];
    buttonRemove = json['button_remove'];
    buttonShopping = json['button_shopping'];
    buttonCheckout = json['button_checkout'];
    errorWarning = json['error_warning'];
    attention = json['attention'];
    success = json['success'];
    action = json['action'];
    weight = json['weight'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers?.add(new Vouchers.fromJson(v));
      });
    }

    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals?.add(new Totals.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules?.add(new Modules.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses?.add(new Addresses.fromJson(v));
      });
    }
    paymentMethods = json['payment_methods'] != null
        ? new PaymentMethods.fromJson(json['payment_methods'])
        : null;
    paymentMethod = json['payment_method'] != null
        ? new Cod.fromJson(json['payment_method'])
        : null;
    textAgree = json['text_agree'];
    agreeLink = json['agree_link'];
    agreeTitle = json['agree_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text_agree_app'] = this.textAgreeApp;
    data['text_comment_app'] = this.textCommentApp;
    data['text_use_coupon'] = this.textUseCoupon;
    data['text_use_voucher'] = this.textUseVoucher;
    data['text_sign_in'] = this.textSignIn;
    data['text_sign_up'] = this.textSignUp;
    data['text_confirm_order'] = this.textConfirmOrder;
    data['max_redeemable_points'] = this.maxRedeemablePoints;
    data['text_use_reward'] = this.textUseReward;
    data['text_redeem'] = this.textRedeem;
    data['text_use_pin'] = this.textUsePin;
    data['entry_reward'] = this.entryReward;
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['text_count'] = this.textCount;
    data['heading_title'] = this.headingTitle;
    data['text_shipping_address'] = this.textShippingAddress;
    data['text_payment_address'] = this.textPaymentAddress;
    data['text_recurring_item'] = this.textRecurringItem;
    data['text_next'] = this.textNext;
    data['text_next_choice'] = this.textNextChoice;
    data['column_image'] = this.columnImage;
    data['column_name'] = this.columnName;
    data['column_model'] = this.columnModel;
    data['column_quantity'] = this.columnQuantity;
    data['column_price'] = this.columnPrice;
    data['column_total'] = this.columnTotal;
    data['button_update'] = this.buttonUpdate;
    data['button_remove'] = this.buttonRemove;
    data['button_shopping'] = this.buttonShopping;
    data['button_checkout'] = this.buttonCheckout;
    data['error_warning'] = this.errorWarning;
    data['attention'] = this.attention;
    data['success'] = this.success;
    data['action'] = this.action;
    data['weight'] = this.weight;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers?.map((v) => v.toJson()).toList();
    }

    if (this.totals != null) {
      data['totals'] = this.totals?.map((v) => v.toJson()).toList();
    }
    if (this.modules != null) {
      data['modules'] = this.modules?.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses?.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethods != null) {
      data['payment_methods'] = this.paymentMethods?.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod?.toJson();
    }
    data['text_agree'] = this.textAgree;
    data['agree_link'] = this.agreeLink;
    data['agree_title'] = this.agreeTitle;
    return data;
  }
}

class Breadcrumbs {
  String? href;
  String? text;

  Breadcrumbs({this.href, this.text});

  Breadcrumbs.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['text'] = this.text;
    return data;
  }
}

class Products {
  String? cartId;
  String? thumb;
  String? id;
  String? name;
  String? model;
  List<Null>? option;
  String? recurring;
  String? quantity;
  bool? stock;
  String? reward;
  String? price;
  String? total;
  String? href;

  Products(
      {this.cartId,
      this.thumb,
      this.id,
      this.name,
      this.model,
      this.option,
      this.recurring,
      this.quantity,
      this.stock,
      this.reward,
      this.price,
      this.total,
      this.href});

  Products.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    thumb = json['thumb'];
    id = json['id'];
    name = json['name'];
    model = json['model'];
    // if (json['option'] != null) {
    //   option = new List<Null>();
    //   json['option'].forEach((v) { option.add(new Null.fromJson(v)); });
    // }
    recurring = json['recurring'];
    quantity = json['quantity'];
    stock = json['stock'];
    reward = json['reward'];
    price = json['price'];
    total = json['total'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['thumb'] = this.thumb;
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    // if (this.option != null) {
    //   data['option'] = this.option.map((v) => v.toJson()).toList();
    // }
    data['recurring'] = this.recurring;
    data['quantity'] = this.quantity;
    data['stock'] = this.stock;
    data['reward'] = this.reward;
    data['price'] = this.price;
    data['total'] = this.total;
    data['href'] = this.href;
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

class Modules {
  String? headingTitle;
  String? textLoading;
  String? entryCoupon;
  String? buttonCoupon;
  String? coupon;
  String? entryReward;
  String? buttonReward;
  var reward;
  String? textShipping;
  String? textShippingMethod;
  String? textSelect;
  String? textNone;
  String? entryCountry;
  String? entryZone;
  String? entryPostcode;
  String? buttonQuote;
  String? buttonShipping;
  String? buttonCancel;
  String? countryId;
  List<Countries>? countries;
  String? zoneId;
  String? postcode;
  String? shippingMethod;
  String? entryVoucher;
  String? buttonVoucher;
  String? voucher;

  Modules(
      {this.headingTitle,
      this.textLoading,
      this.entryCoupon,
      this.buttonCoupon,
      this.coupon,
      this.entryReward,
      this.buttonReward,
      this.reward,
      this.textShipping,
      this.textShippingMethod,
      this.textSelect,
      this.textNone,
      this.entryCountry,
      this.entryZone,
      this.entryPostcode,
      this.buttonQuote,
      this.buttonShipping,
      this.buttonCancel,
      this.countryId,
      this.countries,
      this.zoneId,
      this.postcode,
      this.shippingMethod,
      this.entryVoucher,
      this.buttonVoucher,
      this.voucher});

  Modules.fromJson(Map<String, dynamic> json) {
    headingTitle = json['heading_title'];
    textLoading = json['text_loading'];
    entryCoupon = json['entry_coupon'];
    buttonCoupon = json['button_coupon'];
    coupon = json['coupon'];
    entryReward = json['entry_reward'];
    buttonReward = json['button_reward'];
    reward = json['reward'];
    textShipping = json['text_shipping'];
    textShippingMethod = json['text_shipping_method'];
    textSelect = json['text_select'];
    textNone = json['text_none'];
    entryCountry = json['entry_country'];
    entryZone = json['entry_zone'];
    entryPostcode = json['entry_postcode'];
    buttonQuote = json['button_quote'];
    buttonShipping = json['button_shipping'];
    buttonCancel = json['button_cancel'];
    countryId = json['country_id'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries?.add(new Countries.fromJson(v));
      });
    }
    zoneId = json['zone_id'];
    postcode = json['postcode'];
    shippingMethod = json['shipping_method'];
    entryVoucher = json['entry_voucher'];
    buttonVoucher = json['button_voucher'];
    voucher = json['voucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading_title'] = this.headingTitle;
    data['text_loading'] = this.textLoading;
    data['entry_coupon'] = this.entryCoupon;
    data['button_coupon'] = this.buttonCoupon;
    data['coupon'] = this.coupon;
    data['entry_reward'] = this.entryReward;
    data['button_reward'] = this.buttonReward;
    data['reward'] = this.reward;
    data['text_shipping'] = this.textShipping;
    data['text_shipping_method'] = this.textShippingMethod;
    data['text_select'] = this.textSelect;
    data['text_none'] = this.textNone;
    data['entry_country'] = this.entryCountry;
    data['entry_zone'] = this.entryZone;
    data['entry_postcode'] = this.entryPostcode;
    data['button_quote'] = this.buttonQuote;
    data['button_shipping'] = this.buttonShipping;
    data['button_cancel'] = this.buttonCancel;
    data['country_id'] = this.countryId;
    if (this.countries != null) {
      data['countries'] = this.countries?.map((v) => v.toJson()).toList();
    }
    data['zone_id'] = this.zoneId;
    data['postcode'] = this.postcode;
    data['shipping_method'] = this.shippingMethod;
    data['entry_voucher'] = this.entryVoucher;
    data['button_voucher'] = this.buttonVoucher;
    data['voucher'] = this.voucher;
    return data;
  }
}

class Vouchers {
  int? key;
  String? thumb;
  String? model;
  String? description;
  String? amount;
  String? totalAmount;
  int? quantity;
  String? remove;

  Vouchers(
      {this.key,
      this.thumb,
      this.model,
      this.description,
      this.amount,
      this.totalAmount,
      this.quantity,
      this.remove});

  Vouchers.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    thumb = json['thumb'];
    model = json['model'];
    description = json['description'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
    quantity = json['quantity'];
    remove = json['remove'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['thumb'] = this.thumb;
    data['model'] = this.model;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['quantity'] = this.quantity;
    data['remove'] = this.remove;
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

class Addresses {
  String? addressId;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? fax;
  String? address1;
  String? city;
  String? zone;
  String? company;
  String? countryId;
  String? country;
  String? zoneId;
  String? address;
  int? defaults;
  String? update;
  String? delete;

  Addresses(
      {this.addressId,
      this.firstname,
      this.lastname,
      this.email,
      this.telephone,
      this.fax,
      this.address1,
      this.city,
      this.company,
      this.country,
      this.countryId,
      this.zoneId,
      this.zone,
      this.address,
      this.defaults,
      this.update,
      this.delete});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    fax = json['fax'];
    address1 = json['address_1'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    countryId = json['country_id'];
    zoneId = json['zone_id'];
    zone = json['zone'];
    address = json['address'];
    defaults = json['default'];
    update = json['update'];
    delete = json['delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    data['address_1'] = this.address1;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['zone_id'] = this.zoneId;
    data['zone'] = this.zone;
    data['address'] = this.address;
    data['default'] = this.defaults;
    data['update'] = this.update;
    data['delete'] = this.delete;
    return data;
  }
}

class PaymentMethods {
  Tap? tap;
  Cod? cod;

  PaymentMethods({this.tap, this.cod});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    tap = json['tap'] != null ? new Tap.fromJson(json['tap']) : null;
    cod = json['cod'] != null ? new Cod.fromJson(json['cod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tap != null) {
      data['tap'] = this.tap?.toJson();
    }
    if (this.cod != null) {
      data['cod'] = this.cod?.toJson();
    }
    return data;
  }
}

class Cod {
  String? code;
  String? title;
  String? terms;
  String? sortOrder;

  Cod({this.code, this.title, this.terms, this.sortOrder});

  Cod.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    title = json['title'];
    terms = json['terms'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['title'] = this.title;
    data['terms'] = this.terms;
    data['sort_order'] = this.sortOrder;
    return data;
  }
}

class Tap {
  String? code;
  String? terms;
  String? title;
  var sortOrder;

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

class CheckOutDetailModels {
  String? textSignIn;
  String? textSignUp;
  String? button_apply_gift;
  String? textConfirmOrder;
  String? textAgreeApp;
  String? textCommentApp;
  String? textUseCoupon;
  String? textUseVoucher;
  var maxRedeemablePoints;
  String? textUseReward;
  String? textRedeem;
  String? textUsePin;
  String? entryReward;
  List<Breadcrumbs>? breadcrumbs;
  int? textCount;
  String? headingTitle;
  String? textShippingAddress;
  String? textPaymentAddress;
  String? textRecurringItem;
  String? textNext;
  String? textNextChoice;
  String? columnImage;
  String? columnName;
  String? columnModel;
  String? columnQuantity;
  String? columnPrice;
  String? columnTotal;
  String? buttonUpdate;
  String? buttonRemove;
  String? buttonShopping;
  String? buttonCheckout;
  String? errorWarning;
  String? attention;
  String? success;
  String? action;
  String? weight;
  List<Products>? products;
  List<Vouchers>? vouchers;
  List<Totals>? totals;
  List<Modules>? modules;
  List<Addresses>? addresses;
  Addresses? shippingAddresse;
  PaymentMethods? paymentMethods;
  Tap? paymentMethod;
  String? textAgree;
  String? agreeLink;
  String? agreeTitle;
  String? text_or;

  CheckOutDetailModels(
      {this.textSignIn,
      this.textSignUp,
      this.button_apply_gift,
      this.textConfirmOrder,
      this.textAgreeApp,
      this.textCommentApp,
      this.textUseCoupon,
      this.textUseVoucher,
      this.maxRedeemablePoints,
      this.textUseReward,
      this.textRedeem,
      this.textUsePin,
      this.entryReward,
      this.breadcrumbs,
      this.textCount,
      this.headingTitle,
      this.textShippingAddress,
      this.textPaymentAddress,
      this.textRecurringItem,
      this.textNext,
      this.textNextChoice,
      this.columnImage,
      this.columnName,
      this.columnModel,
      this.columnQuantity,
      this.columnPrice,
      this.columnTotal,
      this.buttonUpdate,
      this.buttonRemove,
      this.buttonShopping,
      this.buttonCheckout,
      this.errorWarning,
      this.attention,
      this.success,
      this.action,
      this.weight,
      this.products,
      this.vouchers,
      this.totals,
      this.modules,
      this.addresses,
      this.shippingAddresse,
      this.paymentMethods,
      this.paymentMethod,
      this.textAgree,
      this.agreeLink,
      this.agreeTitle,
      this.text_or});

  CheckOutDetailModels.fromJson(Map<String, dynamic> json) {
    print('CheckOutDetailModels');
    print(json);
    textSignIn = json['text_sign_in'];
    textSignUp = json['text_sign_up'];
    button_apply_gift = json['button_apply_gift'];
    textConfirmOrder = json['text_confirm_order'];
    textAgreeApp = json['text_agree_app'];
    textCommentApp = json['text_comment_app'];
    textUseCoupon = json['text_use_coupon'];
    textUseVoucher = json['text_use_voucher'];
    maxRedeemablePoints = json['max_redeemable_points'];
    textUseReward = json['text_use_reward'];
    textRedeem = json['text_redeem'];
    textUsePin = json['text_use_pin'];
    entryReward = json['entry_reward'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    textCount = json['text_count'];
    headingTitle = json['heading_title'];
    textShippingAddress = json['text_shipping_address'];
    textPaymentAddress = json['text_payment_address'];
    textRecurringItem = json['text_recurring_item'];
    textNext = json['text_next'];
    textNextChoice = json['text_next_choice'];
    columnImage = json['column_image'];
    columnName = json['column_name'];
    columnModel = json['column_model'];
    columnQuantity = json['column_quantity'];
    columnPrice = json['column_price'];
    columnTotal = json['column_total'];
    buttonUpdate = json['button_update'];
    buttonRemove = json['button_remove'];
    buttonShopping = json['button_shopping'];
    buttonCheckout = json['button_checkout'];
    errorWarning = json['error_warning'];
    attention = json['attention'];
    success = json['success'];
    action = json['action'];
    weight = json['weight'];
    text_or = json['text_or'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['vouchers'] != null) {
      vouchers = <Vouchers>[];
      json['vouchers'].forEach((v) {
        vouchers?.add(new Vouchers.fromJson(v));
      });
    }
    if (json['totals'] != null) {
      totals = <Totals>[];
      json['totals'].forEach((v) {
        totals?.add(new Totals.fromJson(v));
      });
    }
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules?.add(new Modules.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses?.add(new Addresses.fromJson(v));
      });
    }
    paymentMethods = json['payment_methods'] != null
        ? new PaymentMethods.fromJson(json['payment_methods'])
        : null;
    shippingAddresse = json['shipping_address'] != null
        ? new Addresses.fromJson(json['shipping_address'])
        : null;
    paymentMethod = json['payment_method'] != null
        ? new Tap.fromJson(json['payment_method'])
        : null;
    textAgree = json['text_agree'];
    agreeLink = json['agree_link'];
    agreeTitle = json['agree_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text_sign_in'] = this.textSignIn;
    data['text_sign_up'] = this.textSignUp;
    data['button_apply_gift'] = this.button_apply_gift;
    data['text_confirm_order'] = this.textConfirmOrder;
    data['text_agree_app'] = this.textAgreeApp;
    data['text_comment_app'] = this.textCommentApp;
    data['text_use_coupon'] = this.textUseCoupon;
    data['text_use_voucher'] = this.textUseVoucher;
    data['max_redeemable_points'] = this.maxRedeemablePoints;
    data['text_use_reward'] = this.textUseReward;
    data['text_redeem'] = this.textRedeem;
    data['text_use_pin'] = this.textUsePin;
    data['entry_reward'] = this.entryReward;
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['text_count'] = this.textCount;
    data['heading_title'] = this.headingTitle;
    data['text_shipping_address'] = this.textShippingAddress;
    data['text_payment_address'] = this.textPaymentAddress;
    data['text_recurring_item'] = this.textRecurringItem;
    data['text_next'] = this.textNext;
    data['text_next_choice'] = this.textNextChoice;
    data['column_image'] = this.columnImage;
    data['column_name'] = this.columnName;
    data['column_model'] = this.columnModel;
    data['column_quantity'] = this.columnQuantity;
    data['column_price'] = this.columnPrice;
    data['column_total'] = this.columnTotal;
    data['button_update'] = this.buttonUpdate;
    data['button_remove'] = this.buttonRemove;
    data['button_shopping'] = this.buttonShopping;
    data['button_checkout'] = this.buttonCheckout;
    data['error_warning'] = this.errorWarning;
    data['attention'] = this.attention;
    data['success'] = this.success;
    data['action'] = this.action;
    data['weight'] = this.weight;
    data['text_or'] = this.text_or;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers?.map((v) => v.toJson()).toList();
    }
    if (this.totals != null) {
      data['totals'] = this.totals?.map((v) => v.toJson()).toList();
    }
    if (this.modules != null) {
      data['modules'] = this.modules?.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses?.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethods != null) {
      data['payment_methods'] = this.paymentMethods?.toJson();
    }
    if (this.shippingAddresse != null) {
      data['shipping_address'] = this.shippingAddresse?.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod?.toJson();
    }
    data['text_agree'] = this.textAgree;
    data['agree_link'] = this.agreeLink;
    data['agree_title'] = this.agreeTitle;
    return data;
  }
}
