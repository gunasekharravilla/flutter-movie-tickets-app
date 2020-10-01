import 'package:flutter/material.dart';
import 'package:flutter_movie_tickets/services/services.dart';
import 'package:provider/provider.dart';

import 'ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper()));
  }
}
