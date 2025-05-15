import 'package:flutter/material.dart';
import '../../config/user_repository.dart';
import 'widget.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key});

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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                final createUserData = await UserRepository.userRepository
                    .createUser(
                      _nameController.text.trim(),
                      _jobController.text.trim(),
                    );
                if (context.mounted) Navigator.pop(context);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return UserStatusDialog(user: createUserData);
                    },
                  );
                }
              } catch (error) {
                if (context.mounted) Navigator.pop(context);
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return UserStatusDialog(error: error.toString());
                    },
                  );
                }
              }
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
