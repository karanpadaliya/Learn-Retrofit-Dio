import 'package:flutter/material.dart';
import 'package:learn_retrofit_dio/models/create_user/create_user_request_model.dart';

import '../../config/user_repository.dart';

class CreateUserDialog extends StatefulWidget {
  // final Function(String name, String job) onSubmit;

  const CreateUserDialog({Key? key}) : super(key: key);

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter name'
                          : null,
            ),
            TextFormField(
              controller: _jobController,
              decoration: const InputDecoration(labelText: 'Job'),
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Please enter job'
                          : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              UserRepository.userRepository.createUser(
                _nameController.text.trim(),
                _jobController.text.trim(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
