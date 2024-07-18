import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/screens/answer_screen.dart';

class QuestionCart extends StatelessWidget {
  final QuestionModel question;
  final AnswerModel? answer;

  const QuestionCart({Key? key, required this.question, this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: question.status == true ? const Color(0xFFE0F7FA) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question ?? 'No Question Text',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: question.status == true
                          ? Colors.grey[600]
                          : Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Modified: ${question.modifyDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                if (question.status == true) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswerScreen(
                        question: question,
                        answer: answer,
                      ),
                    ),
                  );
                } else {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnswerScreen(
                        question: question,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    question.status == true ? Colors.grey : Colors.blue,
                minimumSize: const Size(80, 36),
              ),
              child: Text(question.status == true ? 'Edit' : 'Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
