import 'package:flutter/material.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/view_model/user_view_model.dart';

import '../../model/UserModel.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      print(value
          .token); //since this is coming out as string in the console, in " if " condition, we compare value.token == "null", since default value is null in string form
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {});
  }
}
