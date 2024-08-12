import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageService extends ChangeNotifier {
  final String apiUrl = 'http://10.0.2.2:3000/upload-image';

  File? _image;
  String _recommendations = '';
  bool _isLoading = false;

  File? get image => _image;

  String get recommendations => _recommendations;

  bool get isLoading => _isLoading;

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _recommendations = '';
      notifyListeners();
      await uploadImage(); // Start uploading the image right after picking it
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..files.add(await http.MultipartFile.fromPath('file', _image!.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print(responseBody);

      if (response.statusCode == 200) {
        _recommendations = responseBody;
      } else {
        _recommendations = 'Failed to get recommendations';
      }
    } catch (e) {
      print(e);
      _recommendations = 'Error uploading image';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
