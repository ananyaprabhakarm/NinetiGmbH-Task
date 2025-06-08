import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninetigmbh_task/data/models/user_model.dart';
import 'package:ninetigmbh_task/data/services/user_service.dart';
import 'package:ninetigmbh_task/logic/bloc/post_bloc.dart';
import 'package:ninetigmbh_task/logic/bloc/post_event.dart';
import 'package:ninetigmbh_task/logic/bloc/post_state.dart';
import 'package:ninetigmbh_task/logic/bloc/todo_bloc.dart';
import 'package:ninetigmbh_task/logic/bloc/todo_event.dart';
import 'package:ninetigmbh_task/logic/bloc/todo_state.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user, required int userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostBloc(UserService())..add(FetchPosts(user.id)),
        ),
        BlocProvider(
          create: (_) => TodoBloc(UserService())..add(FetchTodos(user.id)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('${user.firstName} ${user.lastName}')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.image),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(user.email),
                        // Text(user.phone),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Posts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(post.title),
                            subtitle: Text(post.body),
                          ),
                        );
                      },
                    );
                  } else if (state is PostError) {
                    return Text(state.message);
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Todos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return CheckboxListTile(
                          title: Text(todo.todo),
                          value: todo.completed,
                          onChanged: null,
                        );
                      },
                    );
                  } else if (state is TodoError) {
                    return Text(state.message);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
