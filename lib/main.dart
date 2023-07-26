import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/splash_screen/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MyAppData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<MyAppData>(context);

    return MaterialApp(
      theme: ThemeData.light().copyWith(
        iconTheme: IconThemeData(color: Colors.black),
        popupMenuTheme: PopupMenuThemeData(
          color: Colors.black,
        ),
        scaffoldBackgroundColor: Color(0XFFE5ECF4),
        appBarTheme: AppBarTheme(
            color: Color(0XFFE5ECF4),
            titleTextStyle: TextStyle(color: Colors.black)),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0XFF313745),
        appBarTheme: AppBarTheme(color: Color(0XFF313745)),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      color: Color(0XFFE5ECF4),
      home: SplashScreen(),
    );
  }
}

class MyAppData with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
