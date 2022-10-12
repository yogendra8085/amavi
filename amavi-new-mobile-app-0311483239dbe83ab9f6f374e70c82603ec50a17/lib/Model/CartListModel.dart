class CartListModel {
  List<Breadcrumbs>? breadcrumbs;
  int? textCount;
  int? wishlistCount;
  String? headingTitle;
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
  String? continues;
  String? checkout;
  List<Modules>? modules;

  CartListModel(
      {this.breadcrumbs,
      this.textCount = 0,
      this.wishlistCount,
      this.headingTitle,
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
      this.continues,
      this.checkout,
      this.modules});

  CartListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    textCount = json['text_count'];
    wishlistCount = json['wishlist_count'];
    headingTitle = json['heading_title'];
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
    continues = json['continue'];
    checkout = json['checkout'];
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules?.add(new Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['text_count'] = this.textCount;
    data['wishlist_count'] = this.wishlistCount;
    data['heading_title'] = this.headingTitle;
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
    data['continue'] = this.continues;
    data['checkout'] = this.checkout;
    if (this.modules != null) {
      data['modules'] = this.modules?.map((v) => v.toJson()).toList();
    }
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
  List<String>? discountLabel;
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
      this.discountLabel,
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
    if (json['option'] != null) {
      option = <Null>[];
//      json['option'].forEach((v) { option.add(new Null.fromJson(v)); });
    }
    discountLabel = json['discount_label'].cast<String>();
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
    if (this.option != null) {
//      data['option'] = this.option.map((v) => v.toJson()).toList();
    }
    data['recurring'] = this.recurring;
    data['discount_label'] = this.discountLabel;
    data['quantity'] = this.quantity;
    data['stock'] = this.stock;
    data['reward'] = this.reward;
    data['price'] = this.price;
    data['total'] = this.total;
    data['href'] = this.href;
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
  var quantity;
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
