import 'package:flutter/material.dart';
import 'package:flutter_movie_tickets/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signUp(
                        "azisdoer@gmail.com",
                        "12345678",
                        "azis",
                        ["Action", "Drama", "War", "Music"],
                        "English");

                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  }),
              RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signIn(
                      "azisdoer@gmail.com",
                      "12345678",
                    );

                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  }),
              RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () async {
                    return await AuthServices.signOut();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
