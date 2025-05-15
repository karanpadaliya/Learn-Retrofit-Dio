import 'package:dio/dio.dart';
import 'package:learn_retrofit_dio/models/models.dart';
import 'package:retrofit/retrofit.dart';
import '../models/fetch_user_model/fetch_all_user_list_model.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: 'https://reqres.in/')
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  // Fetch all user
  @GET('api/users?page=2')
  Future<UserList> getUserList();

  // Fetch single user
  @GET('api/users/{id}')
  Future<SingleUserModel> getSingleUser(
    @Header('x-api-key') String apiKey,
    @Path('id') String id,
  );

  // Create a user
  @POST('api/users')
  Future<CreateUserShowModel> createUser(
    @Header('x-api-key') String apiKey,
    @Body() CreateUserRequestModel request,
  );
}
