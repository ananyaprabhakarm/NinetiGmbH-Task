// lib/logic/bloc/post_event.dart

import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {
  final int userId;

  const FetchPosts(this.userId);

  @override
  List<Object> get props => [userId];
}
