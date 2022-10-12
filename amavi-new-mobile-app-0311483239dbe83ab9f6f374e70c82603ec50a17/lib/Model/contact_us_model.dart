import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) =>
    ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.errorName,
    this.errorEmail,
    this.errorEnquiry,
    this.headingTitle,
    this.textStore,
    this.textContact,
    this.textAddress,
    this.textTelephone,
    this.buttonSubmit,
    this.entryName,
    this.entryLastname,
    this.entryEmail,
    this.entrySubject,
    this.entryEnquiry,
  });

  final String? errorName;
  final String? errorEmail;
  final String? errorEnquiry;
  final String? headingTitle;
  final String? textStore;
  final String? textContact;
  final String? textAddress;
  final String? textTelephone;
  final String? buttonSubmit;
  final String? entryName;
  final String? entryLastname;
  final String? entryEmail;
  final String? entrySubject;
  final String? entryEnquiry;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        errorName: json["error_name"],
        errorEmail: json["error_email"],
        errorEnquiry: json["error_enquiry"],
        headingTitle: json["heading_title"],
        textStore: json["text_store"],
        textContact: json["text_contact"],
        textAddress: json["text_address"],
        textTelephone: json["text_telephone"],
        buttonSubmit: json["button_submit"],
        entryName: json["entry_name"],
        entryLastname: json["entry_lastname"],
        entryEmail: json["entry_email"],
        entrySubject: json["entry_subject"],
        entryEnquiry: json["entry_enquiry"],
      );

  Map<String, dynamic> toJson() => {
        "error_name": errorName,
        "error_email": errorEmail,
        "error_enquiry": errorEnquiry,
        "heading_title": headingTitle,
        "text_store": textStore,
        "text_contact": textContact,
        "text_address": textAddress,
        "text_telephone": textTelephone,
        "button_submit": buttonSubmit,
        "entry_name": entryName,
        "entry_lastname": entryLastname,
        "entry_email": entryEmail,
        "entry_subject": entrySubject,
        "entry_enquiry": entryEnquiry,
      };
}
