import '/models/models.dart';
import '../models/user_list_model.dart';
import '../network/api_services.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final ApiServices apiServices = ApiServices(Dio());


  // Private constructor to prevent outside creation
  UserRepository._();

  // Singleton instance
  static final UserRepository userRepository = UserRepository._();


  // Fetch all the users
  Future<UserList> fetchAllUserList() async {
    try {
      final userList = await apiServices.getUserList();
      return userList;
    } catch (error) {
      print('Error fetching user list: $error');
      rethrow;
    }
  }

  // Fetch single user details
  Future<SingleUserModel> singleUserDetails(String userId) async {
    try {
      final singleInfo = await apiServices.getSingleUser(userId);
      return singleInfo;
    } catch (error) {
      print('Error fetching single user details: $error');
      rethrow;
    }
  }

  // Create user
  Future<CreateUserModel> createUser(String name, String job) async {
    try {
      final createUser = await apiServices.createUser(
        'reqres-free-v1',
        CreateUserRequest(name: name, job: job),
      );
      print("createUser:.-----------------------${createUser.id}");
      print("createUser:.-----------------------${createUser.name}");
      print("createUser:.-----------------------${createUser.job}");
      print("createUser:.-----------------------${createUser.createdAt}");
      return createUser;
    } catch (error) {
      print('Error fetching single user details: $error');
      rethrow;
    }
  }
}
