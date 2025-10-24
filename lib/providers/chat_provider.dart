import 'package:campussync/models/chat_message.dart';
import 'package:campussync/services/ai_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi! I'm Ari. Ask me anything about your studies!",
      isUser: false,
    ),
  ];

  List<ChatMessage> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    _messages.add(ChatMessage(text: text, isUser: true));
    _isLoading = true;
    notifyListeners();

    try {
      final aiService = AIService(); // Create only when needed
      final aiResponse = await aiService.getFeedback(text);
      _messages.add(ChatMessage(text: aiResponse, isUser: false));
    } catch (e) {
      _messages.add(ChatMessage(text: 'Error: ${e.toString()}', isUser: false));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
