// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class RegisterRequestModel {
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final XFile? image;
  final String? roles;
  RegisterRequestModel({
    this.roles,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'phone': phone ?? '',
      'roles': roles ?? '',
    };
  }
}
