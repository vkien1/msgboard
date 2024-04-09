import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:hw4/theme_provider.dart'; 

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    bool isDarkMode = Provider.of<ThemeProvider>(context).getTheme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (bool value) {
              
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
