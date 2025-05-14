import 'package:flutter/material.dart';
import 'package:learn_retrofit_dio/models/user_list_model.dart';
import 'package:learn_retrofit_dio/network/injection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserList userList = UserList();
  bool isLoading = true;

  fetchList() {
    apiServices
        .getUserList()
        .then((value) {
          setState(() {
            isLoading = false;
            userList = value;
          });
        })
        .onError((error, stackTrace) {
          print('Error==> ${error}');
        });
  }

  @override
  void initState() {
    fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit API')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: userList.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(userList.data![index].id.toString()),
                    ),
                    title: Text(userList.data![index].firstName.toString()),
                    subtitle: Text(userList.data![index].email.toString()),
                  );
                },
              ),
    );
  }
}
