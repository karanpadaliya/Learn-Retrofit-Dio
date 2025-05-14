import '../models/single_user_model.dart';
import '../models/user_list_model.dart';
import '../network/api_services.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final ApiServices apiServices = ApiServices(Dio());

  Future<UserList> fetchAllUserList() async {
    try {
      final userList = await apiServices.getUserList();
      return userList;
    } catch (error) {
      print('Error fetching user list: $error');
      rethrow;
    }
  }

  Future<SingleUserModel> singleUserDetails(String userId) async {
    try {
      final singleInfo = await apiServices.getSingleUser(userId);
      return singleInfo;
    } catch (error) {
      print('Error fetching single user details: $error');
      rethrow;
    }
  }
}
