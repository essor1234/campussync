// lib/services/ai_service.dart
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {
  final String? apiKey = dotenv.env['PERPLEXITY_API_KEY'];

  Future<String> getFeedback(String prompt) async {
    // Validate API key
    if (apiKey == null || apiKey!.isEmpty) {
      throw Exception('PERPLEXITY_API_KEY is missing in .env file');
    }

    final response = await http.post(
      Uri.parse(
        'https://api.perplexity.ai/chat/completions',
      ), // Correct endpoint
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "sonar-pro", // Updated to current model
        "messages": [
          {"role": "system", "content": "You are a helpful study assistant."},
          {"role": "user", "content": prompt},
        ],
        "max_tokens": 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'] ?? 'No response';
    } else {
      final errorBody = utf8.decode(response.bodyBytes);
      throw Exception(
        'AI API Error: ${response.statusCode}\nResponse: $errorBody',
      );
    }
  }
}
