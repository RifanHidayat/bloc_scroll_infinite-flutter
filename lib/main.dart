import 'package:bloc_infinite/bloc/post_bloc.dart';
import 'package:bloc_infinite/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<PostBloc>(
          builder: (context) => PostBloc()..add(PostEvent()),
          child: MainPage()),
    );
  }
}
