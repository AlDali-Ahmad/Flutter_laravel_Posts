import 'package:flutter/material.dart';
import 'package:flutter_posts/Secrens/Page_login.dart';
import 'package:flutter_posts/Secrens/Page_posts.dart';
import 'package:flutter_posts/providers/auth.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(
        builder: (context, auth, child) {
          if (auth.authenticated) {
            return ListView(
              children: [
                ListTile(
                  title: Text(auth.user.name),
                ),
                ListTile(
                  title: Text('Posts'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    auth.logout();
                  },
                )
              ],
            );
          } else {
            return ListView(
              children: [
                ListTile(
                  title: Text('Log in'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Register'),
                  onTap: () {
                    // يمكنك هنا تنفيذ عملية التسجيل
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
