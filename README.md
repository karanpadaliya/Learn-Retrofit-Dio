<h1>🚀 Flutter Retrofit + Dio API Integration Guide</h1>

<p>This project demonstrates how to use <strong>Retrofit</strong> and <strong>Dio</strong> in a Flutter app for making clean and scalable API requests. This guide is beginner-friendly and covers all necessary steps including GET, POST, PUT, DELETE, PATCH, and Query Parameters usage.</p>

<hr>

<h2>🔧 Step 1: Add Dependencies</h2>
Add the generator to your dev dependencies

```yaml
dependencies:
  retrofit: ^x.x.x
  dio: ^x.x.x

dev_dependencies:
   retrofit_generator: ^x.x.x
  build_runner: ^x.x.x
```
<hr>

<h2>📁 Step 2: Create <code>api_services.dart</code></h2>

```dart
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
```

<hr>

<h2>🧠 Step 3: Create Model & Injection</h2>

<h3>📌 1. Generate Model</h3>
<p>Use this tool to convert JSON to Dart: <a href="https://javiercbk.github.io/json_to_dart/" target="_blank">Json to Dart Converter</a></p>

<h3>📌 2. Create <code>injection.dart</code></h3>

  ```dart
import 'package:dio/dio.dart';
import 'package:learn_retrofit_dio/network/api_services.dart';

final apiServices = ApiServices(Dio());
```

<hr>

<h2>⚙️ Step 4: Generate <code>.g.dart</code> File</h2>
<pre><code>dart pub run build_runner build</code></pre>

<hr>

<h2>🖥️ Step 5: Display API Data in Flutter</h2>
<pre><code>

```dart
import 'package:flutter/material.dart';
import '../models/fetch_user_model/fetch_all_user_list_model.dart';
import '/config/config.dart';
import 'widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserList userList = UserList();
  bool isLoading = true;
  UserRepository userRepo = UserRepository.userRepository;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedList = await userRepo.fetchAllUserList();
    setState(() {
      userList = fetchedList;
      isLoading = false;
    });
  }

  void showUserDetails(String userId) {
    showDialog(
      context: context,
      builder: (context) => UserDetailsShowDialog(userId: userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retrofit API')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child:
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                        onRefresh: userRepo.fetchAllUserList,
                        child: ListView.builder(
                          itemCount: userList.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final user = userList.data![index];
                            return InkWell(
                              onTap: () {
                                showUserDetails(user.id.toString());
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user.avatar.toString(),
                                  ),
                                ),
                                title: Text(user.firstName.toString()),
                                subtitle: Text(user.email.toString()),
                              ),
                            );
                          },
                        ),
                      ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CreateUserDialog(),
                    );
                  },
                  child: Text('Create User'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

</code></pre>

<hr>

<h2>📡 API Services Examples</h2>

<h3>✅ 1. GET Request (List of Users)</h3>

```dart
@GET('api/users')
Future&lt;UserList&gt; getUserList(@Query('page') int page);

// Usage:
final userList = await apiServices.getUserList(2);
```

<h3>✅ 2. GET Request with Path Param (Single User)</h3>
  
```dart  
@GET('api/users/{id}')
Future&lt;dynamic&gt; getSingleUser(@Path('id') String id);

// Usage:
final user = await apiServices.getSingleUser('2');
```

<h3>✅ 3. POST Request (Create User)</h3>
  
```dart  
@POST('api/users')
Future&lt;dynamic&gt; createUser(@Body() Map&lt;String, dynamic&gt; body);

// Usage:
final response = await apiServices.createUser({
  'name': 'John Doe',
  'job': 'Developer',
});
```

<h3>✅ 4. PUT Request (Full Update)</h3>

```dart
@PUT('api/users/{id}')
Future&lt;dynamic&gt; updateUser(@Path('id') String id, @Body() Map&lt;String, dynamic&gt; body);

// Usage:
final response = await apiServices.updateUser('2', {
  'name': 'Jane Doe',
  'job': 'Manager',
});
```

<h3>✅ 5. PATCH Request (Partial Update)</h3>

```dart
@PATCH('api/users/{id}')
Future&lt;dynamic&gt; patchUser(@Path('id') String id, @Body() Map&lt;String, dynamic&gt; body);

// Usage:
final response = await apiServices.patchUser('2', {
  'job': 'Lead Developer',
});
```

<h3>✅ 6. DELETE Request</h3>

```dart
@DELETE('api/users/{id}')
Future&lt;dynamic&gt; deleteUser(@Path('id') String id);

// Usage:
final response = await apiServices.deleteUser('2');
```

<h3>✅ 7. GET with Multiple Query Parameters</h3>

```dart  
@GET('api/users')
Future&lt;UserList&gt; getUserListWithQuery(@Queries() Map&lt;String, dynamic&gt; queries);

// Usage:
final userList = await apiServices.getUserListWithQuery({
  'page': 2,
  'per_page': 5,
});
```
<hr>

<h2>🎯 Summary</h2>
<ul>
  <li>✅ Retrofit makes HTTP API calls easier and cleaner in Flutter.</li>
  <li>✅ Dio handles network operations efficiently with options for logging, interceptors, and more.</li>
  <li>✅ You can handle GET, POST, PUT, PATCH, DELETE, and use Query/Path parameters using Retrofit decorators.</li>
</ul>

<p><strong>⭐ Happy Coding!</strong></p>
