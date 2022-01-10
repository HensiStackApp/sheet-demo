import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sheet_widget_demo/blocPattern_demo/bloc/posts_bloc.dart';
import 'package:sheet_widget_demo/blocPattern_demo/bloc/posts_events.dart';
import 'package:sheet_widget_demo/blocPattern_demo/bloc/posts_states.dart';

class BlocHomePage extends StatefulWidget {
  @override
  BlocHomePageState createState() => BlocHomePageState();
}

class BlocHomePageState extends State<BlocHomePage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        PostsBloc().add(FetchedPosts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Current Page --> $runtimeType');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Flutter Bloc'), centerTitle: true),
      body: Center(
        child: BlocProvider(
          create: (context) {
            return PostsBloc(httpClient: http.Client())..add(FetchedPosts());
          },
          child: BlocBuilder<PostsBloc, PostsStates>(
            builder: (context, state) {
              switch (state.postsStatus) {
                case PostsStatus.failure:
                  return Center(child: Text('Failed to fetch data'));
                case PostsStatus.success:
                  return ListView.builder(
                    controller: scrollController,
                    itemBuilder: (context, index) => index >= state.postsLists.length
                        ? LoadingPage()
                        : postsList(state.postsLists[index]),
                    itemCount:
                        state.hasReachedMax ? state.postsLists.length : state.postsLists.length,
                  );
                default:
                  return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget postsList(data) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('${data.id}'),
        ),
      ),
      title: Text('${data.title}', maxLines: 1),
      subtitle: Text('${data.body}', maxLines: 3),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        // decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
        child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
      ),
    );
  }
}
