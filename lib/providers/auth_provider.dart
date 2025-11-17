import 'package:flutter/cupertino.dart';
import 'package:shoppify/models/user_model.dart';
import 'package:shoppify/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  bool isLoading = false;

  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();
    user = await AuthService.login(email: email, password: password);
    isLoading = false;
    notifyListeners();
    return user != null && user?.customerId != -1 ? true : false;
  }

  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required String contact,
  }) async {
    isLoading = true;
    notifyListeners();
    user = await AuthService.signUp(
      email: email,
      password: password,
      name: name,
      contact: contact,
    );
    isLoading = false;
    notifyListeners();
    return user != null && user?.customerId != -1 ? true : false;
  }
}
