import 'package:flutter/material.dart';
import 'mongo.dart';
import 'NavBar.dart';
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
                const Text('Login', style: TextStyle(fontSize: 24)),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      //TODO add the api here to log in 
                       var db = MongoDatabase();
                       var user = await db.loginUser(_usernameController.text, _passwordController.text);
                       if(user != 'User not found'){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NavScreen()));
                       } //TODO errro message for incorrect login
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text('Don\'t have an account? Sign up here')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
