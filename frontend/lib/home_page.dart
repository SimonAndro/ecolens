import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: imageService.image != null
                      ? Image.file(imageService.image!)
                      : const Text('No image selected.')),
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
                  : Scrollbar(
                      child: SingleChildScrollView(
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child:
                                Markdown(data: imageService.recommendations)),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
