import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginassignment/UserModel.dart';
import 'package:http/http.dart' as http;

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  Future<List<UserModel>> fetchAlbum() async {
     String url = "https://reqres.in/api/users";
     final response =await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String,dynamic> map = json.decode(response.body);
       List<dynamic> result= map["data"];
      print(result);
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(2.0),
            child: FutureBuilder<List<UserModel>>(
              future: fetchAlbum(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child:ClipOval(
                          child: Image.network(
                              snapshot.data![index].avatar.toString()),
                        )
                        ),
                        title: Text("${snapshot.data![index].first_name}  ${snapshot.data![index].last_name}"),
                        subtitle: Text(snapshot.data![index].email.toString()),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
           ),
    );
  }
}
