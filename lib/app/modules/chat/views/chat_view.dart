import 'package:flutter/material.dart';
import 'package:medicalsupport/config/common_bottom_navigation_bar.dart';
import 'package:medicalsupport/config/common_bottom_navigation_floating_button.dart';
import 'package:medicalsupport/config/app_color.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  String selectedEmployee = "John Doe"; // Default employee
  String chatStatus = "Open"; // Default chat status
  bool isRead = false; // Chat read/unread state

  final List<String> employees = ["John Doe", "Alice Smith", "David Johnson"];
  final List<String> statuses = ["Open", "In Progress", "Closed"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        backgroundColor: AppColor.clientTheme,
      ),
      body: Column(
        children: [
          // User Details Section
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
                      Text("Kiran Patel", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Always active", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),

                // More options icon
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.black54),
                  onSelected: (String choice) {
                    if (choice == 'Assign Chat') {
                      _showAssignChatDialog(context);
                    } else if (choice == 'Change Status') {
                      _showChangeStatusDialog(context);
                    } else if (choice == 'Mark as Read/Unread') {
                      _toggleReadStatus();
                    } else if (choice == 'Delete Chat') {
                      _deleteChat();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      _buildPopupMenuItem(Icons.person_add, "Assign Chat"),
                      _buildPopupMenuItem(Icons.sync, "Change Status"),
                      _buildPopupMenuItem(
                        isRead ? Icons.mark_email_unread : Icons.mark_email_read,
                        isRead ? "Mark as Unread" : "Mark as Read",
                      ),
                      _buildPopupMenuItem(Icons.delete, "Delete Chat", color: Colors.red),
                    ];
                  },
                ),
              ],
            ),
          ),

          Divider(),

          // Chat Messages Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ChatBubble(message: "Hello, I'm FitBot! 🤖 How can I help you?", isSentByMe: false),
                ChatBubble(message: "Book me a visit in a gym", isSentByMe: true),
                ChatBubble(message: "Show me other sports facilities around", isSentByMe: true),
                ChatBubble(message: "Ok, how about these?", isSentByMe: false),
              ],
            ),
          ),
		  
		  // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
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
                  child: Icon(Icons.send, color: Colors.white),
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

  // Build Popup Menu Items
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

  // Toggle Read/Unread Status
  void _toggleReadStatus() {
    setState(() {
      isRead = !isRead;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRead ? "Chat marked as Read" : "Chat marked as Unread"),
        backgroundColor: Colors.blue,
      ),
    );
  }

  // Show Assign Chat Modal
  void _showAssignChatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return _buildBottomSheet(
          title: "Assign Chat to",
          child: DropdownButtonFormField<String>(
            value: selectedEmployee,
            decoration: _inputDecoration(),
            items: employees.map((employee) {
              return DropdownMenuItem<String>(
                value: employee,
                child: Text(employee),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedEmployee = newValue!;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  // Show Change Status Modal
  void _showChangeStatusDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return _buildBottomSheet(
          title: "Change Chat Status",
          child: DropdownButtonFormField<String>(
            value: chatStatus,
            decoration: _inputDecoration(),
            items: statuses.map((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Row(
                  children: [
                    Icon(Icons.circle, color: _getStatusColor(status), size: 12),
                    SizedBox(width: 8),
                    Text(status),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                chatStatus = newValue!;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  // Delete Chat Function
  void _deleteChat() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Chat"),
          content: Text("Are you sure you want to delete this chat?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
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
        );
      },
    );
  }

  // Get Status Color
  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.green;
      case "In Progress":
        return Colors.orange;
      case "Closed":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  // Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      filled: true,
      fillColor: Colors.grey.shade200,
    );
  }

  // Common Bottom Sheet Builder
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

// ChatBubble Widget
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
