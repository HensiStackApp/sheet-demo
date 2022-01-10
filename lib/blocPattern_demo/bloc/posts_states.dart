import 'package:sheet_widget_demo/blocPattern_demo/model/posts_model.dart';

enum PostsStatus { initial, success, failure }

class PostsStates {
  PostsStatus postsStatus;
  List<PostsModel> postsLists;
  bool hasReachedMax;

  PostsStates({
    this.postsStatus = PostsStatus.initial,
    this.postsLists = const <PostsModel>[],
    this.hasReachedMax = false,
  });

  PostsStates copyWith({
    PostsStatus postsStatus,
    List<PostsModel> postsLists,
    bool hasReachedMax,
  }) {
    return PostsStates(
      postsStatus: postsStatus ?? this.postsStatus,
      postsLists: postsLists ?? this.postsLists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
