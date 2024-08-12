import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'services/image_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EcoLens',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
      ),
    );
  }
}
