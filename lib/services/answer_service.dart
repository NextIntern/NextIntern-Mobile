import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/services/auth_service.dart';

class AnswerService {
  static Future<List<AnswerModel>> getAllAnswers() async {
    String? token = await AuthService.getToken();

    if (token != null) {
      var uri =
          Uri.https(BASE_INTERN_URL, "/api/v1/campaign-question-response/all");
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return _handleGetResponse(response); // Tách logic xử lý response
    } else {
      // Hiển thị thông báo yêu cầu đăng nhập
      // TODO: Thay thế bằng logic hiển thị dialog hoặc Snackbar
      print('Bạn cần đăng nhập để xem câu trả lời.');
      return []; // Trả về danh sách rỗng
    }
  }

  static Future<void> createAnswer(String campaignQuestionId, String response,
      int rating, BuildContext context) async {
    String? token = await AuthService.getToken();

    if (token != null) {
      var uri = Uri.https(
          BASE_INTERN_URL, "/api/v1/campaign-question-response/create");
      var body = jsonEncode({
        'campaignQuestionId': campaignQuestionId,
        'internId': "eda49f0d-c75e-46c4-a171-d77706e7017c",
        'response': response,
        'rating': rating,
      });

      var httpResponse = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      _handleCreateResponse(httpResponse, context); // Tách logic xử lý response
    } else {
      throw Exception('Unauthorized');
    }
  }

  // Hàm xử lý response cho GET request
  static List<AnswerModel> _handleGetResponse(http.Response response) {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'] as List;
      return AnswerModel.answersFromJson(data);
    } else {
      throw Exception('Failed to load answers: ${response.body}');
    }
  }

  // Hàm xử lý response cho POST request
  static void _handleCreateResponse(
      http.Response response, BuildContext context) {
    if (response.statusCode == 200) {
      print('Câu trả lời đã được gửi thành công');
      // Kiểm tra context trước khi hiển thị SnackBar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Câu trả lời đã được gửi thành công!'),
          ),
        );
      }
    } else {
      print('Lỗi khi gửi câu trả lời: ${response.body}');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi'),
            content: Text('Không thể tạo câu trả lời: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  static Future<void> updateAnswer(
    String campaignQuestionResponseId,
    String response,
    int rating,
    BuildContext context,
    String campaignQuestionId,
  ) async {
    String? token = await AuthService.getToken();

    if (token != null) {
      var uri = Uri.https(
          BASE_INTERN_URL, "/api/v1/campaign-question-response/update");
      var body = jsonEncode({
        'campaignQuestionResponseId': campaignQuestionResponseId,
        'response': response,
        'rating': rating,
        'internId': "eda49f0d-c75e-46c4-a171-d77706e7017c", // Thêm internId
        'campaignQuestionId': campaignQuestionId,
        // Thay 'your_campaign_question_id' bằng giá trị thực tế
      });

      var httpResponse = await http.put(
        // Sử dụng http.put() cho request UPDATE
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      _handleUpdateResponse(
          httpResponse, context); // Xử lý response tương tự createAnswer
    } else {
      throw Exception('Unauthorized');
    }
  }

  // Hàm xử lý response cho PUT request (giống với _handleCreateResponse)
  static void _handleUpdateResponse(
      http.Response response, BuildContext context) {
    if (response.statusCode == 200) {
      // Kiểm tra status code 200 (OK) cho update
      print('Câu trả lời đã được cập nhật thành công');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Câu trả lời đã được cập nhật thành công!'),
          ),
        );
      }
    } else {
      print('Lỗi khi cập nhật câu trả lời: ${response.body}');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Lỗi'),
            content: Text('Không thể cập nhật câu trả lời: ${response.body}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
