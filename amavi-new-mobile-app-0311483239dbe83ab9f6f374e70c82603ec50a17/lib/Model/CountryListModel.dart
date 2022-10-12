class CountryListModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textAccountAlready;
  String? textYourDetails;
  String? textYourAddress;
  String? textYourPassword;
  String? textNewsletter;
  String? textYes;
  String? textNo;
  String? textSelect;
  String? textNone;
  String? textLoading;
  String? entryCustomerGroup;
  String? entryFirstname;
  String? entryLastname;
  String? entryEmail;
  String? entryTelephone;
  String? entryFax;
  String? entryCompany;
  String? entryAddress1;
  String? entryAddress2;
  String? entryPostcode;
  String? entryCity;
  String? entryCountry;
  String? entryZone;
  String? entryNewsletter;
  String? entryPassword;
  String? entryConfirm;
  String? buttonContinue;
  String? buttonBack;
  String? buttonUpload;
  String? errorWarning;
  String? errorFirstname;
  String? errorLastname;
  String? errorEmail;
  String? errorTelephone;
  String? errorAddress1;
  String? errorCity;
  String? errorPostcode;
  String? errorCountry;
  String? errorZone;
  String? errorPassword;
  String? errorConfirm;
  String? action;
  List<CustomerGroups>? customerGroups;
  String? customerGroupId;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? fax;
  String? company;
  String? address1;
  String? address2;
  String? postcode;
  String? city;
  String? countryId;
  String? zoneId;
  List<Countries>? countries;
  List<CustomFields>? customFields;
  List<Null>? registerCustomField;
  String? password;
  String? confirm;
  String? newsletter;
  String? captcha;
  String? textAgree;
  String? agreeLink;
  String? agreeTitle;
  bool? agree;

  CountryListModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textAccountAlready,
      this.textYourDetails,
      this.textYourAddress,
      this.textYourPassword,
      this.textNewsletter,
      this.textYes,
      this.textNo,
      this.textSelect,
      this.textNone,
      this.textLoading,
      this.entryCustomerGroup,
      this.entryFirstname,
      this.entryLastname,
      this.entryEmail,
      this.entryTelephone,
      this.entryFax,
      this.entryCompany,
      this.entryAddress1,
      this.entryAddress2,
      this.entryPostcode,
      this.entryCity,
      this.entryCountry,
      this.entryZone,
      this.entryNewsletter,
      this.entryPassword,
      this.entryConfirm,
      this.buttonContinue,
      this.buttonBack,
      this.buttonUpload,
      this.errorWarning,
      this.errorFirstname,
      this.errorLastname,
      this.errorEmail,
      this.errorTelephone,
      this.errorAddress1,
      this.errorCity,
      this.errorPostcode,
      this.errorCountry,
      this.errorZone,
      this.errorPassword,
      this.errorConfirm,
      this.action,
      this.customerGroups,
      this.customerGroupId,
      this.firstname,
      this.lastname,
      this.email,
      this.telephone,
      this.fax,
      this.company,
      this.address1,
      this.address2,
      this.postcode,
      this.city,
      this.countryId,
      this.zoneId,
      this.countries,
      this.customFields,
      this.registerCustomField,
      this.password,
      this.confirm,
      this.newsletter,
      this.captcha,
      this.textAgree,
      this.agreeLink,
      this.agreeTitle,
      this.agree});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textAccountAlready = json['text_account_already'];
    textYourDetails = json['text_your_details'];
    textYourAddress = json['text_your_address'];
    textYourPassword = json['text_your_password'];
    textNewsletter = json['text_newsletter'];
    textYes = json['text_yes'];
    textNo = json['text_no'];
    textSelect = json['text_select'];
    textNone = json['text_none'];
    textLoading = json['text_loading'];
    entryCustomerGroup = json['entry_customer_group'];
    entryFirstname = json['entry_firstname'];
    entryLastname = json['entry_lastname'];
    entryEmail = json['entry_email'];
    entryTelephone = json['entry_telephone'];
    entryFax = json['entry_fax'];
    entryCompany = json['entry_company'];
    entryAddress1 = json['entry_address_1'];
    entryAddress2 = json['entry_address_2'];
    entryPostcode = json['entry_postcode'];
    entryCity = json['entry_city'];
    entryCountry = json['entry_country'];
    entryZone = json['entry_zone'];
    entryNewsletter = json['entry_newsletter'];
    entryPassword = json['entry_password'];
    entryConfirm = json['entry_confirm'];
    buttonContinue = json['button_continue'];
    buttonBack = json['button_back'];
    buttonUpload = json['button_upload'];
    errorWarning = json['error_warning'];
    errorFirstname = json['error_firstname'];
    errorLastname = json['error_lastname'];
    errorEmail = json['error_email'];
    errorTelephone = json['error_telephone'];
    errorAddress1 = json['error_address_1'];
    errorCity = json['error_city'];
    errorPostcode = json['error_postcode'];
    errorCountry = json['error_country'];
    errorZone = json['error_zone'];
    errorPassword = json['error_password'];
    errorConfirm = json['error_confirm'];
    action = json['action'];
    if (json['customer_groups'] != null) {
      customerGroups = <CustomerGroups>[];
      json['customer_groups'].forEach((v) {
        customerGroups?.add(new CustomerGroups.fromJson(v));
      });
    }
    customerGroupId = json['customer_group_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    fax = json['fax'];
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
    // if (json['register_custom_field'] != null) {
    //   registerCustomField = new List<Null>();
    //   json['register_custom_field'].forEach((v) {
    //     registerCustomField.add(new Null.fromJson(v));
    //   });
//    }
    password = json['password'];
    confirm = json['confirm'];
    newsletter = json['newsletter'];
    captcha = json['captcha'];
    textAgree = json['text_agree'];
    agreeLink = json['agree_link'];
    agreeTitle = json['agree_title'];
    agree = json['agree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_account_already'] = this.textAccountAlready;
    data['text_your_details'] = this.textYourDetails;
    data['text_your_address'] = this.textYourAddress;
    data['text_your_password'] = this.textYourPassword;
    data['text_newsletter'] = this.textNewsletter;
    data['text_yes'] = this.textYes;
    data['text_no'] = this.textNo;
    data['text_select'] = this.textSelect;
    data['text_none'] = this.textNone;
    data['text_loading'] = this.textLoading;
    data['entry_customer_group'] = this.entryCustomerGroup;
    data['entry_firstname'] = this.entryFirstname;
    data['entry_lastname'] = this.entryLastname;
    data['entry_email'] = this.entryEmail;
    data['entry_telephone'] = this.entryTelephone;
    data['entry_fax'] = this.entryFax;
    data['entry_company'] = this.entryCompany;
    data['entry_address_1'] = this.entryAddress1;
    data['entry_address_2'] = this.entryAddress2;
    data['entry_postcode'] = this.entryPostcode;
    data['entry_city'] = this.entryCity;
    data['entry_country'] = this.entryCountry;
    data['entry_zone'] = this.entryZone;
    data['entry_newsletter'] = this.entryNewsletter;
    data['entry_password'] = this.entryPassword;
    data['entry_confirm'] = this.entryConfirm;
    data['button_continue'] = this.buttonContinue;
    data['button_back'] = this.buttonBack;
    data['button_upload'] = this.buttonUpload;
    data['error_warning'] = this.errorWarning;
    data['error_firstname'] = this.errorFirstname;
    data['error_lastname'] = this.errorLastname;
    data['error_email'] = this.errorEmail;
    data['error_telephone'] = this.errorTelephone;
    data['error_address_1'] = this.errorAddress1;
    data['error_city'] = this.errorCity;
    data['error_postcode'] = this.errorPostcode;
    data['error_country'] = this.errorCountry;
    data['error_zone'] = this.errorZone;
    data['error_password'] = this.errorPassword;
    data['error_confirm'] = this.errorConfirm;
    data['action'] = this.action;
    if (this.customerGroups != null) {
      data['customer_groups'] =
          this.customerGroups?.map((v) => v.toJson()).toList();
    }
    data['customer_group_id'] = this.customerGroupId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
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
    // if (this.registerCustomField != null) {
    //   data['register_custom_field'] =
    //       this.registerCustomField.map((v) => v.toJson()).toList();
    // }
    data['password'] = this.password;
    data['confirm'] = this.confirm;
    data['newsletter'] = this.newsletter;
    data['captcha'] = this.captcha;
    data['text_agree'] = this.textAgree;
    data['agree_link'] = this.agreeLink;
    data['agree_title'] = this.agreeTitle;
    data['agree'] = this.agree;
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

class CustomerGroups {
  String? customerGroupId;
  String? approval;
  String? sortOrder;
  String? languageId;
  String? name;
  String? description;

  CustomerGroups(
      {this.customerGroupId,
      this.approval,
      this.sortOrder,
      this.languageId,
      this.name,
      this.description});

  CustomerGroups.fromJson(Map<String, dynamic> json) {
    customerGroupId = json['customer_group_id'];
    approval = json['approval'];
    sortOrder = json['sort_order'];
    languageId = json['language_id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_group_id'] = this.customerGroupId;
    data['approval'] = this.approval;
    data['sort_order'] = this.sortOrder;
    data['language_id'] = this.languageId;
    data['name'] = this.name;
    data['description'] = this.description;
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
    // if (json['custom_field_value'] != null) {
    //   customFieldValue = new List<Null>();
    //   json['custom_field_value'].forEach((v) {
    //     customFieldValue.add(new Null.fromJson(v));
    //   });
    // }
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
    // if (this.customFieldValue != null) {
    //   data['custom_field_value'] =
    //       this.customFieldValue.map((v) => v.toJson()).toList();
    // }
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
