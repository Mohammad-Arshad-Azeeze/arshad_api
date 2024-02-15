import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));
String dataModelToJson(DataModel data) => json.encode(data.toJson());
class DataModel {
  DataModel({
      this.id, 
      this.title, 
      this.description, 
      this.imgLink, 
      this.email,});

  DataModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    imgLink = json['img_link'];
    email = json['email'];
  }
  num? id;
  String? title;
  String? description;
  String? imgLink;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['img_link'] = imgLink;
    map['email'] = email;
    return map;
  }

}