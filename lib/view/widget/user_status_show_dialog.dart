import 'package:flutter/material.dart';

import '../../models/models.dart';

class UserStatusDialog extends StatelessWidget {
  final CreateUserShowModel? user;
  final String? error;

  const UserStatusDialog({super.key, this.user, this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(error == null ? 'User Registered Successfully!' : 'Registration Failed'),
      content: error == null
          ? Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ID: ${user?.id}'),
          Text('Name: ${user?.name}'),
          Text('Job: ${user?.job}'),
          Text('Created At: ${user?.createdAt}'),
        ],
      )
          : Text(error ?? 'Unknown error occurred.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
