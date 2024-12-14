import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'models/user.dart';

class ChatAI extends StatefulWidget {
  const ChatAI({Key? key}) : super(key: key);
  @override
  ChatAIState createState() => ChatAIState();
}

class ChatAIState extends State<ChatAI> {
  bool _isLoading = false;

  late final GenerativeModel _model;
  late final ChatSession _session;
  late final TextEditingController _textController;
  final FocusNode _textFieldFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: const String.fromEnvironment('API_KEY'),
    );
    _session = _model.startChat();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chatbot'),
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/gemini_logo.jpg', // Replace with the path to your Gemini logo
              height: 30.0,
              width: 55.0,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _session.history.length,
                    itemBuilder: (context, index) {
                      final Content content = _session.history.toList()[index];
                      final text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageBuilder(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  autofocus: true,
                  controller: _textController,
                  focusNode: _textFieldFocus,
                  decoration: InputDecoration(
                    hintText: 'Ask your question...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Handle sending message
                        final text = _textController.text;
                        if (text.isNotEmpty) {
                          _sendMessage(text);
                          _textController.clear();
                        }
                      },
                    ),
                  ),
                  onSubmitted: _sendMessage,
                ),
              ],
            ),
            // Text field prompt for user input
          ),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.69),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFA4A5FF)), // Change this color as needed
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _session.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        _showError('Failed to get response');
        return;
      } else {
        setState(() {
          _isLoading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _isLoading = false;
      });
    } finally {
      _textController.clear(); // clear input
      setState(() {
        _isLoading = false;
      });
      _textFieldFocus.requestFocus(); // refocus
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCirc,
    ));
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Something went wrong'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}

class MessageBuilder extends StatelessWidget {
  MessageBuilder({
    Key? key,
    required this.text,
    required this.isFromUser,
  }) : super(key: key);

  final String text;
  final bool isFromUser;

  final String? profilePicUrl = UserCredentials().profilePicUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              // Avatar
              if (!isFromUser) ...[
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/gemini_icon.png'),
                  radius: 16,
                ),
                const SizedBox(width: 8),
              ],
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                constraints: const BoxConstraints(maxWidth: 270),
                decoration: BoxDecoration(
                  color:
                  isFromUser ? const Color(0xAAAEC7FF) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                            color: Colors
                                .black), // Change this to your desired color
                      ),
                    ),
                  ],
                ),
              ),
              if (isFromUser) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: profilePicUrl != null &&
                      profilePicUrl!.isNotEmpty
                      ? (profilePicUrl!.startsWith('http') ||
                      profilePicUrl!.startsWith('https')
                      ? NetworkImage(profilePicUrl!)
                      : FileImage(File(profilePicUrl!))) as ImageProvider
                      : const AssetImage('assets/images/default_avatar.png'),
                  radius: 16,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
// TODO Implement this library.