import 'package:flutter/material.dart';
import 'package:learn_retrofit_dio/models/fetch_user_model/fetch_single_user_model.dart';
import 'package:learn_retrofit_dio/config/user_repository.dart';

class UserDetailsShowDialog extends StatelessWidget {
  final String userId;

  const UserDetailsShowDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    UserRepository userRepo = UserRepository.userRepository;
    return FutureBuilder<SingleUserModel>(
      future: userRepo.singleUserDetails(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            title: Text('Loading User...'),
            content: SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load user details.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          final userDetails = snapshot.data!;
          return AlertDialog(
            title: Text(
              '${userDetails.data?.firstName ?? "No_FirstName"} ${userDetails.data?.lastName ?? "No_LastName"}',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    userDetails.data?.avatar ?? "No_ProfilePhoto",
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text('Email: ${userDetails.data?.email ?? "No_Email"}'),
                SizedBox(height: 10),
                Text('ID: ${userDetails.data?.id ?? "No_ID"}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
