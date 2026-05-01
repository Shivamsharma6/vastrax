import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC_placeholder',
      appId: '1:placeholder:web',
      messagingSenderId: 'placeholder',
      projectId: 'vastrax',
    ),
  );
  
  runApp(const VastraxApp());
}
