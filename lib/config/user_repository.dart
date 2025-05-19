import 'package:flutter/material.dart';
import '/models/models.dart';
import '../models/fetch_user_model/fetch_all_user_list_model.dart';
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
      final singleInfo = await apiServices.getSingleUser(
        'reqres-free-v1',
        userId,
      );
      return singleInfo;
    } catch (error) {
      print('Error fetching single user details: $error');
      rethrow;
    }
  }

  // Create user
  Future<CreateUserShowModel> createUser(String name, String job) async {
    try {
      final createUser = await apiServices.createUser(
        'reqres-free-v1',
        CreateUserRequestModel(name: name, job: job),
      );
      return createUser;
    } catch (error) {
      Text('Failed to register user. Error: $error');
      rethrow;
    }
  }
}
