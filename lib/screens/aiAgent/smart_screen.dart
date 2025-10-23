import 'package:campussync/services/ai_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'study_smart_chip.dart';

// --- Color Constants specific to this screen ---
const Color kAskAriLightBlue = Color(0xFFE8F7FE);
const Color kAskAriDarkBlue = Color(0xFFC7EBFD);
const Color kAskAriGradientStart = Color(0xFF91D4FA);
const Color kAskAriGradientEnd = Color(0xFFC7EBFD);

const Color kChipBlue = Color(0xFF2196F3);
const Color kChipDarkBlue = Color(0xFF1976D2);

// --- Gradient for the "Ask Ari" section ---
final kAskAriBackgroundGradient = LinearGradient(
  colors: [
    kAskAriGradientStart.withOpacity(0.2),
    kAskAriGradientEnd.withOpacity(0.0),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

class StudySmartScreen extends StatefulWidget {
  const StudySmartScreen({super.key});

  @override
  State<StudySmartScreen> createState() => _StudySmartScreenState();
}

class _StudySmartScreenState extends State<StudySmartScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages =
      []; // {"role": "user"/"ai", "text": "..."}
  final List<String> _selectedChips = [];

  void _onChipTap(String label) {
    setState(() {
      if (_selectedChips.contains(label)) {
        _selectedChips.remove(label);
      } else {
        _selectedChips.add(label);
      }
    });

    // Send the chip label as a prompt to AI
    _sendMessage(prompt: label);
  }

  void _sendMessage({String? prompt}) async {
    final text = prompt ?? _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      if (prompt == null) _textController.clear();
    });

    final aiService = AIService();
    try {
      final response = await aiService.getFeedback(text);
      setState(() {
        _messages.add({"role": "ai", "text": response});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "role": "ai",
          "text": "Error: Failed to get AI response.",
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildSearchBarAppBar(),
      body: Column(
        children: [
          _buildAskAriSection(),
          const SizedBox(height: 10),
          _buildPromptChips(),
          const SizedBox(height: 10),
          _buildChatList(),
          _buildChatInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildSearchBarAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Container(
        height: 40,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Study smart +',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onSubmitted: (value) => _sendMessage(),
                controller: _textController,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black54, size: 24),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAskAriSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(gradient: kAskAriBackgroundGradient),
      child: Column(
        children: [
          const Text(
            'Ask Ari about',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Text(
            'your studies',
            style: TextStyle(
              color: kAskAriGradientStart.withOpacity(0.7),
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'What do you need for today\'s classes?',
            style: TextStyle(color: Colors.black54, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPromptChips() {
    final List<String> prompts = [
      'Today\'s class summary',
      'Deadlines this week',
      'What\'s due',
      'Revise for quiz',
      'Generate study checklist',
      'Outline my essay',
      'Cite sources (APA)',
      'Create flashcards',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: prompts.map((label) {
          final isSelected = _selectedChips.contains(label);
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: StudySmartChip(
              label: label,
              isSelected: isSelected,
              onTap: () => _onChipTap(label),
              selectedColor: kChipBlue,
              unselectedColor: Colors.grey[200]!,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChatList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isUser = message["role"] == "user";
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message["text"]!,
                style: TextStyle(color: isUser ? Colors.white : Colors.black87),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
            onPressed: () => print('Add button tapped'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message..',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      minLines: 1,
                      maxLines: 5,
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.grey, size: 24),
                    onPressed: () => print('Microphone button tapped'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue, size: 28),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
