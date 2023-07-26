import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyAppData>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Theme.of(context).appBarTheme.iconTheme?.color),
        elevation: 0.1,
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title:
                  Text(themeProvider.isDarkMode ? 'Dark Theme' : 'Light Theme'),
              trailing: Icon(
                themeProvider.isDarkMode
                    ? Icons.lightbulb
                    : Icons.lightbulb_outline,
              ),
              onTap: () {
                themeProvider.toggleTheme(); // Toggle the theme
              },
            ),
          ],
        ),
      ),
    );
  }
}
