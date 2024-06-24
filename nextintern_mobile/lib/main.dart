import 'package:flutter/material.dart';
import 'package:nextintern_mobile/screens/auth_screen.dart';
import 'package:nextintern_mobile/widgets/bottom_navbar.dart';
import 'package:nextintern_mobile/services/auth_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextIntern Mobile',
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return snapshot.data == true ? const BottomNavbar() : const AuthScreen();
          }
        },
      ),
    );
  }
}
