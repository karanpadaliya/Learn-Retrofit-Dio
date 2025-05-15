import 'package:dio/dio.dart';
import 'package:learn_retrofit_dio/models/models.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_list_model.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://reqres.in/')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @GET('api/users?page=2')
  Future<UserList> getUserList();

  @GET('api/users/{id}')
  @Header('{"x-api-key": "reqres-free-v1"}')
  Future<SingleUserModel> getSingleUser(@Path('id') String id);

  @POST('api/users')
  Future<CreateUserShowModel> createUser(
    @Header('x-api-key') String apiKey,
    @Body() CreateUserRequestModel request,
  );
}
