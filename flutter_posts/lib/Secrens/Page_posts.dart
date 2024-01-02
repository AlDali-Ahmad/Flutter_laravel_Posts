import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import '../dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_posts/models/post.dart';

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostState();
  }
}

class PostState extends State<PostPage> {
  Future<List<Post>> getPost() async {
    Dio.Response respose = await dio().get(
      '/user/posts',
      options: Dio.Options(
        headers: {'auth': true},
      ),
    );

    List posts = json.decode(respose.toString());
    return posts.map((post) => Post.fromJson(post)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        backgroundColor: Colors.blue[700],
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return ListTile(
                    title: Text(item.title),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('No Posts found!');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
