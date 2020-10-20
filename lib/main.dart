import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_tickets/bloc/movie_bloc.dart';
import 'package:flutter_movie_tickets/bloc/page_bloc.dart';
import 'package:flutter_movie_tickets/bloc/theme_bloc.dart';
import 'package:flutter_movie_tickets/bloc/user_bloc.dart';
import 'package:flutter_movie_tickets/services/services.dart';
import 'package:provider/provider.dart';

import 'ui/pages/pages.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      exit(1);
    }
  };
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
              BlocProvider(create: (_) => UserBloc()),
              BlocProvider(create: (_) => ThemeBloc()),
              BlocProvider(
                create: (_) => MovieBloc()..add(FetchMovies()),
              )
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper()),
            )));
  }
}
