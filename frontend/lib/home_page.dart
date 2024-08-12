import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'services/image_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageService = Provider.of<ImageService>(context);

    return Scaffold(
      appBar: AppBar(
        // leading: ImageIcon(),
        title: const Text('Ecolens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageService.image != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Image.file(imageService.image!))
                : const Text('No image selected.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => imageService.pickImage(ImageSource.camera),
              child: const Text('Capture from Camera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => imageService.pickImage(ImageSource.gallery),
              child: const Text('Select from Gallery'),
            ),
            const SizedBox(height: 20),
            imageService.isLoading
                ? const CircularProgressIndicator() // Show progress indicator while loading
                : Text(imageService.recommendations,
                    textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
