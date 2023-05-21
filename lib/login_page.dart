import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmp_finalproject/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String username = ""; String password = "";
  bool error = false;
  String errormsg = "";

  doLogin() async {
    String apiUrl = "http://192.168.1.9/tmp_finalproject/login.php";

    var response = await http.post(Uri.parse(apiUrl), body: {
      'username': username,
      'password': password
    });

    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      if(jsondata["error"]){
        setState(() {
          error = true;
          errormsg = jsondata["message"];
        });
      }
      else{
        if(jsondata["success"]){
          setState(() {
            error = false;
          });
          String full_name = jsondata["full_name"];
          String student_num = jsondata["student_num"];
          print(full_name);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        }
        else{
          error = true;
          errormsg = "Terjadi kesalahan.";
        }
      }
    }
    else{
      setState(() {
        error = true;
        errormsg = "Error menghubungkan ke server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 150),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.topCenter,
                child: const Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 36),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                alignment: Alignment.topCenter,
                child: const Text(
                  'Untuk masuk silakan login menggunakan username dan password.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

                child: TextFormField(
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
              ),
              Container(
                child: error? const Text(
                  'Input username dan password yang benar.',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ):Container(),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: 120,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text("Login"),
                    onPressed: (){doLogin();}
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
