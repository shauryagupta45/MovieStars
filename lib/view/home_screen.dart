import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_stars/utils/routes/routes_name.dart';
import 'package:movie_stars/utils/utils.dart';
import 'package:movie_stars/view_model/home_view_model.dart';
import 'package:movie_stars/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchMoviesListApi();
  }

  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Home Screen'), centerTitle: true, actions: [
          InkWell(
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
        ]),
        body: ChangeNotifierProvider<HomeViewViewModel>(
          create: (BuildContext context) => homeViewViewModel,
          child: Consumer<HomeViewViewModel>(builder: (context, value, child) {
            switch (value.moviesList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Text(value.moviesList.message.toString());
              case Status.COMPLETED:
                return MovieListView(value);

              case null:
                return Text(value.moviesList.message.toString());
            }
            return Container();
          }),
        ));
  }

  ListView MovieListView(HomeViewViewModel value) {
    return ListView.builder(
        itemCount: value.moviesList.data!.movies!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(
                value.moviesList.data!.movies![index].posterurl.toString(),
                errorBuilder: (context, error, stack) {
                  return const Icon(
                    Icons.no_photography_outlined,
                    color: Colors.red,
                  );
                },
                height: 40,
                width: 40,
              ),
              title:
                  Text(value.moviesList.data!.movies![index].title.toString()),
              subtitle:
                  Text(value.moviesList.data!.movies![index].year.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(Utils.averageRating(
                          value.moviesList.data!.movies![index].ratings!)
                      .toStringAsFixed(1)),
                  Icon(Icons.star, color: Colors.yellow[700]),
                ],
              ),
            ),
          );
        });
  }
}
