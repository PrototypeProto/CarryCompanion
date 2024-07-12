import 'package:flutter/material.dart';
import 'package:gun/mongo.dart';
import 'package:gun/navigation.dart';
//import 'mongo.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Login',
                    style: TextStyle(fontSize: 24, color: Colors.black)),
                SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1))),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        //TODO add the api here to log in w/ verification
                        var db = MongoDatabase();
                         var user = await db.loginUser(_usernameController.text, _passwordController.text);
                         if(user != 'User not found'){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => NavigationPage()));
                        }
                        print('invalid login'); //TODO errro message for incorrect login
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Don\'t have an account? Register here',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}