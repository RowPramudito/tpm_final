import 'package:flutter/material.dart';
import 'package:tmp_finalproject/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    child: Text("Logout"),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                              (route) => false);
                    }
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/images/rowang.jpg',
                  fit: BoxFit.scaleDown,
                  width: 200, height: 200,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  'Rowang Pramudito',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  '123200098 / IF-H',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  'Hi, how are u?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
