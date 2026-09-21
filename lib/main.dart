import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/gallery_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "",
        authDomain: "image-crud-da52a.firebaseapp.com",
        projectId: "image-crud-da52a",
        storageBucket: "image-crud-da52a.firebasestorage.app",
        messagingSenderId: "405122595450",
        appId: "1:405122595450:web:a6536521d36d7ba4b719c3",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const PixelVaultApp());
}

class PixelVaultApp extends StatelessWidget {
  const PixelVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PixelVault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),
      home: const GalleryListScreen(),
    );
  }
}
