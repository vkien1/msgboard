import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hw4/user_services.dart';
import 'package:intl/intl.dart'; 

class ChatScreen extends StatefulWidget {
  final String boardTitle;

  ChatScreen({required this.boardTitle});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  Future<String> fetchUsername(String uid) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      return docSnapshot.data()?['username'] ?? 'Unknown';
    }
    return 'Unknown';
  }

  void sendMessage() async {
    final messageText = _messageController.text.trim();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && messageText.isNotEmpty) {
      
      final username = await UserService.fetchUsername(user.uid);

      FirebaseFirestore.instance.collection('messageBoards').doc(widget.boardTitle).collection('messages').add({
        'username': username,
        'message': messageText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('messageBoards').doc(widget.boardTitle).collection('messages').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final messageData = messages[index].data() as Map<String, dynamic>;
                    final timestamp = messageData['timestamp'];
                    final dateTime = timestamp != null ? (timestamp as Timestamp).toDate() : DateTime.now();
                    final formattedTime = DateFormat.jm().format(dateTime); 

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text('${messageData['username'] ?? 'Anonymous'} at $formattedTime'),
                          subtitle: Text(messageData['message']),
                        ),
                      ),
                    );
                  },
                );
              },
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
                      labelText: 'Send a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
