import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'UserData.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void login(String email , password) async {

    try{

      Response response = await post(
          Uri.parse('https://abhhyam.com/member-app-login'),
          body: {
            'username' : email,
            'password' : password
          }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());
        print(data);
        print('Login successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserData()),
        );

      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: SingleChildScrollView(

          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  padding: EdgeInsets.only(left: 40),

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Login", style: TextStyle(color: Colors.blue, fontSize: 40, fontWeight: FontWeight.bold),)
                    ],
                ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:30.0,top: 20.0,right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: 'username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          )
                        ),

                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        decoration:  InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            )
                        ),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          login(usernameController.text.toString(), passwordController.text.toString());
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: const Center(child: Text('Login',),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

        ),
        ),
    );
  }
}