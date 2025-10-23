// lib/services/ai_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {
  final String apiKey = dotenv.env['PERPLEXITY_API_KEY'] ?? '';

  Future<String> getFeedback(String prompt) async {
    final response = await http.post(
      Uri.parse(
        'https://api.perplexity.ai/v1/feedback',
      ), // Replace with actual Perplexity endpoint
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': prompt,
        'template':
            'List all positives, list improvements, grade based on demo template',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['answer'] ?? 'No feedback received';
    } else {
      throw Exception('AI API Error: ${response.statusCode}');
    }
  }
}
