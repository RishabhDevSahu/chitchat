import 'dart:collection';

class MobileNumberModel {
  int? _id;
  String? _country_code;
  String? _mobile_number;
  String? _date;

  MobileNumberModel(
      this._country_code, this._mobile_number, this._date);

  MobileNumberModel.name(
      this._id, this._country_code, this._mobile_number, this._date);

  String get date => _date ?? '';

  set date(String value) {
    _date = value;
  }

  String get mobile_number => _mobile_number ?? '';

  set mobile_number(String value) {
    _mobile_number = value;
  }

  String get country_code => _country_code ?? '';

  set country_code(String value) {
    _country_code = value;
  }

  int get id => _id ?? 0;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = this._id;
    }
    map['country_code'] = this._country_code;
    map['mobile_number'] = this._mobile_number;
    map['date'] = this._date;

    return map;
  }

  MobileNumberModel.fromMapObject(Map<String,dynamic> map){
    _id = map['id']!;
    _country_code = map['country_code']!;
    _mobile_number = map['mobile_number']!;
    _date = map['date']!;
  }

}


