import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/screens/answer_screen.dart';
import 'package:intl/intl.dart'; // Import package intl

class QuestionCart extends StatelessWidget {
  final QuestionModel question;
  final AnswerModel? answer;

  const QuestionCart({Key? key, required this.question, this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Định dạng modifyDate, xử lý trường hợp null
    String formattedModifyDate = question.modifyDate != null
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(question.modifyDate!))
        : 'N/A';

    return Container(
      decoration: BoxDecoration(
        color: question.status == true ? const Color(0xFFE0F7FA) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.question_answer,
                color: Colors.blueAccent, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question ?? 'No Question Text',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: question.status == true
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Upload: $formattedModifyDate',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerScreen(
                      question: question,
                      answer: answer,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: question.status == true
                    ? Colors.orangeAccent
                    : Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                question.status == true ? 'Edit' : 'Answer',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
