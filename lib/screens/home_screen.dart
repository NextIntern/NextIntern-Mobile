// home_screen.dart

import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/criteria_model.dart'; // Import CriteriaModel
import 'package:nextintern_mobile/widgets/custom_app_bar.dart';
import 'package:nextintern_mobile/widgets/criteria_card.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tạo danh sách 12 CriteriaModel giả
  List<CriteriaModel> criteriaList = [
    CriteriaModel(
        criteria: 'Kỹ năng giao tiếp',
        evaluateFromMentor: 'Tốt',
        start: true,
        isChecked: true),
    CriteriaModel(
        criteria: 'Khả năng làm việc nhóm',
        evaluateFromMentor: 'Xuất sắc',
        start: true,
        isChecked: false),
    CriteriaModel(
        criteria: 'Kỹ năng giải quyết vấn đề',
        evaluateFromMentor: 'Cần cải thiện',
        start: false,
        isChecked: true),
    CriteriaModel(
        criteria: 'Chủ động học hỏi',
        evaluateFromMentor: 'Tốt',
        start: true,
        isChecked: true),
    CriteriaModel(
        criteria: 'Tinh thần trách nhiệm',
        evaluateFromMentor: 'Xuất sắc',
        start: false,
        isChecked: false),
    CriteriaModel(
        criteria: 'Sáng tạo',
        evaluateFromMentor: 'Khá',
        start: true,
        isChecked: true),
    CriteriaModel(
        criteria: 'Kỹ năng lập trình',
        evaluateFromMentor: 'Tốt',
        start: true,
        isChecked: false),
    CriteriaModel(
        criteria: 'Kỹ năng phân tích',
        evaluateFromMentor: 'Xuất sắc',
        start: false,
        isChecked: true),
    CriteriaModel(
        criteria: 'Kiến thức chuyên môn',
        evaluateFromMentor: 'Cần cải thiện',
        start: true,
        isChecked: true),
    CriteriaModel(
        criteria: 'Khả năng thích nghi',
        evaluateFromMentor: 'Khá',
        start: true,
        isChecked: false),
    CriteriaModel(
        criteria: 'Giao tiếp tiếng Anh',
        evaluateFromMentor: 'Tốt',
        start: false,
        isChecked: true),
    CriteriaModel(
        criteria: 'Quản lý thời gian',
        evaluateFromMentor: 'Xuất sắc',
        start: true,
        isChecked: true),
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Delay 1 giây rồi cập nhật _isLoading và hiển thị danh sách
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: GradientAppBar(
          title: 'Home',
        ),
      ),
      body: _isLoading // Kiểm tra loading state
          ? const Center(child: CircularProgressIndicator()) // Hiển thị loading
          : ListView.builder(
              itemCount: criteriaList.length,
              itemBuilder: (context, index) {
                return CriteriaCard(criteria: criteriaList[index]);
              },
            ),
    );
  }
}
