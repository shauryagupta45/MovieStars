import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_stars/repositories/auth_repository.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepo();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      Utils.flushBarErrorMessage('Login Successful', context);
      if (kDebugMode) {
        print(value.toString());
      }
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
      setLoading(false);
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value) {
      Utils.flushBarErrorMessage('SignUp Successful', context);
      if (kDebugMode) {
        print(value.toString());
      }
      setSignUpLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
      setSignUpLoading(false);
    });
  }
}
