class CreateUserRequestModel {
  final String name;
  final String job;

  CreateUserRequestModel({required this.name, required this.job});

  Map<String, dynamic> toJson() => {
    'name': name,
    'job': job,
  };
}
