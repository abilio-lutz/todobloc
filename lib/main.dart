import 'package:flutter/material.dart';
import 'package:todobloc/repos/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/blocs/app_blocs.dart';

import 'blocs/app_events.dart';
import 'blocs/app_states.dart';
import 'detail_screen.dart';
import 'models/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()), // UserBloc
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The BloC App'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              e: userList[index],
                            ),
                          ));
                        },
                        child: Card(
                          color: Colors.blue,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            title: Text(
                              userList[index].firstname,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              userList[index].lastname,
                              style: const TextStyle(color: Colors.white),
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: NetworkImage(userList[index].avatar),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }

            if (state is UserErrorState) {
              String error = state.error;
              return Center(child: Text('Error: $error'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
