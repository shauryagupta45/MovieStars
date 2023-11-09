import 'package:flutter/material.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/view/home_screen.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            Utils.toastMessage("No internet connection");
            // Navigator.pushNamed(context, RoutesName.home);
            // // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen())) ;
          },
          child: const Text('Home Screen '),
        ),
      ),
    );
  }
}
