import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';

class AnswerScreen extends StatefulWidget {
  final QuestionModel question;
  final AnswerModel? answer;

  const AnswerScreen({Key? key, required this.question, this.answer})
      : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.answer != null) {
      _answerController.text = widget.answer!.response ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.answer != null ? 'Edit Answer' : 'Answer Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question ?? 'No Question Text',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _answerController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Answer',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (widget.answer != null) {
                      print('Cập nhật câu trả lời: ${_answerController.text}');
                    } else {
                      print('Tạo câu trả lời mới: ${_answerController.text}');
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                  ),
                  child: Text(widget.answer != null
                      ? 'Update Answer'
                      : 'Submit Answer'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _answerController.clear();
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
