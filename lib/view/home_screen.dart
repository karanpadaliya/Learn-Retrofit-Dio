import 'package:flutter/material.dart';
import 'package:learn_retrofit_dio/config/user_repository.dart';
import 'package:learn_retrofit_dio/models/user_list_model.dart';
import 'widget/user_details_dialog.dart';

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
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedList = await userRepository.fetchAllUserList();
    setState(() {
      userList = fetchedList;
      isLoading = false;
    });
  }

  void showUserDetails(String userId) {
    showDialog(
      context: context,
      builder: (context) => UserDetailsDialog(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit API')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: fetchUsers,
                child: ListView.builder(
                  itemCount: userList.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = userList.data![index];
                    return InkWell(
                      onTap: () {
                        showUserDetails(user.id.toString());
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar.toString()),
                        ),
                        title: Text(user.firstName.toString()),
                        subtitle: Text(user.email.toString()),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
