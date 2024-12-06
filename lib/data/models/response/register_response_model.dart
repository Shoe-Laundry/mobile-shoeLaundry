// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterResponModel {
  final bool? success;
  final String? message;
  final Data? data;

  RegisterResponModel({
    this.success,
    this.message,
    this.data,
  });

  factory RegisterResponModel.fromJson(String str) =>
      RegisterResponModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final String? name;
  final String? email;
  final String? image;
  final String? phone;
  final String? roles;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Data({
    this.name,
    this.email,
    this.image,
    this.phone,
    this.roles,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        image: json["image"],
        phone: json["phone"],
        roles: json["roles"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "image": image,
        "roles": roles,
        "phone": phone,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
