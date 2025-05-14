import 'package:dio/dio.dart';
import 'package:learn_retrofit_dio/models/user_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://reqres.in/')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET('api/users?page=2')
  Future<UserList> getUserList();

  //* ID pass in URL
  // @POST('/api/users/2/{id}')
  // Future<dynamic> getSingleUser(@Path('id') String id);

  @POST('/api/users/2/{id}')
  Future<dynamic> getSingleUser(@Path('id') String id);
}
