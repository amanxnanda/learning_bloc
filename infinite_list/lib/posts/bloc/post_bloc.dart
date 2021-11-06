import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import 'package:infinite_list/posts/posts.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 20;

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.httpClient}) : super(const PostState()) {
    on<PostFetched>(_onPostFetched, transformer: throttleDroppable(throttleDuration));
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();

        return emit(PostState(status: PostStatus.success, posts: posts, hasReachedMax: false));
      }

      final posts = await _fetchPosts(state.posts.length);

      return posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(status: PostStatus.success, posts: List.of(state.posts)..addAll(posts), hasReachedMax: false),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  /// helper functions
  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;
      return body.map((e) => Post.fromMap(e as Map<String, dynamic>)).toList();
    }

    throw Exception('error fetching posts');
  }
}
