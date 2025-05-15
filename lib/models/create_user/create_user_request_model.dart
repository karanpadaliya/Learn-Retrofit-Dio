class CreateUserRequest {
  final String name;
  final String job;

  CreateUserRequest({required this.name, required this.job});

  Map<String, dynamic> toJson() => {
    'name': name,
    'job': job,
  };
}
