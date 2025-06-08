// lib/logic/bloc/todo_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../../data/services/user_service.dart';
import '../../data/models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserService userService;

  TodoBloc(this.userService) : super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodos);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());

    try {
      final List<Todo> todos = await userService.fetchUserTodos(event.userId);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }
}

// TODO Implement this library.
