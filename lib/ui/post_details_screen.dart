import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import './post_comments_screen.dart';


class PostDetails extends StatefulWidget {
  static const routeName = '/post_details_screen';

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  var data;
// Get data
  @override
  void didChangeDependencies() {

    this.getDetails();

    super.didChangeDependencies();
  }

  Future<String> getDetails() async {
    final postId = ModalRoute.of(context).settings.arguments;
    final String url = "https://jsonplaceholder.typicode.com/posts/$postId";

    try {
      var response = await http.get(url);
      setState(() {
        data = json.decode(response.body);
      });

      return "Success";
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: data == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(12),
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.amberAccent,
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.amberAccent,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "${data['title']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "${data['body']}",
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          PostComments.routeName,
                          arguments: data['id'],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}