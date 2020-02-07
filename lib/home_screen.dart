import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import './ui/post_details_screen.dart';

class Posts extends StatefulWidget {

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final String url = "https://jsonplaceholder.typicode.com/posts";
  var data;
// Get data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPosts();
  }

  Future<String> getPosts() async {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
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
                            title: Text("${data[index]['title']}"),
                            trailing: Text("${data[index]['userId']}"),
                             onTap: (){
                              Navigator.of(context).pushNamed(
                                PostDetails.routeName,
                                arguments: data[index]['id'],
                              );
                            },

                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.amberAccent,
                                  radius: 24,
                                  child: Text("${data[index]['id']}"),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              )
    );
  }

}