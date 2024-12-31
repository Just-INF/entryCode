import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final String baseUrl = "http://localhost:5000";
final storage = FlutterSecureStorage();

//Registration
Future<String> sendEmailRegister(String userEmail) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userEmail': userEmail,
    }),
  );
  
  if (response.statusCode == 201) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String pin = responseData['pin'];
    return pin; 
  } else {
    throw Exception(jsonDecode(response.body));
  }
}

Future<bool> createAccount(String userEmail,String username, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/createAccount'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userEmail': userEmail,
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    // Handle error
    throw Exception(jsonDecode(response.body));
  }
}


//Forgot Password
Future<String> sendEmailForgot(String userEmail) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/forgor'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userEmail': userEmail,
    }),
  );

  if (response.statusCode == 201) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String pin = responseData['pin'];
    return pin; 
  } else {
    throw Exception(jsonDecode(response.body));
  }
}

//Recover Account
Future<bool> recoverAccount(String userEmail, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/recover'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userEmail': userEmail,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    // Handle error
    throw Exception(jsonDecode(response.body));
  }
}

//Login
Future<bool> authLogin(String userInput, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'identifier': userInput,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    await storage.write(key: 'jwt', value: responseData['token']);
    return true;
  } else {
    throw Exception('Failed to login');
  }
}

//Get Uesr Info
Future<void> displayUserInfo() async {
  try {
    String? token = await getToken(); // Retrieve the token
    if (token == null) {
      throw Exception('Token not found.');
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // Access token data, ensuring correct type casting
    String? username = decodedToken['username'] as String?;
    String? email = decodedToken['email'] as String?;
    int? userId = decodedToken['id'] as int?; // Example for int type

    print('Username: $username');
    print('Email: $email');
    print('User ID: $userId');
  } catch (e) {
    print('Error decoding token: $e');
  }
}

//Get Decoded Jwt
Future<Map<String, dynamic>?> getData() async {
  try {
    String? token = await getToken(); // Retrieve the token
    if (token == null) {
      throw Exception('Token not found.');
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken;
  } catch (e) {
    print('Error decoding token: $e');
    return null; // Return null or an empty map based on your use case
  }
}



Future<String?> getToken() async {
  return await storage.read(key: 'jwt');
}

Future<void> logout() async {
  await storage.delete(key: 'jwt');
}




/*
class AuthService {
  final String baseUrl = "http://localhost:5000";
  final storage = FlutterSecureStorage();

  //AuthService(this.baseUrl);

  Future<void> sendEmail(String userEmail) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userEmail': userEmail,
      }),
    );

    if (response.statusCode == 201) {
      // Successful registration
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String pin = responseData['pin'];
      print("Received PIN: $pin");
      // Handle the PIN (e.g., display it to the user or save it)
    } else {
      // Handle error
      throw Exception('Failed to register');
    }
  }
  /*Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }*/

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      await storage.write(key: 'jwt', value: responseData['token']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwt');
  }
}
*/