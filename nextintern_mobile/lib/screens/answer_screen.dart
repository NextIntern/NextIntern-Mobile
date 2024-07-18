import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/services/answer_service.dart';

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
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.answer != null) {
      _answerController.text = widget.answer!.response ?? '';
      _rating = widget.answer!.rating ?? 0;
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
            Slider(
              value: _rating.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: _rating.toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (widget.answer != null) {
                      // Gọi API cập nhật câu trả lời
                      await AnswerService.updateAnswer(
                        widget.answer!.campaignQuestionResponseId!,
                        _answerController.text,
                        _rating,
                        context,
                        widget.answer!
                            .campaignQuestionId!, // Lấy campaignQuestionId từ answer
                      );
                      print('Cập nhật câu trả lời: ${_answerController.text}');
                    } else {
                      // Gọi API tạo câu trả lời mới
                      await AnswerService.createAnswer(
                        widget.question.campaignQuestionId!,
                        _answerController.text,
                        _rating,
                        context,
                      );
                      print('Tạo câu trả lời mới: ${_answerController.text}');
                    }
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context, true);
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
                    setState(() {
                      _rating = 0;
                    });
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
