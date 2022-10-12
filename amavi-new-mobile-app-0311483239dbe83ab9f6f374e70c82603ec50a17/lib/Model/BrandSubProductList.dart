class BrandSubCategoryProductListModel {
  String? lang;
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textFilter;
  String? textFilters;
  String? textClear;
  String? textRefine;
  String? textEmpty;
  String? textQuantity;
  String? textManufacturer;
  String? textModel;
  String? textPrice;
  String? textTax;
  String? textPoints;
  String? textCompare;
  String? textSort;
  String? textLimit;
  String? textViewAll;
  String? textViewLess;
  String? buttonCart;
  String? buttonWishlist;
  String? buttonCompare;
  String? buttonContinue;
  String? buttonList;
  String? buttonGrid;
  String? textBrands;
  String? textShow;
  String? textApply;
  String? textReset;
  String? textShowing;
  String? textTo;
  String? textOf;
  String? mainCategoryPath;
  String? thumb;
  String? description;
  String? compare;
  List<AllCategories>? allCategories;
  List<Products>? products;
  var productTotal;
  String? stock;
  List<Sorts>? sorts;
  List<dynamic>? limits;
  String? url;
  String? pagination;
  String? results;
  String? sort;
  String? order;
  String? limit;
  String? continues;

  BrandSubCategoryProductListModel(
      {this.lang,
      this.breadcrumbs,
      this.headingTitle,
      this.textFilter,
      this.textFilters,
      this.textClear,
      this.textRefine,
      this.textEmpty,
      this.textQuantity,
      this.textManufacturer,
      this.textModel,
      this.textPrice,
      this.textTax,
      this.textPoints,
      this.textCompare,
      this.textSort,
      this.textLimit,
      this.textViewAll,
      this.textViewLess,
      this.buttonCart,
      this.buttonWishlist,
      this.buttonCompare,
      this.buttonContinue,
      this.buttonList,
      this.buttonGrid,
      this.textBrands,
      this.textShow,
      this.textApply,
      this.textReset,
      this.textShowing,
      this.textTo,
      this.textOf,
      this.mainCategoryPath,
      this.thumb,
      this.description,
      this.compare,
      this.allCategories,
      this.products,
      this.productTotal,
      this.stock,
      this.sorts,
      this.limits,
      this.url,
      this.pagination,
      this.results,
      this.sort,
      this.order,
      this.limit,
      this.continues});

  BrandSubCategoryProductListModel.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textFilter = json['text_filter'];
    textFilters = json['text_filters'];
    textClear = json['text_clear'];
    textRefine = json['text_refine'];
    textEmpty = json['text_empty'];
    textQuantity = json['text_quantity'];
    textManufacturer = json['text_manufacturer'];
    textModel = json['text_model'];
    textPrice = json['text_price'];
    textTax = json['text_tax'];
    textPoints = json['text_points'];
    textCompare = json['text_compare'];
    textSort = json['text_sort'];
    textLimit = json['text_limit'];
    textViewAll = json['text_view_all'];
    textViewLess = json['text_view_less'];
    buttonCart = json['button_cart'];
    buttonWishlist = json['button_wishlist'];
    buttonCompare = json['button_compare'];
    buttonContinue = json['button_continue'];
    buttonList = json['button_list'];
    buttonGrid = json['button_grid'];
    textBrands = json['text_brands'];
    textShow = json['text_show'];
    textApply = json['text_apply'];
    textReset = json['text_reset'];
    textShowing = json['text_showing'];
    textTo = json['text_to'];
    textOf = json['text_of'];
    mainCategoryPath = json['main_category_path'];
    thumb = json['thumb'];
    description = json['description'];
    compare = json['compare'];
    if (json['all_categories'] != null) {
      allCategories = <AllCategories>[];
      json['all_categories'].forEach((v) {
        allCategories?.add(new AllCategories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    productTotal = json['product_total'];
    stock = json['stock'];
    if (json['sorts'] != null) {
      sorts = <Sorts>[];
      json['sorts'].forEach((v) {
        sorts?.add(new Sorts.fromJson(v));
      });
    }
    if (json['limits'] != null) {
// limits = new List<Limits>();
// json['limits'].forEach((v) { limits.add(new Limits.fromJson(v)); });
    }
    url = json['url'];
    pagination = json['pagination'];
    results = json['results'];
    sort = json['sort'];
    order = json['order'];
    limit = json['limit'];
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_filter'] = this.textFilter;
    data['text_filters'] = this.textFilters;
    data['text_clear'] = this.textClear;
    data['text_refine'] = this.textRefine;
    data['text_empty'] = this.textEmpty;
    data['text_quantity'] = this.textQuantity;
    data['text_manufacturer'] = this.textManufacturer;
    data['text_model'] = this.textModel;
    data['text_price'] = this.textPrice;
    data['text_tax'] = this.textTax;
    data['text_points'] = this.textPoints;
    data['text_compare'] = this.textCompare;
    data['text_sort'] = this.textSort;
    data['text_limit'] = this.textLimit;
    data['text_view_all'] = this.textViewAll;
    data['text_view_less'] = this.textViewLess;
    data['button_cart'] = this.buttonCart;
    data['button_wishlist'] = this.buttonWishlist;
    data['button_compare'] = this.buttonCompare;
    data['button_continue'] = this.buttonContinue;
    data['button_list'] = this.buttonList;
    data['button_grid'] = this.buttonGrid;
    data['text_brands'] = this.textBrands;
    data['text_show'] = this.textShow;
    data['text_apply'] = this.textApply;
    data['text_reset'] = this.textReset;
    data['text_showing'] = this.textShowing;
    data['text_to'] = this.textTo;
    data['text_of'] = this.textOf;
    data['main_category_path'] = this.mainCategoryPath;
    data['thumb'] = this.thumb;
    data['description'] = this.description;
    data['compare'] = this.compare;
    if (this.allCategories != null) {
      data['all_categories'] =
          this.allCategories?.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    data['product_total'] = this.productTotal;
    data['stock'] = this.stock;
    if (this.sorts != null) {
      data['sorts'] = this.sorts?.map((v) => v.toJson()).toList();
    }
    if (this.limits != null) {
      data['limits'] = this.limits?.map((v) => v.toJson()).toList();
    }
    data['url'] = this.url;
    data['pagination'] = this.pagination;
    data['results'] = this.results;
    data['sort'] = this.sort;
    data['order'] = this.order;
    data['limit'] = this.limit;
    data['continue'] = this.continues;
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

class AllCategories {
  String? categoryId;
  String? name;
  List<Children>? children;

  AllCategories({this.categoryId, this.name, this.children});

  AllCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children?.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    if (this.children != null) {
      data['children'] = this.children?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? name;
  String? categoryId;
  int? categoryStatus;

  Children({this.name, this.categoryId, this.categoryStatus});

  Children.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['category_id'];
    categoryStatus = json['category_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['category_status'] = this.categoryStatus;
    return data;
  }
}

class Products {
  String? manufacturerId;
  String? quantity;
  String? productId;
  String? thumb;
  int? wishlist;
  String? stock;
  String? name;
  String? description;
  String? price;
  var special;
  var brandDisc;
  String? tax;
  String? minimum;
  int? rating;
  String? href;
  String? dealzadaBadges;
  int? activeproducts;
  var productTotal;

  Products(
      {this.manufacturerId,
      this.quantity,
      this.productId,
      this.thumb,
      this.wishlist,
      this.stock,
      this.name,
      this.description,
      this.price,
      this.dealzadaBadges,
      this.special,
      this.brandDisc,
      this.tax,
      this.minimum,
      this.rating,
      this.href,
      this.activeproducts,
      this.productTotal});

  Products.fromJson(Map<String, dynamic> json) {
    manufacturerId = json['manufacturer_id'];
    quantity = json['quantity'];
    productId = json['product_id'];
    thumb = json['thumb'];
    wishlist = json['wishlist'];
    stock = json['stock'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    special = json['special'];
    brandDisc = json['brand_disc'];
    tax = json['tax'];
    minimum = json['minimum'];
    rating = json['rating'];
    href = json['href'];
    activeproducts = json['activeproducts'];
    productTotal = json['product_total'];
    dealzadaBadges = json['dealzada_badges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manufacturer_id'] = this.manufacturerId;
    data['quantity'] = this.quantity;
    data['product_id'] = this.productId;
    data['thumb'] = this.thumb;
    data['wishlist'] = this.wishlist;
    data['stock'] = this.stock;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['special'] = this.special;
    data['brand_disc'] = this.brandDisc;
    data['tax'] = this.tax;
    data['minimum'] = this.minimum;
    data['rating'] = this.rating;
    data['href'] = this.href;
    data['activeproducts'] = this.activeproducts;
    data['product_total'] = this.productTotal;
    data['dealzada_badges'] = this.dealzadaBadges;
    return data;
  }
}

class Sorts {
  String? text;
  String? value;
  String? href;

  Sorts({this.text, this.value, this.href});

  Sorts.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
    data['href'] = this.href;
    return data;
  }
}
