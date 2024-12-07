import 'package:dartz/dartz.dart';
import 'package:shoelaundry/data/datasources/auth_local_datasource.dart';
import 'package:shoelaundry/data/models/request/register_request_model.dart';
import 'package:shoelaundry/data/models/response/register_response_model.dart';

import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      print("masukk ::: ${response.body}");
      return right(AuthResponseModel.fromJson(response.body));

    } else {
      return left(response.body);
    }
  }

  Future<Either<String, RegisterResponModel>> register(
      RegisterRequestModel registerRequestModel,
      [image]) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/register'));
    request.fields.addAll(registerRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', registerRequestModel.image!.path));
    http.StreamedResponse response = await request.send();
    final String body = await response.stream.bytesToString();
    print(body);
    if (response.statusCode == 201) {
      print(body);
      return right(RegisterResponModel.fromJson(body));
    } else {
      return left(body);
    }
  }

  Future<Either<String, RegisterResponModel>> updateUser(
      RegisterRequestModel registerRequestModel,
      [image]) async {
    final authData = await AuthLocalDatasource().getAuthData();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variables.baseUrl}/api/update-profile/${authData.user.id}'),
    );
    request.headers['Authorization'] = 'Bearer ${authData.token}';
    request.fields.addAll(registerRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', registerRequestModel.image!.path));
    http.StreamedResponse response = await request.send();
    final String body = await response.stream.bytesToString();
    print(body);
    if (response.statusCode == 200) {
      print(body);
      return Right(RegisterResponModel.fromJson(body));
    } else {
      return left(body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );
    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }
}
