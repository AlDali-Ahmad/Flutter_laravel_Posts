import 'package:flutter/material.dart';
import 'package:flutter_posts/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  void submet() {
    Provider.of<Auth>(context, listen: false).login(credentials: {
      'email': _email,
      'password': _password,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in Bage ..'),
        backgroundColor: Colors.amber[500],
      ),
      body: Form(
        key: _formkey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@gmail.com',
                    ),
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'PassWord',
                      hintText: '123123',
                    ),
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Log in'),
                    onPressed: () {
                      _formkey.currentState?.save();
                      submet();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
