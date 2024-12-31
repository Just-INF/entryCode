import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:test_project/http/account/auth_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

final String baseUrl = "http://localhost:5000";
final storage = FlutterSecureStorage();

Future<bool> editUserName(String newUserName) async {
  String oldUserName = (await getData())?['username'];

  final response = await http.post(
    Uri.parse('$baseUrl/edit/username'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'oldUserName': oldUserName,
      'newUserName': newUserName,
    }),
  );

  if (response.statusCode == 200) {
    logout();

    final responseData = json.decode(response.body);
    await storage.write(key: 'jwt', value: responseData['newToken']);
    return true;
  } else {
    throw Exception(jsonDecode(response.body));
  }
}

//Image Pick Service
class ImagePickerService {
  static Future<PickedFile?> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        if (kIsWeb) {
          // Handle web case: return bytes instead of a file path
          Uint8List? fileBytes = result.files.first.bytes;
          String fileName = result.files.first.name;
          return PickedFile(bytes: fileBytes, name: fileName);
        } else {
          // Handle other platforms: return file path
          //return PickedFile(result.files.single.path!);
        }
      } else {
        // User canceled the picker
        return null;
      }
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}

class PickedFile {
  final Uint8List? bytes;  // Used for web
  final String? path;      // Used for mobile/desktop
  final String name;

  PickedFile({this.bytes, this.path, required this.name});
}