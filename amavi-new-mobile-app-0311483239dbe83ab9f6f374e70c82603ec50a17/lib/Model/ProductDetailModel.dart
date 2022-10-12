class ProductDetailModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textSelect;
  String? textDetail;
  String? textManufacturer;
  String? textModel;
  String? textReward;
  String? textPoints;
  String? textStock;
  String? textDiscount;
  String? textTax;
  String? textOption;
  String? textMinimum;
  String? textWrite;
  String? textLogin;
  String? textNote;
  String? textTags;
  String? textRelated;
  String? textPaymentRecurring;
  String? textLoading;
  String? entryQty;
  String? entryName;
  String? entryReview;
  String? entryRating;
  String? entryGood;
  String? entryBad;
  String? availableQuantity;
  String? buttonCart;
  String? buttonNotify;
  String? buttonWishlist;
  String? buttonCompare;
  String? buttonUpload;
  String? buttonContinue;
  String? tabDescription;
  String? tabAttribute;
  String? tabReview;
  String? tabUse;
  String? tabIngredients;
  int? productId;
  String? manufacturer;
  String? manufacturerImg;
  String? manufacturerHref;
  var brandDisc;
  String? manufacturers;
  String? model;
  String? reward;
  String? points;
  String? description;
  String? useing;
  String? ingredients;
  String? stock;
  String? popup;
  String? thumb;
  String? quantity;
  List<Images>? images;
  String? price;
  var special;
  String? tax;
  List<Null>? discounts;
  List<Options>? options;
  String? minimum;
  String? reviewStatus;
  bool? reviewGuest;
  String? customerName;
  String? reviews;
  int? rating;
  String? captcha;
  String? dealzadaBadges;
  String? share;
  List<Null>? attributeGroups;
  List<Null>? products;
  List<Null>? tags;
  List<Null>? recurrings;

  ProductDetailModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textSelect,
      this.textDetail,
      this.textManufacturer,
      this.textModel,
      this.textReward,
      this.textPoints,
      this.textStock,
      this.textDiscount,
      this.textTax,
      this.textOption,
      this.textMinimum,
      this.textWrite,
      this.textLogin,
      this.textNote,
      this.textTags,
      this.textRelated,
      this.textPaymentRecurring,
      this.textLoading,
      this.entryQty,
      this.entryName,
      this.entryReview,
      this.entryRating,
      this.entryGood,
      this.entryBad,
      this.availableQuantity,
      this.buttonCart,
      this.buttonNotify,
      this.buttonWishlist,
      this.buttonCompare,
      this.buttonUpload,
      this.buttonContinue,
      this.tabDescription,
      this.tabAttribute,
      this.tabReview,
      this.tabUse,
      this.tabIngredients,
      this.productId,
      this.manufacturer,
      this.manufacturerImg,
      this.manufacturerHref,
      this.brandDisc,
      this.manufacturers,
      this.model,
      this.reward,
      this.points,
      this.description,
      this.useing,
      this.ingredients,
      this.stock,
      this.popup,
      this.thumb,
      this.quantity,
      this.images,
      this.price,
      this.special,
      this.tax,
      this.discounts,
      this.options = const [],
      this.minimum,
      this.reviewStatus,
      this.reviewGuest,
      this.customerName,
      this.reviews,
      this.rating,
      this.captcha,
      this.share,
      this.attributeGroups,
      this.products,
      this.dealzadaBadges,
      this.tags,
      this.recurrings});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textSelect = json['text_select'];
    textDetail = json['text_detail'];
    textManufacturer = json['text_manufacturer'];
    textModel = json['text_model'];
    textReward = json['text_reward'];
    textPoints = json['text_points'];
    textStock = json['text_stock'];
    textDiscount = json['text_discount'];
    textTax = json['text_tax'];
    textOption = json['text_option'];
    textMinimum = json['text_minimum'];
    textWrite = json['text_write'];
    textLogin = json['text_login'];
    textNote = json['text_note'];
    textTags = json['text_tags'];
    textRelated = json['text_related'];
    textPaymentRecurring = json['text_payment_recurring'];
    textLoading = json['text_loading'];
    entryQty = json['entry_qty'];
    entryName = json['entry_name'];
    entryReview = json['entry_review'];
    entryRating = json['entry_rating'];
    entryGood = json['entry_good'];
    entryBad = json['entry_bad'];
    availableQuantity = json['available_quantity'];
    buttonCart = json['button_cart'];
    buttonNotify = json['text_notify'];
    buttonWishlist = json['button_wishlist'];
    buttonCompare = json['button_compare'];
    buttonUpload = json['button_upload'];
    buttonContinue = json['button_continue'];
    tabDescription = json['tab_description'];
    tabAttribute = json['tab_attribute'];
    tabReview = json['tab_review'];
    tabUse = json['tab_use'];
    tabIngredients = json['tab_ingredients'];
    productId = json['product_id'];
    manufacturer = json['manufacturer'];
    manufacturerImg = json['manufacturer_img'];
    manufacturerHref = json['manufacturer_href'];
    brandDisc = json['brand_disc'];
    manufacturers = json['manufacturers'];
    model = json['model'];
    reward = json['reward'];
    points = json['points'];
    description = json['description'];
    useing = json['useing'];
    ingredients = json['ingredients'];
    stock = json['stock'];
    popup = json['popup'];
    thumb = json['thumb'];
    quantity = json['quantity'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images?.add(new Images.fromJson(v));
      });
    }
    price = json['price'];
    special = json['special'];
    tax = json['tax'];
    if (json['discounts'] != null) {
      discounts = <Null>[];
      // json['discounts'].forEach((v) {
      //   discounts.add(new Null.fromJson(v));
      // });
    }
    if (json['options'] != null) {
      print(json['options']);
      options = [];
      json['options'].forEach((v) {
        print(v);
        options?.add(new Options.fromJson(v));
      });
    }
    minimum = json['minimum'];
    reviewStatus = json['review_status'];
    reviewGuest = json['review_guest'];
    customerName = json['customer_name'];
    reviews = json['reviews'];
    rating = json['rating'];
    captcha = json['captcha'];
    dealzadaBadges = json['dealzada_badges'];
    share = json['share'];
    if (json['attribute_groups'] != null) {
      attributeGroups = <Null>[];
      // json['attribute_groups'].forEach((v) {
      //   attributeGroups.add(new Null.fromJson(v));
      // });
    }
    if (json['products'] != null) {
      products = <Null>[];
      // json['products'].forEach((v) {
      //   products.add(new Null.fromJson(v));
      // });
    }
    if (json['tags'] != null) {
      tags = <Null>[];
      // json['tags'].forEach((v) {
      //   tags.add(new Null.fromJson(v));
      // });
    }
    if (json['recurrings'] != null) {
      recurrings = <Null>[];
      // json['recurrings'].forEach((v) {
      //   recurrings.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_select'] = this.textSelect;
    data['text_detail'] = this.textDetail;
    data['text_manufacturer'] = this.textManufacturer;
    data['text_model'] = this.textModel;
    data['text_reward'] = this.textReward;
    data['text_points'] = this.textPoints;
    data['text_stock'] = this.textStock;
    data['text_discount'] = this.textDiscount;
    data['text_tax'] = this.textTax;
    data['text_option'] = this.textOption;
    data['text_minimum'] = this.textMinimum;
    data['text_write'] = this.textWrite;
    data['text_login'] = this.textLogin;
    data['text_note'] = this.textNote;
    data['text_tags'] = this.textTags;
    data['text_related'] = this.textRelated;
    data['text_payment_recurring'] = this.textPaymentRecurring;
    data['text_loading'] = this.textLoading;
    data['entry_qty'] = this.entryQty;
    data['entry_name'] = this.entryName;
    data['entry_review'] = this.entryReview;
    data['entry_rating'] = this.entryRating;
    data['entry_good'] = this.entryGood;
    data['entry_bad'] = this.entryBad;
    data['available_quantity'] = this.availableQuantity;
    data['button_cart'] = this.buttonCart;
    data['text_notify'] = this.buttonNotify;
    data['button_wishlist'] = this.buttonWishlist;
    data['button_compare'] = this.buttonCompare;
    data['button_upload'] = this.buttonUpload;
    data['button_continue'] = this.buttonContinue;
    data['tab_description'] = this.tabDescription;
    data['tab_attribute'] = this.tabAttribute;
    data['tab_review'] = this.tabReview;
    data['tab_use'] = this.tabUse;
    data['tab_ingredients'] = this.tabIngredients;
    data['product_id'] = this.productId;
    data['manufacturer'] = this.manufacturer;
    data['manufacturer_img'] = this.manufacturerImg;
    data['manufacturer_href'] = this.manufacturerHref;
    data['brand_disc'] = this.brandDisc;
    data['manufacturers'] = this.manufacturers;
    data['model'] = this.model;
    data['reward'] = this.reward;
    data['points'] = this.points;
    data['description'] = this.description;
    data['useing'] = this.useing;
    data['ingredients'] = this.ingredients;
    data['stock'] = this.stock;
    data['popup'] = this.popup;
    data['thumb'] = this.thumb;
    data['quantity'] = this.quantity;
    data['dealzada_badges'] = this.dealzadaBadges;
    if (this.images != null) {
      data['images'] = this.images?.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['special'] = this.special;
    data['tax'] = this.tax;
    if (this.discounts != null) {
      //    data['discounts'] = this.discounts.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      // data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['minimum'] = this.minimum;
    data['review_status'] = this.reviewStatus;
    data['review_guest'] = this.reviewGuest;
    data['customer_name'] = this.customerName;
    data['reviews'] = this.reviews;
    data['rating'] = this.rating;
    data['captcha'] = this.captcha;
    data['share'] = this.share;
    if (this.attributeGroups != null) {
//      data['attribute_groups'] =
      //   this.attributeGroups.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      // data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      // data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.recurrings != null) {
      //  data['recurrings'] = this.recurrings.map((v) => v.toJson()).toList();
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

class Images {
  String? popup;
  String? thumb;

  Images({this.popup, this.thumb});

  Images.fromJson(Map<String, dynamic> json) {
    popup = json['popup'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popup'] = this.popup;
    data['thumb'] = this.thumb;
    return data;
  }
}

class Options {
  String? productOptionId;
  List<ProductOptionValue>? productOptionValue;
  String? optionId;
  String? name;
  String? type;
  String? value;
  String? required;
  ProductOptionValue? selectedProductOption;

  Options(
      {this.productOptionId,
      this.productOptionValue,
      this.optionId,
      this.name,
      this.type,
      this.value,
      this.required,
      this.selectedProductOption});

  Options.fromJson(Map<String, dynamic> json) {
    productOptionId = json['product_option_id'];
    if (json['product_option_value'] != null) {
      productOptionValue = <ProductOptionValue>[];
      json['product_option_value'].forEach((v) {
        productOptionValue?.add(new ProductOptionValue.fromJson(v));
      });
    }
    optionId = json['option_id'];
    name = json['name'];
    type = json['type'];
    value = json['value'];
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_option_id'] = this.productOptionId;
    if (this.productOptionValue != null) {
      data['product_option_value'] =
          this.productOptionValue?.map((v) => v.toJson()).toList();
    }
    data['option_id'] = this.optionId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    data['required'] = this.required;
    return data;
  }
}

class ProductOptionValue {
  String? productOptionValueId;
  String? optionValueId;
  String? name;
  Null? image;
  bool? price;
  String? quantity;
  String? pricePrefix;

  ProductOptionValue(
      {this.productOptionValueId,
      this.optionValueId,
      this.name,
      this.image,
      this.price,
      this.quantity,
      this.pricePrefix});

  ProductOptionValue.fromJson(Map<String, dynamic> json) {
    productOptionValueId = json['product_option_value_id'];
    optionValueId = json['option_value_id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    pricePrefix = json['price_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_option_value_id'] = this.productOptionValueId;
    data['option_value_id'] = this.optionValueId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['price_prefix'] = this.pricePrefix;
    return data;
  }
}
