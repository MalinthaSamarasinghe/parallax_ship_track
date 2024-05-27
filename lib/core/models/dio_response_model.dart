// To parse this JSON data, do
//
//     final dioResponseModel = dioResponseModelFromJson(jsonString);

import 'dart:convert';

DioResponseModel dioResponseModelFromJson(String str) => DioResponseModel.fromJson(json.decode(str));

String dioResponseModelToJson(DioResponseModel data) => json.encode(data.toJson());

class DioResponseModel {
  DioResponseModel({
    this.statusCode,
    this.message,
    this.errors,
  });

  final int? statusCode;
  final String? message;
  final Errors? errors;

  factory DioResponseModel.fromJson(Map<String, dynamic> json) =>
      DioResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        errors: json["errors"] == null
            ? null
            : json["errors"].isEmpty
                ? null
                : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "errors": errors?.toJson(),
      };
}

class Errors {
  Errors({
    this.email,
    this.contactNumber,
    this.name,
    this.firebaseUid,
    this.invalidCredentials,
    this.passwordIsAlreadyReset,
    this.password,
    this.invalidDefaultPassword,
  });

  final List<String>? email;
  final List<String>? contactNumber;
  final List<String>? name;
  final List<String>? firebaseUid;
  final List<String>? invalidCredentials;
  final List<String>? passwordIsAlreadyReset;
  final List<String>? password;
  final List<String>? invalidDefaultPassword;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? null
            : List<String>.from(json["email"].map((x) => x)),
        contactNumber: json["contact_number"] == null
            ? null
            : List<String>.from(json["contact_number"].map((x) => x)),
        name: json["name"] == null
            ? null
            : List<String>.from(json["name"].map((x) => x)),
        firebaseUid: json["firebase_uid"] == null
            ? null
            : List<String>.from(json["firebase_uid"].map((x) => x)),
        invalidCredentials: json["invalid_credintials"] == null
            ? null
            : List<String>.from(json["invalid_credintials"].map((x) => x)),
        passwordIsAlreadyReset: json["password_is_already_reset"] == null
            ? null
            : List<String>.from(json["password_is_already_reset"].map((x) => x)),
        password: json["password"] == null
            ? null
            : List<String>.from(json["password"].map((x) => x)),
        invalidDefaultPassword: json["invalid_credentials"] == null
            ? null
            : List<String>.from(json["invalid_credentials"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from((email ?? []).map((x) => x)),
        "contact_number": List<dynamic>.from((contactNumber ?? []).map((x) => x)),
        "name": List<dynamic>.from((name ?? []).map((x) => x)),
        "firebase_uid": List<dynamic>.from((firebaseUid ?? []).map((x) => x)),
        "invalid_credintials": List<String>.from((invalidCredentials ?? []).map((x) => x)),
        "password_is_already_reset": List<String>.from((passwordIsAlreadyReset ?? []).map((x) => x)),
        "password": List<String>.from((password ?? []).map((x) => x)),
        "invalid_credentials": List<String>.from((invalidDefaultPassword ?? []).map((x) => x)),
      };
}
