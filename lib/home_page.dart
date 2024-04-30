import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<GetData> getList = [];

  Future<List<GetData>> getDataList ()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for (Map <String,dynamic> i in data){
        GetData getData = GetData(body: i["body"], id: i["id"], title: i["title"]);
        getList.add(getData);
      }
      return getList;
    }else{
      return getList;
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDataList(), 
              builder: (BuildContext context, AsyncSnapshot<List<GetData>> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Text("Loading...."),
                  );
                }else{
                 return ListView.builder(
                  itemCount: getList.length,
                  itemBuilder: (context,index){
                  return ListTile(
                    title: Text(snapshot.data![index].title.toString()),
                    leading: Text(snapshot.data![index].id.toString()),
                    subtitle: Text(snapshot.data![index].body.toString()),
                  );
                 });
                }
              }),
          )
        ],
      ),
    );
  }
}
class GetData{
  String title,body;
  int id;
  GetData ({required this.body,required this.id,required this.title});
}