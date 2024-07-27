import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nextintern_mobile/screens/setting_screen.dart';
import 'package:nextintern_mobile/widgets/appbar_icons.dart';

class GradientAppBar extends StatelessWidget {
  final List<Color> gradientColors;
  final String title;
  final Color titleColor;
  final TextStyle titleTextStyle;

  const GradientAppBar({
    this.gradientColors = const [Color(0xFF08F8B3), Color(0xFF4B39EF)],
    required this.title,
    this.titleColor = Colors.white,
    this.titleTextStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleTextStyle.copyWith(color: titleColor),
      ),
      backgroundColor: Colors.transparent, // Make AppBar background transparent
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: const AlignmentDirectional(
                1, -0.87), // Adjust alignment as needed
            end: const AlignmentDirectional(
                -1, 0.87), // Adjust alignment as needed
          ),
        ),
      ),
      actions: [
        AppBarIcons(
          function: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: const SettingScreen(),
                );
              },
            );
          },
          icon: IconlyBold.logout,
        ),
      ],
    );
  }
}
