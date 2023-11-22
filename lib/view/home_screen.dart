import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            userPref.remove().then((value) {
              Navigator.pushNamed(context, RoutesName.login);
            }).onError((error, stackTrace) {
              if (kDebugMode) {
                print(error.toString());
              }
            });
          },
          child: const Row(
            children: [
              Text('Logout'),
              Icon(Icons.logout),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
