// lib/logic/bloc/todo_event.dart

import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodos extends TodoEvent {
  final int userId;

  const FetchTodos(this.userId);

  @override
  List<Object> get props => [userId];
}
