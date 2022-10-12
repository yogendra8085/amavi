class BrandListModel {
  String? headingTitle;
  String? textIndex;
  String? textEmpty;
  String? buttonContinue;
  List<Brands>? brands;
  String? continues;

  BrandListModel(
      {this.headingTitle,
      this.textIndex,
      this.textEmpty,
      this.buttonContinue,
      this.brands,
      this.continues});

  BrandListModel.fromJson(Map<String, dynamic> json) {
    headingTitle = json['heading_title'];
    textIndex = json['text_index'];
    textEmpty = json['text_empty'];
    buttonContinue = json['button_continue'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands?.add(new Brands.fromJson(v));
      });
    }
    continues = json['continue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading_title'] = this.headingTitle;
    data['text_index'] = this.textIndex;
    data['text_empty'] = this.textEmpty;
    data['button_continue'] = this.buttonContinue;
    if (this.brands != null) {
      data['brands'] = this.brands?.map((v) => v.toJson()).toList();
    }
    data['continue'] = this.continues;
    return data;
  }
}

class Brands {
  String? name;
  String? nameEng;
  String? nameAr;
  String? image;

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
