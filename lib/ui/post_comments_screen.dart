import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class PostComments extends StatefulWidget {
  static const routeName = '/post_comments_screen';

  @override
  _PostCommentsState createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  var data;
  //Get data
  @override
  void didChangeDependencies() {

      this.getComments();

    super.didChangeDependencies();
  }

  Future<String> getComments() async {
    final postId = ModalRoute.of(context).settings.arguments;
    final String url =
        "https://jsonplaceholder.typicode.com/posts/$postId/comments?postId=$postId";

    try {
      var response = await http.get(url);


      setState(() {
        data = json.decode(response.body);
      });

      return "Success";
    }
    catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
          centerTitle: true,
          backgroundColor: Colors.black45,
        ),
        body:  data == null
            ? Center(
          child: CircularProgressIndicator(),
        ) :
        Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(height: 6.0,
                    color: Colors.amberAccent,),
                    ListTile(
                      title: Text("${data[index]['name']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      trailing: Text("${data[index]['email']}",
                      style: TextStyle(
                        fontSize: 12
                      ),),
                      subtitle: Text("${data[index]['body']}"),
                    )
                  ],
                );
              }),
        )
    );
  }
}