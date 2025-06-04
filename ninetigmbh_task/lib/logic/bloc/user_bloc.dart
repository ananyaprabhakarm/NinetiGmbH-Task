import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninetigmbh_task/data/services/user_service.dart';
import 'package:ninetigmbh_task/logic/bloc/user_event.dart';
import 'package:ninetigmbh_task/logic/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  int skip = 0;
  final int limit = 20;
  bool isFetching = false;

  UserBloc(this.userService) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      if (isFetching) return;
      isFetching = true;

      try {
        if (state is UserLoaded) {
          // Append new users to existing list
          final currentUsers = (state as UserLoaded).users;
          skip += limit;
          final newUsers = await userService.fetchUsers(
            limit: limit,
            skip: skip,
          );
          emit(UserLoaded([...currentUsers, ...newUsers]));
        } else {
          // First load
          skip = 0;
          final users = await userService.fetchUsers(limit: limit, skip: skip);
          emit(UserLoaded(users));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      } finally {
        isFetching = false;
      }
    });

    on<SearchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userService.searchUsers(event.query);
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
