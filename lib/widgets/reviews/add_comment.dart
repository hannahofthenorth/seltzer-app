import 'package:flutter/material.dart';

class AddComment extends StatefulWidget {
  static final GlobalKey<_AddCommentState> globalKey = GlobalKey();
  final String uid;

  AddComment(this.uid);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  String _comment;
  bool addComment = false;

  void addAComment() {
    addComment = !addComment;
    setState(() {});
  }

  void sendComment(String uid) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return addComment
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: addComment ? 50 : 10,
            constraints: BoxConstraints(minHeight: 50),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter a comment!'),
                    onChanged: (value) {
                      _comment = value;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendComment(widget.uid),
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          )
        : SizedBox();
  }
}
