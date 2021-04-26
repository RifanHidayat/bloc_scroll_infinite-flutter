import 'package:bloc/bloc.dart';
import 'package:bloc_infinite/bloc/post_bloc.dart';
import 'package:bloc_infinite/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  ScrollController controller=ScrollController();
  PostBloc bloc;

  void onScroll(){
    double maxcScroll=controller.position.maxScrollExtent;
    double currentScroll =controller.position.pixels;
    if (currentScroll ==  maxcScroll) bloc.add(PostEvent());

  }
  @override
  Widget build(BuildContext context) {
    bloc  =BlocProvider.of<PostBloc>(context);
    controller.addListener(() {onScroll()});
    return Scaffold(
      appBar: AppBar(
        title: Text("Ifnite  list witch bloc"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostUninitialized) {
              return Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              PostLoaded postLoaded = state as PostLoaded;
              return ListView.builder(
                controller: controller,
                itemCount: (postLoaded.hasReachedMax)?postLoaded.posts.length:postLoaded.posts.length+1,
                  itemBuilder: (context, index) =>(index < postLoaded.posts.length) ?
                  PostItem(post: postLoaded.posts[index],):Container(
                    child: Center(child: SizedBox(height: 30,width: 30 ,child: CircularProgressIndicator(),)),
                  )
              );
            }
          },
        ),
      ),
    );
  }
}
