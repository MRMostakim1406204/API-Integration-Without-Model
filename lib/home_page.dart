import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List <Photos> getPhotosList = [];

  Future<List<Photos>> getPhotos()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String,dynamic> i in data){
        Photos photos = Photos(title: i["title"], url: i["url"],id: i["id"]);
        getPhotosList.add(photos);
      }
      return getPhotosList;
    }else{
      return getPhotosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(), 
              builder: (context,snapshot){
                return ListView.builder(
                  itemCount: getPhotosList.length,
                  itemBuilder: (context,index){
                  return ListTile(
                    leading: Text(snapshot.data![index].id.toString()),
                    title: Text(snapshot.data![index].title.toString()),
                    trailing: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                    ),
                  );
                });
              }),
          )
        ],
      ),
    );
  }
}

class Photos{
  String title,url;
  int id;
  Photos ({required this.title,required this.url,required this.id});
}