// lib/providers/chat_provider.dart
import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/ai_service.dart';

class ChatProvider extends ChangeNotifier {
  final AIService _aiService = AIService();
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    try {
      final aiResponse = await _aiService.getFeedback(text);
      _messages.add(ChatMessage(text: aiResponse, isUser: false));
    } catch (e) {
      _messages.add(
        ChatMessage(
          text: 'Error fetching AI response: ${e.toString()}',
          isUser: false,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
