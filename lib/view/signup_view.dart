import 'package:flutter/material.dart';
import 'package:movie_stars/resources/components/roundButton.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/view/home_screen.dart';
import 'package:movie_stars/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  ValueNotifier<bool> _obscurePass = ValueNotifier(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode =
      FocusNode(); // This will help in way such that, whenever we tap on done/enter on keyboard after writing email. It doesn't remove the cursor, but put the cursor to 'Password section'
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
  }

  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode:
                  emailFocusNode, //It brings up a keyboard, which explicitly shows '@' sign on it. You don't have to search around for it.
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.grey)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 3.0)),
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(context, emailFocusNode, passFocusNode);
              },
            ), // Email
            ValueListenableBuilder(
                valueListenable: _obscurePass,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passController,
                    obscureText: _obscurePass.value,
                    obscuringCharacter: '*',
                    focusNode: passFocusNode,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline_sharp),
                        suffixIcon: InkWell(
                          onTap: () {
                            _obscurePass.value = !_obscurePass.value;
                          },
                          child: Icon(_obscurePass.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.grey)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0)),
                  );
                }),
            //Pass,
            SizedBox(height: height * .1),
            RoundButton(
              title: 'Sign Up',
              loading: authViewMode.signUpLoading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter Email', context);
                } else if (_passController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Please enter Password', context);
                } else if (_passController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Please Enter a password of atleast 6 characters',
                      context);
                } else {
                  Map data = {
                    'email': _emailController.text.toString(),
                    'password': _passController.text.toString(),
                  };
                  authViewMode.signUpApi(data, context);
                  print("Api Hit");
                }
              },
            ),
            SizedBox(height: height * 0.005),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.login);
              },
              child: const Text("Already have an account ? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
