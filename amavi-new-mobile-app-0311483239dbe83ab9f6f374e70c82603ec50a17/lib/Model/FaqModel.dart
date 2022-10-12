class FaqModel {
  List<Breadcrumbs>? breadcrumbs;
  String? headingTitle;
  String? textNoFaqFound;
  String? faqManagerStatus;
  List<FaqManagers>? faqManagers;

  FaqModel(
      {this.breadcrumbs,
      this.headingTitle,
      this.textNoFaqFound,
      this.faqManagerStatus,
      this.faqManagers});

  FaqModel.fromJson(Map<String, dynamic> json) {
    if (json['breadcrumbs'] != null) {
      breadcrumbs = <Breadcrumbs>[];
      json['breadcrumbs'].forEach((v) {
        breadcrumbs?.add(new Breadcrumbs.fromJson(v));
      });
    }
    headingTitle = json['heading_title'];
    textNoFaqFound = json['text_no_faq_found'];
    faqManagerStatus = json['faq_manager_status'];
    if (json['faq_managers'] != null) {
      faqManagers = <FaqManagers>[];
      json['faq_managers'].forEach((v) {
        faqManagers?.add(new FaqManagers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breadcrumbs != null) {
      data['breadcrumbs'] = this.breadcrumbs?.map((v) => v.toJson()).toList();
    }
    data['heading_title'] = this.headingTitle;
    data['text_no_faq_found'] = this.textNoFaqFound;
    data['faq_manager_status'] = this.faqManagerStatus;
    if (this.faqManagers != null) {
      data['faq_managers'] = this.faqManagers?.map((v) => v.toJson()).toList();
    }
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

class FaqManagers {
  String? sectionTitle;
  List<SubSections>? subSections;
  int? counter;

  FaqManagers({this.sectionTitle, this.subSections, this.counter});

  FaqManagers.fromJson(Map<String, dynamic> json) {
    sectionTitle = json['section_title'];
    if (json['sub_sections'] != null) {
      subSections = <SubSections>[];
      json['sub_sections'].forEach((v) {
        subSections?.add(new SubSections.fromJson(v));
      });
    }
    counter = json['counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['section_title'] = this.sectionTitle;
    if (this.subSections != null) {
      data['sub_sections'] = this.subSections?.map((v) => v.toJson()).toList();
    }
    data['counter'] = this.counter;
    return data;
  }
}

class SubSections {
  String? question;
  String? answer;
  int? innerCounter;
  bool? isExpanded = false;

  SubSections({this.question, this.answer, this.innerCounter, this.isExpanded});

  SubSections.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    innerCounter = json['inner_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['inner_counter'] = this.innerCounter;
    return data;
  }
}
