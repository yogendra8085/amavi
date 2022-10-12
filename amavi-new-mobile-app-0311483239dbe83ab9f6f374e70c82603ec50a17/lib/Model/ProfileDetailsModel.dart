class ProfileDetailsModel {
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? fax;
  List<CustomFields>? customFields;
  Null? accountCustomField;
  String? back;
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textYourDetails;
  String? textAdditional;
  String? textSelect;
  String? textLoading;
  String? entryFirstname;
  String? entryLastname;
  String? entryEmail;
  String? entryTelephone;
  String? entryFax;
  String? buttonContinue;
  String? buttonBack;
  String? buttonUpload;
  String? errorWarning;
  String? errorFirstname;
  String? errorLastname;
  String? errorEmail;
  String? errorTelephone;
  List<Null>? errorCustomField;
  String? action;

  ProfileDetailsModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.telephone,
      this.fax,
      this.customFields,
      this.accountCustomField,
      this.back,
      this.breadcrumbs,
      this.headingTitle,
      this.textYourDetails,
      this.textAdditional,
      this.textSelect,
      this.textLoading,
      this.entryFirstname,
      this.entryLastname,
      this.entryEmail,
      this.entryTelephone,
      this.entryFax,
      this.buttonContinue,
      this.buttonBack,
      this.buttonUpload,
      this.errorWarning,
      this.errorFirstname,
      this.errorLastname,
      this.errorEmail,
      this.errorTelephone,
      this.errorCustomField,
      this.action});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    fax = json['fax'];
    if (json['custom_fields'] != null) {
      customFields = <CustomFields>[];
      json['custom_fields'].forEach((v) {
        customFields?.add(new CustomFields.fromJson(v));
      });
    }
    accountCustomField = json['account_custom_field'];
    back = json['back'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textYourDetails = json['text_your_details'];
    textAdditional = json['text_additional'];
    textSelect = json['text_select'];
    textLoading = json['text_loading'];
    entryFirstname = json['entry_firstname'];
    entryLastname = json['entry_lastname'];
    entryEmail = json['entry_email'];
    entryTelephone = json['entry_telephone'];
    entryFax = json['entry_fax'];
    buttonContinue = json['button_continue'];
    buttonBack = json['button_back'];
    buttonUpload = json['button_upload'];
    errorWarning = json['error_warning'];
    errorFirstname = json['error_firstname'];
    errorLastname = json['error_lastname'];
    errorEmail = json['error_email'];
    errorTelephone = json['error_telephone'];
    // if (json['error_custom_field'] != null) {
    //   errorCustomField = new List<Null>();
    //   json['error_custom_field'].forEach((v) {
    //     errorCustomField.add(new Null.fromJson(v));
    //   });
    // }
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['fax'] = this.fax;
    if (this.customFields != null) {
      data['custom_fields'] =
          this.customFields?.map((v) => v.toJson()).toList();
    }
    data['account_custom_field'] = this.accountCustomField;
    data['back'] = this.back;
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_your_details'] = this.textYourDetails;
    data['text_additional'] = this.textAdditional;
    data['text_select'] = this.textSelect;
    data['text_loading'] = this.textLoading;
    data['entry_firstname'] = this.entryFirstname;
    data['entry_lastname'] = this.entryLastname;
    data['entry_email'] = this.entryEmail;
    data['entry_telephone'] = this.entryTelephone;
    data['entry_fax'] = this.entryFax;
    data['button_continue'] = this.buttonContinue;
    data['button_back'] = this.buttonBack;
    data['button_upload'] = this.buttonUpload;
    data['error_warning'] = this.errorWarning;
    data['error_firstname'] = this.errorFirstname;
    data['error_lastname'] = this.errorLastname;
    data['error_email'] = this.errorEmail;
    data['error_telephone'] = this.errorTelephone;
    // if (this.errorCustomField != null) {
    //   data['error_custom_field'] =
    //       this.errorCustomField.map((v) => v.toJson()).toList();
    // }
    data['action'] = this.action;
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
      customFieldValue = <Null>[];
      json['custom_field_value'].forEach((v) {
        // customFieldValue.add(new Null.fromJson(v));
      });
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
      //  data['custom_field_value'] =
      //  this.customFieldValue.map((v) => v.toJson()).toList();
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
