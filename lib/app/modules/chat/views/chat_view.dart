import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/app_color.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:medicalsupport/services/api_service.dart';

import 'package:medicalsupport/app/modules/chat/controllers/chat_controller.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final apiService = ApiService();
  
  final chatController = Get.find<ChatController>();

  TextEditingController _messageController = TextEditingController();
  
  String selectedEmployee = "John Doe"; // Default employee
  String chatStatus = "Open";
  var _isSending = false.obs;  // RxBool
  bool isRead = false;
  List<String> employees = ["John Doe", "Alice Smith", "David Johnson"];
  List<String> statuses = ["Open", "In Progress", "Closed"];

  List<Map<String, dynamic>> _messages = [];
  late PusherChannelsFlutter pusher;
  int? reasonId;
  String? reasonText;
  String? uniqueChatId;  
  String? chatGroupId;
  String? receiverId;
  String? departmentId;
  String? editId;
  String? myId;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
	//print('arge are : $args');
	int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
	final String uniqueId = '${args['my_id']}$timestamp';
	
	if (args['unique_chat_id'] != null && args['unique_chat_id'].toString().isNotEmpty) {
		uniqueChatId = args['unique_chat_id'].toString();	
	}else{
		uniqueChatId = uniqueId;	
	}
	
	if (args['chat_group_id'] != null && args['chat_group_id'].toString().isNotEmpty) {
		chatGroupId = args['chat_group_id'].toString();
		
		_loadMessages(chatGroupId!);
		//chatController.chatMessageData(chatGroupId);
	}
	
	if (args['receiver_id'] != null && args['receiver_id'].toString().isNotEmpty) {
		receiverId = args['receiver_id'].toString();	
	}
	
    reasonId = args['reason_id'];
    reasonText = args['reason_text'];
    myId = args['my_id'];
    _connectToPusher();
  }
  
  void _loadMessages(String chatGroupId) async {
	  final response = await chatController.chatMessageData(chatGroupId);
	  if (response['success'] == true && response['messages'] != null) {
		List<dynamic> messagesData = response['messages'];
		setState(() {
		  _messages = messagesData.map<Map<String, dynamic>>((msg) {
			return {
			  'text': msg['message'],
			  'isSentByMe': msg['sender_id'].toString() == myId.toString(),
			  'created_at': msg['created_at'],
			};
		  }).toList();
		});
	  } else {
		print("No messages found or failed to load.");
	  }
	}

  void _connectToPusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: '202d9fb41bdd4ff79aeb',
      cluster: 'ap2',
      onEvent: _onPusherEvent,
      onError: (msg, code, error) => print('Pusher error: $msg'),
      //onConnectionStateChange: (state) => print('Pusher state: $state'),
	  onConnectionStateChange: (currentState, previousState) {
		  print('Pusher current state: $currentState, previous state: $previousState');
		},
    );
    await pusher.subscribe(channelName: 'chat-channel');
    await pusher.connect();
  }

  void _onPusherEvent(PusherEvent event) {
    if (event.eventName == 'message-sent') {
      final data = jsonDecode(event.data!);
      //if (data['unique_chat_id'].toString() == uniqueChatId.toString()) {
        setState(() {
          _messages.add({
            'text': data['message'],
            'isSentByMe': data['sender_id'].toString() == myId.toString(),
            'created_at': data['created_at'],
          });
		  // Save receiver_id and chat_group_id for future messages
		  if(chatGroupId == '' || chatGroupId == null){
			receiverId = data['receiver_id'].toString();
			chatGroupId = data['chat_group_id'].toString();
		  
		  }
        });
      //}
    }
  }

  @override
  void dispose() {
    pusher.unsubscribe(channelName: 'chat-channel');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: AppColor.clientTheme,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/user_avatar.png'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$reasonText", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.green),
                          SizedBox(width: 5),
                          Text("$uniqueChatId", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.black54),
                  onSelected: (String choice) {
                    if (choice == 'Assign Chat') _showAssignChatDialog(context);
                    else if (choice == 'Change Status') _showChangeStatusDialog(context);
                    else if (choice == 'Mark as Read/Unread') _toggleReadStatus();
                    else if (choice == 'Delete Chat') _deleteChat();
                  },
                  itemBuilder: (BuildContext context) => [
                    _buildPopupMenuItem(Icons.person_add, "Assign Chat"),
                    _buildPopupMenuItem(Icons.sync, "Change Status"),
                    _buildPopupMenuItem(
                      isRead ? Icons.mark_email_unread : Icons.mark_email_read,
                      isRead ? "Mark as Unread" : "Mark as Read",
                    ),
                    _buildPopupMenuItem(Icons.delete, "Delete Chat", color: Colors.red),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: _messages.map((msg) => ChatBubble(
                message: msg['text'],
                isSentByMe: msg['isSentByMe'],
              )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
				  child: TextField(
					  controller: _messageController,
					  decoration: InputDecoration(
						hintText: "Type a message...",
						prefixIcon: Icon(Icons.emoji_emotions_outlined),
						border: OutlineInputBorder(
						  borderRadius: BorderRadius.circular(25),
						  borderSide: BorderSide.none,
						),
						filled: true,
						fillColor: Colors.grey.shade200,
					  ),
					),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  //child: Icon(Icons.send, color: Colors.white),
				  child: IconButton(
					icon: Icon(Icons.send, color: Colors.white),
					onPressed: () {
					  String message = _messageController.text.trim();
					  if (message.isNotEmpty) {
						_sendMessageToApi(message);
						_messageController.clear();
					  }
					},
				  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: CommonBottomNavigationFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3),
    );
  }
  void _sendMessageToApi(String messageText) async {
	  if (messageText.trim().isEmpty) return;
	  
	  try {
		// Show loading or temporary local message if needed
		//setState(() => _isSending = true);
		_isSending.value = true;

		final response = await apiService.sendReasonMessage(
		  message: messageText,
		  receiverId: receiverId?.toString(), // Set your actual receiver ID here
		  editId: editId?.toString(),
		  departmentId: departmentId?.toString(),
		  reasonId: reasonId,
		  uniqueChatId: uniqueChatId?.toString(),
		);

		/*if (response['success'] == true && response['message'] != null) {
		  final messageData = response['message'];

		  // Save receiver_id and chat_group_id for future messages
		  setState(() {
			receiverId = messageData['receiver_id'].toString();
			chatGroupId = messageData['chat_group_id'].toString();
			_messages.add(messageData); // Update chat list with new message
		  });

		  // Optionally clear input
		  //_textController.clear();
		} else {
		  print('Failed to send message: ${response['error']}');
		}*/
	  } catch (e) {
		print('Error sending message: $e');
	  } finally {
		//setState(() => _isSending = false);
		_isSending.value = false;
	  }
	}

  PopupMenuItem<String> _buildPopupMenuItem(IconData icon, String text, {Color color = Colors.black}) {
    return PopupMenuItem(
      value: text,
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _toggleReadStatus() {
    setState(() => isRead = !isRead);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRead ? "Chat marked as Read" : "Chat marked as Unread"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showAssignChatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _buildBottomSheet(
        title: "Assign Chat to",
        child: DropdownButtonFormField<String>(
          value: selectedEmployee,
          decoration: _inputDecoration(),
          items: employees.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (newVal) {
            setState(() => selectedEmployee = newVal!);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showChangeStatusDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => _buildBottomSheet(
        title: "Change Chat Status",
        child: DropdownButtonFormField<String>(
          value: chatStatus,
          decoration: _inputDecoration(),
          items: statuses.map((s) => DropdownMenuItem(
            value: s,
            child: Row(children: [
              Icon(Icons.circle, size: 12, color: _getStatusColor(s)),
              SizedBox(width: 8),
              Text(s),
            ]),
          )).toList(),
          onChanged: (newVal) {
            setState(() => chatStatus = newVal!);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _deleteChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Chat"),
        content: Text("Are you sure you want to delete this chat?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Chat deleted"), backgroundColor: Colors.red),
              );
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open": return Colors.green;
      case "In Progress": return Colors.orange;
      case "Closed": return Colors.red;
      default: return Colors.black;
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.grey.shade200,
    );
  }

  Widget _buildBottomSheet({required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          child,
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
