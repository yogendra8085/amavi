class CategoryListModel {
  String? lang;
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  ParentCategory? parentCategory;
  List<ChildCategories>? childCategories;
  String? continues;

  CategoryListModel(
      {this.lang,
      this.breadcrumbs,
      this.headingTitle,
      this.parentCategory,
      this.childCategories,
      this.continues});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    parentCategory = json['parent_category'] != null
        ? new ParentCategory.fromJson(json['parent_category'])
        : null;
    if (json['child_categories'] != null) {
      childCategories = <ChildCategories>[];
      json['child_categories'].forEach((v) {
        childCategories?.add(new ChildCategories.fromJson(v));
      });
    }
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    if (this.parentCategory != null) {
      data['parent_category'] = this.parentCategory?.toJson();
    }
    if (this.childCategories != null) {
      data['child_categories'] =
          this.childCategories?.map((v) => v.toJson()).toList();
    }
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

class ParentCategory {
  String? categoryId;
  String? name;
  var image;
  String? appImage;

  ParentCategory({this.categoryId, this.name, this.image, this.appImage});

  ParentCategory.fromJson(Map<String, dynamic> json) {
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

class ChildCategories {
  String? categoryId;
  String? name;
  int? count;
  String? image;
  var appImage;

  ChildCategories(
      {this.categoryId, this.name, this.count, this.image, this.appImage});

  ChildCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    name = json['name'];
    count = json['count'];
    image = json['image'];
    appImage = json['app_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['count'] = this.count;
    data['image'] = this.image;
    data['app_image'] = this.appImage;
    return data;
  }
}
