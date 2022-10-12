class CurrencySettingModel {
  String? currentLanguageCode;
  List<Languages>? languages;
  String? currentCurrencyCode;
  List<Currencies>? currencies;

  CurrencySettingModel(
      {this.currentLanguageCode,
      this.languages,
      this.currentCurrencyCode,
      this.currencies});

  CurrencySettingModel.fromJson(Map<String, dynamic> json) {
    currentLanguageCode = json['current_language_code'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages?.add(new Languages.fromJson(v));
      });
    }
    currentCurrencyCode = json['current_currency_code'];
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies?.add(new Currencies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_language_code'] = this.currentLanguageCode;
    if (this.languages != null) {
      data['languages'] = this.languages?.map((v) => v.toJson()).toList();
    }
    data['current_currency_code'] = this.currentCurrencyCode;
    if (this.currencies != null) {
      data['currencies'] = this.currencies?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  String? name;
  String? code;

  Languages({this.name, this.code});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class Currencies {
  String? enTitle;
  String? arTitle;
  String? code;
  String? symbolLeft;
  String? symbolRight;

  Currencies(
      {this.enTitle,
      this.arTitle,
      this.code,
      this.symbolLeft,
      this.symbolRight});

  Currencies.fromJson(Map<String, dynamic> json) {
    enTitle = json['en_title'];
    arTitle = json['ar_title'];
    code = json['code'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en_title'] = this.enTitle;
    data['ar_title'] = this.arTitle;
    data['code'] = this.code;
    data['symbol_left'] = this.symbolLeft;
    data['symbol_right'] = this.symbolRight;
    return data;
  }
}
