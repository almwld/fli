import 'package:flutter/material.dart';
import 'package:flex_yemen/theme/app_theme.dart';
import 'package:flex_yemen/widgets/common/custom_app_bar.dart';
import 'package:flex_yemen/screens/chat/chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'name': 'أحمد علي', 'lastMsg': 'هل السعر قابل للتفاوض؟', 'time': '10:30 ص', 'unread': 2, 'image': 'https://picsum.photos/seed/user1/100/100'},
      {'name': 'سارة محمد', 'lastMsg': 'تم إرسال الصور المطلوبة', 'time': 'أمس', 'unread': 0, 'image': 'https://picsum.photos/seed/user2/100/100'},
      {'name': 'متجر النور', 'lastMsg': 'طلبك جاهز للتوصيل', 'time': '20 مايو', 'unread': 0, 'image': 'https://picsum.photos/seed/user3/100/100'},
      {'name': 'خالد عبدالله', 'lastMsg': 'شكراً لك أخي', 'time': '18 مايو', 'unread': 0, 'image': 'https://picsum.photos/seed/user4/100/100'},
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'المحادثات'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'البحث في المحادثات...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(userName: chat['name'] as String, userImage: chat['image'] as String),
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(chat['image'] as String),
                  ),
                  title: Text(chat['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(chat['lastMsg'] as String, maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(chat['time'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      if ((chat['unread'] as int) > 0)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle),
                          child: Text(chat['unread'].toString(), style: const TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
