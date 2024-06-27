import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/services/question_service.dart';
import 'package:nextintern_mobile/widgets/custom_app_bar.dart'; // Replace with the actual path to ApiHandler
import 'package:nextintern_mobile/widgets/question_cart.dart'; // Replace with the actual path to QuestionWidget

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<List<QuestionModel>> _questionListFuture;

  @override
  void initState() {
    super.initState();
    _questionListFuture = QuestionService.getAllQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize:
            Size.fromHeight(kToolbarHeight), // Adjust height as needed
        child: GradientAppBar(
          title: 'Question',
        ),
      ),
      body: FutureBuilder<List<QuestionModel>>(
        future: _questionListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Hiển thị khi đang load dữ liệu
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Hiển thị khi có lỗi xảy ra
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Hiển thị dữ liệu khi đã tải xong
            List<QuestionModel> questionList = snapshot.data!;
            return ListView.builder(
              itemCount: questionList.length,
              itemBuilder: (context, index) {
                return QuestionCart(question: questionList[index]);
              },
            );
          } else {
            // Trường hợp không có dữ liệu
            return Center(child: Text('No questions found'));
          }
        },
      ),
    );
  }
}
