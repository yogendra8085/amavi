class AddAddressModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textEditAddress;
  String? textYes;
  String? textNo;
  String? textSelect;
  String? textNone;
  String? textLoading;
  String? entryFirstname;
  String? entryLastname;
  String? entryCompany;
  String? entryAddress1;
  String? entryAddress2;
  String? entryPostcode;
  String? entryCity;
  String? entryEmail;
  String? entryPhone;
  String? entryCountry;
  String? entryZone;
  String? entryDefault;
  String? buttonContinue;
  String? buttonBack;
  String? buttonUpload;
  String? errorFirstname;
  String? errorLastname;
  String? errorAddress1;
  String? errorCity;
  String? errorPostcode;
  String? errorCountry;
  String? errorZone;
  List<Null>? errorCustomField;
  String? action;
  String? firstname;
  String? lastname;
  String? company;
  String? address1;
  String? address2;
  String? postcode;
  String? city;
  String? countryId;
  String? zoneId;
  List<Countries>? countries;
  List<CustomFields>? customFields;
  List<Null>? addressCustomField;
  bool? defaults;
  String? back;
  String? email;
  String? telephone;

  AddAddressModel({
    required this.breadcrumbs,
    this.headingTitle,
    this.textEditAddress,
    this.textYes,
    this.textNo,
    this.textSelect,
    this.textNone,
    this.textLoading,
    this.entryFirstname,
    this.entryLastname,
    this.entryCompany,
    this.entryEmail,
    this.entryPhone,
    this.entryAddress1,
    this.entryAddress2,
    this.entryPostcode,
    this.entryCity,
    this.entryCountry,
    this.entryZone,
    this.entryDefault,
    this.buttonContinue,
    this.buttonBack,
    this.buttonUpload,
    this.errorFirstname,
    this.errorLastname,
    this.errorAddress1,
    this.errorCity,
    this.errorPostcode,
    this.errorCountry,
    this.errorZone,
    this.errorCustomField,
    this.action,
    this.firstname,
    this.lastname,
    this.company,
    this.address1,
    this.address2,
    this.postcode,
    required this.city,
    this.countryId,
    this.zoneId,
    this.countries,
    this.customFields,
    this.addressCustomField,
    this.defaults,
    this.back,
    this.email,
    this.telephone,
  });

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textEditAddress = json['text_edit_address'];
    textYes = json['text_yes'];
    textNo = json['text_no'];
    textSelect = json['text_select'];
    textNone = json['text_none'];
    textLoading = json['text_loading'];
    entryFirstname = json['entry_firstname'];
    entryLastname = json['entry_lastname'];
    entryCompany = json['entry_company'];
    entryAddress1 = json['entry_address_1'];
    entryAddress2 = json['entry_address_2'];
    entryPostcode = json['entry_postcode'];
    entryCity = json['entry_city'];
    entryEmail = json['entry_email'];
    entryPhone = json['entry_telephone'];
    entryCountry = json['entry_country'];
    entryZone = json['entry_zone'];
    entryDefault = json['entry_default'];
    buttonContinue = json['button_continue'] ?? json['button_submit'];
    buttonBack = json['button_back'];
    buttonUpload = json['button_upload'];
    errorFirstname = json['error_firstname'];
    errorLastname = json['error_lastname'];
    errorAddress1 = json['error_address_1'];
    errorCity = json['error_city'];
    errorPostcode = json['error_postcode'];
    errorCountry = json['error_country'];
    errorZone = json['error_zone'];
    if (json['error_custom_field'] != null) {
      errorCustomField = [];
//json['error_custom_field'].forEach((v) { errorCustomField.add(new Null.fromJson(v)); });
    }
    action = json['action'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    postcode = json['postcode'];
    city = json['city'];
    countryId = json['country_id'];
    zoneId = json['zone_id'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries?.add(new Countries.fromJson(v));
      });
    }
    if (json['custom_fields'] != null) {
      customFields = <CustomFields>[];
      json['custom_fields'].forEach((v) {
        customFields?.add(new CustomFields.fromJson(v));
      });
    }
    if (json['address_custom_field'] != null) {
      addressCustomField = [];
//json['address_custom_field'].forEach((v) { addressCustomField.add(new Null.fromJson(v)); });
    }
    defaults = json['default'];
    back = json['back'];
    email = json['email'];
    telephone = json['telephone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_edit_address'] = this.textEditAddress;
    data['text_yes'] = this.textYes;
    data['text_no'] = this.textNo;
    data['text_select'] = this.textSelect;
    data['text_none'] = this.textNone;
    data['text_loading'] = this.textLoading;
    data['entry_firstname'] = this.entryFirstname;
    data['entry_lastname'] = this.entryLastname;
    data['entry_company'] = this.entryCompany;
    data['entry_address_1'] = this.entryAddress1;
    data['entry_address_2'] = this.entryAddress2;
    data['entry_postcode'] = this.entryPostcode;
    data['entry_city'] = this.entryCity;
    data['entry_country'] = this.entryCountry;
    data['entry_zone'] = this.entryZone;
    data['entry_default'] = this.entryDefault;
    data['button_continue'] = this.buttonContinue;
    data['button_back'] = this.buttonBack;
    data['button_upload'] = this.buttonUpload;
    data['error_firstname'] = this.errorFirstname;
    data['error_lastname'] = this.errorLastname;
    data['error_address_1'] = this.errorAddress1;
    data['error_city'] = this.errorCity;
    data['error_postcode'] = this.errorPostcode;
    data['error_country'] = this.errorCountry;
    data['error_zone'] = this.errorZone;
    if (this.errorCustomField != null) {
//    data['error_custom_field'] = this.errorCustomField.map((v) => v.toJson()).toList();
    }
    data['action'] = this.action;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['country_id'] = this.countryId;
    data['zone_id'] = this.zoneId;
    if (this.countries != null) {
      data['countries'] = this.countries?.map((v) => v.toJson()).toList();
    }
    if (this.customFields != null) {
      data['custom_fields'] =
          this.customFields?.map((v) => v.toJson()).toList();
    }
    if (this.addressCustomField != null) {
//    data['address_custom_field'] = this.addressCustomField.map((v) => v.toJson()).toList();
    }
    data['default'] = this.defaults;
    data['back'] = this.back;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
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

class CustomFields {
  String? customFieldId;
  List<Null>? customFieldValue;
  String? name;
  String? type;
  String? value;
  String? validation;
  String? location;
  bool? required;
  String? sortOrder;

  CustomFields(
      {this.customFieldId,
      this.customFieldValue,
      this.name,
      this.type,
      this.value,
      this.validation,
      this.location,
      this.required,
      this.sortOrder});

  CustomFields.fromJson(Map<String, dynamic> json) {
    customFieldId = json['custom_field_id'];
    if (json['custom_field_value'] != null) {
      customFieldValue = [];
//      json['custom_field_value'].forEach((v) { customFieldValue.add(new Null.fromJson(v)); });
    }
    name = json['name'];
    type = json['type'];
    value = json['value'];
    validation = json['validation'];
    location = json['location'];
    required = json['required'];
    sortOrder = json['sort_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom_field_id'] = this.customFieldId;
    if (this.customFieldValue != null) {
//      data['custom_field_value'] = this.customFieldValue.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    data['validation'] = this.validation;
    data['location'] = this.location;
    data['required'] = this.required;
    data['sort_order'] = this.sortOrder;
    return data;
  }
}
