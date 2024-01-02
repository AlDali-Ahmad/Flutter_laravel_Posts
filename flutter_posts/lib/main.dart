import 'package:flutter/material.dart';
import 'package:flutter_posts/providers/auth.dart';
import 'package:flutter_posts/widgets/Nav-drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();
  void _attemptAuthentication() async {
    final key = await storage.read(key: 'auth');
    Provider.of<Auth>(context, listen: false).attempt(key!);
  }

  @override
  void initSteate() {
    _attemptAuthentication();
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World'),
          backgroundColor: Colors.blue[700],
        ),
        drawer: NavDrawer(),
        body: Center(
          child: Consumer<Auth>(
            builder: (context, auth, child) {
              return auth.authenticated
                  ? Text('You are Logged in ....')
                  : Text('You are not Logged in ....');
            },
          ),
        ),
      ),
    );
  }
}
