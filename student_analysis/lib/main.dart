import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
// import '../screens/home_screen.dart';
import 'Entry.dart';
import '../services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Node Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Entry_door()
        // home: Provider.of<UserProvider>(context).user.token.isEmpty ?
        //  Entry_door() : const HomeScreen(),
        );
  }
}
