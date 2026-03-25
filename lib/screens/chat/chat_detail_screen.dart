import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flex_yemen/theme/app_theme.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;
  final String? imageUrl;

  ChatMessage({required this.text, required this.isMe, required this.time, this.imageUrl});
}

class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  const ChatDetailScreen({super.key, required this.userName, required this.userImage});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'السلام عليكم، هل المنتج لا يزال متوفراً؟', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 10))),
    ChatMessage(text: 'وعليكم السلام، نعم أخي متوفر وبحالة ممتازة.', isMe: true, time: DateTime.now().subtract(const Duration(minutes: 8))),
    ChatMessage(text: 'هل يمكنني رؤية صور إضافية؟', isMe: false, time: DateTime.now().subtract(const Duration(minutes: 5))),
    ChatMessage(text: 'بالتأكيد، تفضل هذه صورة مقربة.', isMe: true, time: DateTime.now().subtract(const Duration(minutes: 2)), imageUrl: 'https://picsum.photos/seed/chat/400/300'),
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(text: _messageController.text, isMe: true, time: DateTime.now()));
        _messageController.clear();
      });
      // Simulate reply
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(text: 'شكراً لك، سأتواصل معك قريباً.', isMe: false, time: DateTime.now()));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.userImage), radius: 18),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('متصل الآن', style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages.reversed.toList()[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.goldPrimary : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: message.isMe ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight: message.isMe ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(message.imageUrl!, fit: BoxFit.cover),
              ),
            if (message.imageUrl != null) const SizedBox(height: 5),
            Text(
              message.text,
              style: TextStyle(color: message.isMe ? Colors.white : Colors.black87),
            ),
            const SizedBox(height: 5),
            Text(
              '${message.time.hour}:${message.time.minute}',
              style: TextStyle(color: message.isMe ? Colors.white70 : Colors.black45, fontSize: 10),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms).slideX(begin: message.isMe ? 0.2 : -0.2, end: 0),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.add_circle_outline, color: AppColors.goldPrimary), onPressed: () {}),
          IconButton(icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: const CircleAvatar(
              backgroundColor: AppColors.goldPrimary,
              child: Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
