// lib/logic/bloc/post_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';
import '../../data/services/user_service.dart';
import '../../data/models/post_model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UserService userService;

  PostBloc(this.userService) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());

    try {
      final List<Post> posts = await userService.fetchUserPosts(event.userId);
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
