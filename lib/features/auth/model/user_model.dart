import 'dart:developer';

class UserModel {
  User? user;
  String? accessToken;

  UserModel({this.user, this.accessToken});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    log(json.toString());
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['accessToken'] = accessToken;
    return data;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? picturePath;
  List<String>? friends;
  String? location;
  String? occupation;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.picturePath,
      this.friends,
      this.location,
      this.occupation,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    picturePath = json['picturePath'];
    friends = json['friends'].cast<String>();
    location = json['location'];
    occupation = json['occupation'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['picturePath'] = picturePath;
    data['friends'] = friends;
    data['location'] = location;
    data['occupation'] = occupation;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
