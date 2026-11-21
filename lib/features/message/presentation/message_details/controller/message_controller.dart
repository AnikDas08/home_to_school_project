import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_to_school/services/storage/storage_services.dart';
import 'package:home_to_school/utils/enum/enum.dart';

class MessageItem {
  final String text;
  final String time;
  final bool isMe;
  final bool isStatus;

  MessageItem({
    required this.text,
    required this.time,
    required this.isMe,
    this.isStatus = false,
  });
}

class MessageController extends GetxController {
  static MessageController get instance => Get.find<MessageController>();

  Status status = Status.completed;
  bool isLoading = false;
  String chatId = '';
  String name = 'Tariq Ahmed';

  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  List<String> get quickReplies {
    final isStudent = LocalStorage.role.toLowerCase().contains('student');
    if (isStudent) {
      return [
        "I'm on my way",
        "I've arrived",
        "I have boarded",
        "Arrived safely at campus",
      ];
    }
    return [
      "I'm on my way",
      "I've arrived",
      "Child has been picked up",
      "Child dropped off safely",
    ];
  }

  List<MessageItem> messages = [];

  void _loadMessages() {
    final isStudent = LocalStorage.role.toLowerCase().contains('student');
    if (isStudent) {
      final studentName = LocalStorage.myName.isNotEmpty ? LocalStorage.myName : 'Alex';
      messages = [
        MessageItem(
          text:
              'Good morning $studentName! I am about 5 minutes away from your pickup location.',
          time: '07:25 AM',
          isMe: false,
        ),
        MessageItem(
          text:
              'Good morning Tariq! I am waiting outside at the front entrance with my backpack.',
          time: '07:31 AM',
          isMe: true,
        ),
        MessageItem(
          text: 'Rider safely boarded & buckled in • 07:33 AM',
          time: '07:33 AM',
          isMe: false,
          isStatus: true,
        ),
        MessageItem(
          text:
              'Got you seated safely! We are now heading towards campus.',
          time: '07:34 AM',
          isMe: false,
        ),
        MessageItem(
          text: 'Thank you — please ping when we reach the main gate.',
          time: '07:35 AM',
          isMe: true,
        ),
      ];
    } else {
      messages = [
        MessageItem(
          text:
              'Good morning Sadia! I am about 5 minutes away from your home pickup.',
          time: '07:25 AM',
          isMe: false,
        ),
        MessageItem(
          text:
              'Good morning Tariq! Arman and Emma are waiting at the front porch with their school backpacks.',
          time: '07:31 AM',
          isMe: true,
        ),
        MessageItem(
          text: 'Children safely boarded & buckled in • 07:33 AM',
          time: '07:33 AM',
          isMe: false,
          isStatus: true,
        ),
        MessageItem(
          text:
              'Got both of them buckled in safely! We are now heading towards Greenfield International School.',
          time: '07:34 AM',
          isMe: false,
        ),
        MessageItem(
          text: 'Thank you — please ping when you reach the loop.',
          time: '07:35 AM',
          isMe: true,
        ),
      ];
    }
  }

  @override
  void onInit() {
    super.onInit();
    syncParams();
    _loadMessages();

    // API calls commented out for now as requested
    // getMessages();
    // listenMessage(chatId);
  }

  void syncParams() {
    final params = Get.parameters;
    if (params['name'] != null && params['name']!.isNotEmpty) {
      name = params['name']!;
    }
    if (params['chatId'] != null && params['chatId']!.isNotEmpty) {
      chatId = params['chatId']!;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final amPm = now.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:$minute $amPm';
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(
      MessageItem(
        text: text,
        time: _formatCurrentTime(),
        isMe: true,
      ),
    );

    messageController.clear();
    update();
    _scrollToBottom();

    // API & Socket calls commented out for now
    /*
    final currentUserId = LocalStorage.user?.id ?? LocalStorage.userId;
    _messageRepository.sendMessage(
      chatId: chatId,
      text: text,
      senderId: currentUserId,
    );
    */
  }

  void sendQuickReply(String reply) {
    messageController.text = reply;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: reply.length),
    );
    update();
  }

  // Commented out API fetching methods
  /*
  Future<void> getMessages() async {
    try {
      final messageEntities = await _messageRepository.getMessages(
        chatId: chatId,
        page: 1,
        limit: 15,
      );
    } catch (e) {
      status = Status.error;
    }
  }

  void listenMessage(String chatId) {
    SocketService.on('new-message::$chatId', (data) {
      // socket listener
    });
  }
  */

  @override
  void onClose() {
    scrollController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
