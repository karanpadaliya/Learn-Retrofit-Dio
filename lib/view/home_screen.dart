import 'package:flutter/material.dart';
import '../models/fetch_user_model/fetch_all_user_list_model.dart';
import '/config/config.dart';
import 'widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserList userList = UserList();
  bool isLoading = true;
  UserRepository userRepo = UserRepository.userRepository;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedList = await userRepo.fetchAllUserList();
    setState(() {
      userList = fetchedList;
      isLoading = false;
    });
  }

  void showUserDetails(String userId) {
    showDialog(
      context: context,
      builder: (context) => UserDetailsShowDialog(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit API')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child:
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                        onRefresh: userRepo.fetchAllUserList,
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
                                  backgroundImage: NetworkImage(
                                    user.avatar.toString(),
                                  ),
                                ),
                                title: Text(user.firstName.toString()),
                                subtitle: Text(user.email.toString()),
                              ),
                            );
                          },
                        ),
                      ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateUserDialog(),
                    );
                  },
                  child: Text('Create User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
