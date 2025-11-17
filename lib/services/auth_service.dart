import 'package:dio/dio.dart';
import 'package:shoppify/models/user_model.dart';

class AuthService {
  static Dio dio = Dio();

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        "https://ecommerceflutter.runasp.net/api/Customer/login",
        data: {"email": email, "password": password},
      );
      return UserModel.fromJson(json: response.data);
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError.toString());
    }
  }

  static Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String contact,
  }) async {
    try {
      Response response = await dio.post(
        "https://ecommerceflutter.runasp.net/api/Customer/signup",
        data: {
          "email": email,
          "password": password,
          "name": name,
          "contact": contact,
        },
      );
      return UserModel.fromJson(json: response.data);
    } on DioException catch (dioError) {
      throw Exception(dioError.message);
    } catch (otherError) {
      throw Exception(otherError.toString());
    }
  }
}
