import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_tickets/bloc/page_bloc.dart';
import 'package:flutter_movie_tickets/bloc/user_bloc.dart';
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
        child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => PageBloc()),
              BlocProvider(create: (_) => UserBloc())
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false, home: Wrapper())));
  }
}
