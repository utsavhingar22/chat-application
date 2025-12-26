import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controllers/user_controller.dart';
import 'controllers/message_controller.dart';
import 'views/home_screen.dart';
import 'views/offers_screen.dart';
import 'views/settings_screen.dart';

// Global controllers to persist data across rebuilds
final UserController userController = UserController();
final MessageController messageController = MessageController();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6366F1),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: false,
        fontFamily: 'SF Pro Display', // Modern iOS-like font
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(
              userController: userController,
              messageController: messageController,
            ),
        '/offers': (context) => const OffersScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
