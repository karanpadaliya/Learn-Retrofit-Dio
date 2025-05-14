import 'package:flutter/material.dart';
import 'package:learn_retrofit_dio/config/user_repository.dart';
import 'package:learn_retrofit_dio/models/user_list_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserList userList = UserList();
  bool isLoading = true;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    userRepository.fetchAllUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit API')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: userRepository.fetchAllUserList,
                child: ListView.builder(
                  itemCount: userList.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index != 0) {
                          userRepository.apiServices.getSingleUser("$index");
                        }
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userList.data![index].avatar.toString(),
                          ),
                        ),
                        title: Text(userList.data![index].firstName.toString()),
                        subtitle: Text(userList.data![index].email.toString()),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
