// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  bool? success;
  int? statusCode;
  String? code;
  String? message;
  Data? data;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        success: json["success"],
        statusCode: json["statusCode"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.id,
    this.email,
    this.nicename,
    this.firstName,
    this.lastName,
    this.displayName,
    this.userRole,
  });

  String? token;
  int? id;
  String? email;
  String? nicename;
  String? firstName;
  String? lastName;
  String? displayName;
  List<String>? userRole;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        id: json["id"],
        email: json["email"],
        nicename: json["nicename"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        displayName: json["displayName"],
        userRole: List<String>.from(json["user_role"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "id": id,
        "email": email,
        "nicename": nicename,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": displayName,
        "user_role": List<dynamic>.from(userRole!.map((x) => x)),
      };
}
