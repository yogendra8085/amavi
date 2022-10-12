class CityListModel {
  String? countryId;
  String? name;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  String? postcodeRequired;
  List<Zone>? zone;
  String? status;

  CityListModel(
      {this.countryId,
      this.name,
      this.isoCode2,
      this.isoCode3,
      this.addressFormat,
      this.postcodeRequired,
      this.zone,
      this.status});

  CityListModel.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormat = json['address_format'];
    postcodeRequired = json['postcode_required'];
    if (json['zone'] != null) {
      zone = <Zone>[];
      json['zone'].forEach((v) {
        zone?.add(new Zone.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['iso_code_2'] = this.isoCode2;
    data['iso_code_3'] = this.isoCode3;
    data['address_format'] = this.addressFormat;
    data['postcode_required'] = this.postcodeRequired;
    if (this.zone != null) {
      data['zone'] = this.zone?.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Zone {
  String? zoneId;
  String? countryId;
  String? name;
  String? code;
  String? status;
  String? arName;

  Zone(
      {this.zoneId,
      this.countryId,
      this.name,
      this.code,
      this.status,
      this.arName});

  Zone.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
    status = json['status'];
    arName = json['ar_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_id'] = this.zoneId;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['status'] = this.status;
    data['ar_name'] = this.arName;
    return data;
  }
}
