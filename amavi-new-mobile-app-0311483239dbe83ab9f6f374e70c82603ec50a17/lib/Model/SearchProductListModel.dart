class SearchProductListModel {
  String? headingTitle;
  String? textEmpty;
  String? textSearch;
  String? textKeyword;
  String? textCategory;
  String? textSubCategory;
  String? textQuantity;
  String? textManufacturer;
  String? textModel;
  String? textPrice;
  String? textTax;
  String? textPoints;
  String? textCompare;
  String? textSort;
  String? textLimit;
  String? entrySearch;
  String? entryDescription;
  String? buttonSearch;
  String? buttonCart;
  String? buttonWishlist;
  String? buttonCompare;
  String? buttonList;
  String? buttonGrid;
  String? compare;
  List<Categories>? categories;
  List<Products>? products;
  List<Sorts>? sorts;
  List<dynamic>? limits;
  String? pagination;
  String? results;
  String? totalProducts;
  int? currentPage;
  int? totalPage;
  String? nextPageUrl;
  String? search;
  String? description;
  int? categoryId;
  String? subCategory;
  String? sort;
  String? order;
  var limit;

  SearchProductListModel(
      {this.headingTitle,
      this.textEmpty,
      this.textSearch,
      this.textKeyword,
      this.textCategory,
      this.textSubCategory,
      this.textQuantity,
      this.textManufacturer,
      this.textModel,
      this.textPrice,
      this.textTax,
      this.textPoints,
      this.textCompare,
      this.textSort,
      this.textLimit,
      this.entrySearch,
      this.entryDescription,
      this.buttonSearch,
      this.buttonCart,
      this.buttonWishlist,
      this.buttonCompare,
      this.buttonList,
      this.buttonGrid,
      this.compare,
      this.categories,
      this.products,
      this.sorts,
      this.limits,
      this.pagination,
      this.results,
      this.totalProducts,
      this.currentPage,
      this.totalPage,
      this.nextPageUrl,
      this.search,
      this.description,
      this.categoryId,
      this.subCategory,
      this.sort,
      this.order,
      this.limit});

  SearchProductListModel.fromJson(Map<String, dynamic> json) {
    headingTitle = json['heading_title'];
    textEmpty = json['text_empty'];
    textSearch = json['text_search'];
    textKeyword = json['text_keyword'];
    textCategory = json['text_category'];
    textSubCategory = json['text_sub_category'];
    textQuantity = json['text_quantity'];
    textManufacturer = json['text_manufacturer'];
    textModel = json['text_model'];
    textPrice = json['text_price'];
    textTax = json['text_tax'];
    textPoints = json['text_points'];
    textCompare = json['text_compare'];
    textSort = json['text_sort'];
    textLimit = json['text_limit'];
    entrySearch = json['entry_search'];
    entryDescription = json['entry_description'];
    buttonSearch = json['button_search'];
    buttonCart = json['button_cart'];
    buttonWishlist = json['button_wishlist'];
    buttonCompare = json['button_compare'];
    buttonList = json['button_list'];
    buttonGrid = json['button_grid'];
    compare = json['compare'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products?.add(new Products.fromJson(v));
      });
    }
    if (json['sorts'] != null) {
      sorts = <Sorts>[];
      json['sorts'].forEach((v) {
        sorts?.add(new Sorts.fromJson(v));
      });
    }
    if (json['limits'] != null) {
      // limits = new List<Limits>();
      json['limits'].forEach((v) {
        // limits.add(new Limits.fromJson(v));
      });
    }
    pagination = json['pagination'];
    results = json['results'];
    totalProducts = json['total_products'];
    currentPage = json['current_page'];
    totalPage = json['total_page'];
    nextPageUrl = json['next_page_url'];
    search = json['search'];
    description = json['description'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    sort = json['sort'];
    order = json['order'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading_title'] = this.headingTitle;
    data['text_empty'] = this.textEmpty;
    data['text_search'] = this.textSearch;
    data['text_keyword'] = this.textKeyword;
    data['text_category'] = this.textCategory;
    data['text_sub_category'] = this.textSubCategory;
    data['text_quantity'] = this.textQuantity;
    data['text_manufacturer'] = this.textManufacturer;
    data['text_model'] = this.textModel;
    data['text_price'] = this.textPrice;
    data['text_tax'] = this.textTax;
    data['text_points'] = this.textPoints;
    data['text_compare'] = this.textCompare;
    data['text_sort'] = this.textSort;
    data['text_limit'] = this.textLimit;
    data['entry_search'] = this.entrySearch;
    data['entry_description'] = this.entryDescription;
    data['button_search'] = this.buttonSearch;
    data['button_cart'] = this.buttonCart;
    data['button_wishlist'] = this.buttonWishlist;
    data['button_compare'] = this.buttonCompare;
    data['button_list'] = this.buttonList;
    data['button_grid'] = this.buttonGrid;
    data['compare'] = this.compare;
    if (this.categories != null) {
      data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products?.map((v) => v.toJson()).toList();
    }
    if (this.sorts != null) {
      data['sorts'] = this.sorts?.map((v) => v.toJson()).toList();
    }
    if (this.limits != null) {
      data['limits'] = this.limits?.map((v) => v.toJson()).toList();
    }
    data['pagination'] = this.pagination;
    data['results'] = this.results;
    data['total_products'] = this.totalProducts;
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    data['next_page_url'] = this.nextPageUrl;
    data['search'] = this.search;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['sub_category'] = this.subCategory;
    data['sort'] = this.sort;
    data['order'] = this.order;
    data['limit'] = this.limit;
    return data;
  }
}

class Categories {
  String? categoryId;
  String? name;
  List<Children>? children;

  Categories({this.categoryId, this.name, this.children});

  Categories.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? name;
  List<Null>? children;

  Children({this.categoryId, this.name, this.children});

  Children.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        //   children.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    if (this.children != null) {
//      data['children'] = this.children.map((v) => v.toJson()).toList();
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
  dynamic? special;
  String? tax;
  String? minimum;
  int? rating;
  String? href;

  Products(
      {this.productId,
      this.thumb,
      this.name,
      this.description,
      this.price,
      this.special,
      this.tax,
      this.minimum,
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
    minimum = json['minimum'];
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
    data['minimum'] = this.minimum;
    data['rating'] = this.rating;
    data['href'] = this.href;
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
