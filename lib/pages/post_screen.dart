import 'package:flutter/material.dart';
import 'package:picstant/pages/home.dart';
import 'package:picstant/widgets/header.dart';
import 'package:picstant/widgets/post.dart';
import 'package:picstant/widgets/progress.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;
  PostScreen({this.postId, this.userId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef
          .document(userId)
          .collection('userPosts')
          .document(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            appBar: header(context, titleText: post.description),
            body: ListView(
              children: <Widget>[
                Container(child: post,),
              ],
            ),
          ),
        );
      },
    );
  }
}
