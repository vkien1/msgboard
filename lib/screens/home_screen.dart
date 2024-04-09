import 'package:flutter/material.dart';
import 'chat_screen.dart'; 
import 'settings_screen.dart';
import 'profile_screen.dart'; 

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messageBoards = [
    {"title": "School", "icon": Icons.school},
    {"title": "Sports", "icon": Icons.sports_soccer},
    {"title": "Work", "icon": Icons.work},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1B4D3E), 
        title: Text(
          'Message Boards',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1B4D3E), 
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message, color: Color(0xFF1B4D3E)),
              title: Text('Message Boards', style: TextStyle(color: Color(0xFF1B4D3E))),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Color(0xFF1B4D3E)),
              title: Text('Profile', style: TextStyle(color: Color(0xFF1B4D3E))),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF1B4D3E)),
              title: Text('Settings', style: TextStyle(color: Color(0xFF1B4D3E))),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, 
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemCount: messageBoards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(boardTitle: messageBoards[index]['title']),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor, 
                    child: Icon(messageBoards[index]['icon'], size: 30, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    messageBoards[index]['title'], 
                    style: TextStyle(color: Color(0xFF1B4D3E)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
