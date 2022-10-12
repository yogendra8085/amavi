import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier {
  String? code;
  String? textContact;
  String? textFaq;
  String? textWishlist;
  String? textProfile;
  String? textHomeApp;
  String? textProfileApp;
  String? textViewAll;
  String? textBrandsApp;
  String? textGiftSetOffer;
  String? textInstagram;
  String? textVoucher;
  String? textReward;
  String? textSettings;
  String? textLogout;
  List<Categories>? categories;
  List<Informations>? informations;
  int? textCount;
  int? wishlistCount;
  String? instagramUrl;
  List<Brands>? brands;
  FeaturedProducts? featuredProducts;
  TopSlider? topSlider;
  TopSlider? bottomSlider;

  LoginModel(
      {this.code,
      this.textContact,
      this.textFaq,
      this.textWishlist,
      this.textProfile,
      this.textHomeApp,
      this.textProfileApp,
      this.textViewAll,
      this.textBrandsApp,
      this.textGiftSetOffer,
      this.textInstagram,
      this.textVoucher,
      this.textReward,
      this.textSettings,
      this.textLogout,
      this.categories,
      this.informations,
      this.textCount,
      this.wishlistCount,
      this.instagramUrl,
      this.brands,
      this.featuredProducts,
      this.topSlider,
      this.bottomSlider});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    textContact = json['text_contact'];
    textFaq = json['text_faq'];
    textWishlist = json['text_wishlist'];
    textProfile = json['text_profile'];
    textHomeApp = json['text_home_app'];
    textProfileApp = json['text_profile_app'];
    textViewAll = json['text_view_all'];
    textBrandsApp = json['text_brands_app'];
    textGiftSetOffer = json['text_gift_set_offer'];
    textInstagram = json['text_instagram'];
    textVoucher = json['text_voucher'];
    textReward = json['text_reward'];
    textSettings = json['text_settings'];
    textLogout = json['text_logout'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
    if (json['informations'] != null) {
      informations = <Informations>[];
      json['informations'].forEach((v) {
        informations?.add(new Informations.fromJson(v));
      });
    }
    textCount = json['text_count'];
    wishlistCount = json['wishlist_count'];
    instagramUrl = json['instagram_url'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands?.add(new Brands.fromJson(v));
      });
    }
    featuredProducts = json['featured_products'] != null
        ? new FeaturedProducts.fromJson(json['featured_products'])
        : null;
    topSlider = json['top_slider'] != null
        ? new TopSlider.fromJson(json['top_slider'])
        : null;
    bottomSlider = json['bottom_slider'] != null
        ? new TopSlider.fromJson(json['bottom_slider'])
        : null;
  }
  void onChange() {
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['text_contact'] = this.textContact;
    data['text_faq'] = this.textFaq;
    data['text_wishlist'] = this.textWishlist;
    data['text_profile'] = this.textProfile;
    data['text_home_app'] = this.textHomeApp;
    data['text_profile_app'] = this.textProfileApp;
    data['text_view_all'] = this.textViewAll;
    data['text_brands_app'] = this.textBrandsApp;
    data['text_gift_set_offer'] = this.textGiftSetOffer;
    data['text_instagram'] = this.textInstagram;
    data['text_voucher'] = this.textVoucher;
    data['text_reward'] = this.textReward;
    data['text_settings'] = this.textSettings;
    data['text_logout'] = this.textLogout;
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    if (this.informations != null) {
      data['informations'] = this.informations?.map((v) => v.toJson()).toList();
    }
    data['text_count'] = this.textCount;
    data['wishlist_count'] = this.wishlistCount;
    data['instagram_url'] = this.instagramUrl;
    if (this.brands != null) {
      data['brands'] = this.brands?.map((v) => v.toJson()).toList();
    }
    if (this.featuredProducts != null) {
      data['featured_products'] = this.featuredProducts?.toJson();
    }
    if (this.topSlider != null) {
      data['top_slider'] = this.topSlider?.toJson();
    }
    if (this.bottomSlider != null) {
      data['bottom_slider'] = this.bottomSlider?.toJson();
    }
    return data;
  }
}

class Categories {
  String? categoryId;
  String? name;
  String? image;
  String? appImage;

  Categories({this.categoryId, this.name, this.image, this.appImage});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    image = json['image'];
    appImage = json['app_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['app_image'] = this.appImage;
    return data;
  }
}

class Informations {
  String? title;
  String? href;

  Informations({this.title, this.href});

  Informations.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['href'] = this.href;
    return data;
  }
}

class Brands {
  String? name;
  String? image;
  String? nameEng;
  String? nameAr;
  String? href;

  Brands({this.name, this.image, this.nameEng, this.nameAr, this.href});

  Brands.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    nameEng = json['eng_name'];
    nameAr = json['arabic_name'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['href'] = this.href;
    return data;
  }
}

class FeaturedProducts {
  String? headingTitle;
  String? textTax;
  String? buttonCart;
  String? buttonWishlist;
  String? buttonCompare;
  List<Products>? products;

  FeaturedProducts(
      {this.headingTitle,
      this.textTax,
      this.buttonCart,
      this.buttonWishlist,
      this.buttonCompare,
      this.products});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
    headingTitle = json['heading_title'];
    textTax = json['text_tax'];
    buttonCart = json['button_cart'];
    buttonWishlist = json['button_wishlist'];
    buttonCompare = json['button_compare'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading_title'] = this.headingTitle;
    data['text_tax'] = this.textTax;
    data['button_cart'] = this.buttonCart;
    data['button_wishlist'] = this.buttonWishlist;
    data['button_compare'] = this.buttonCompare;
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? thumb;
  String? name;
  String? description;
  String? price;
  var special;
  String? tax;
  bool? rating;
  String? href;

  Products(
      {this.productId,
      this.thumb,
      this.name,
      this.description,
      this.price,
      this.special,
      this.tax,
      this.rating,
      this.href});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    thumb = json['thumb'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    special = json['special'];
    tax = json['tax'];
    rating = json['rating'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['thumb'] = this.thumb;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['special'] = this.special;
    data['tax'] = this.tax;
    data['rating'] = this.rating;
    data['href'] = this.href;
    return data;
  }
}

class TopSlider {
  String? title;
  List<Slides>? slides;
  String? showTitle;
  String? width;
  String? height;
  String? options;
  int? slideshow;

  TopSlider(
      {this.title,
      this.slides,
      this.showTitle,
      this.width,
      this.height,
      this.options,
      this.slideshow});

  TopSlider.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides?.add(new Slides.fromJson(v));
      });
    }
    showTitle = json['show_title'];
    width = json['width'];
    height = json['height'];
    options = json['options'];
    slideshow = json['slideshow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.slides != null) {
      data['slides'] = this.slides?.map((v) => v.toJson()).toList();
    }
    data['show_title'] = this.showTitle;
    data['width'] = this.width;
    data['height'] = this.height;
    data['options'] = this.options;
    data['slideshow'] = this.slideshow;
    return data;
  }
}

class Slides {
  String? title;
  String? link;
  String? textbox;
  String? useHtml;
  String? header;
  String? description;
  String? css;
  String? override;
  String? background;
  String? opacity;
  String? html;
  String? image;
  String? mobileimage;
  String? mobileimage_n;

  Slides(
      {this.title,
      this.link,
      this.textbox,
      this.useHtml,
      this.header,
      this.description,
      this.css,
      this.override,
      this.background,
      this.opacity,
      this.html,
      this.image,
      this.mobileimage,
      this.mobileimage_n});

  Slides.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    textbox = json['textbox'];
    useHtml = json['use_html'];
    header = json['header'];
    description = json['description'];
    css = json['css'];
    override = json['override'];
    background = json['background'];
    opacity = json['opacity'];
    html = json['html'];
    image = json['image'];
    mobileimage = json['mobileimage'];
    mobileimage_n = json['mobileimage_n'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['textbox'] = this.textbox;
    data['use_html'] = this.useHtml;
    data['header'] = this.header;
    data['description'] = this.description;
    data['css'] = this.css;
    data['override'] = this.override;
    data['background'] = this.background;
    data['opacity'] = this.opacity;
    data['html'] = this.html;
    data['image'] = this.image;
    data['mobileimage'] = this.mobileimage;
    data['mobileimage_n'] = this.mobileimage_n;
    return data;
  }
}
