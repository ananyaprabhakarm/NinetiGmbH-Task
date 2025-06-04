import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninetigmbh_task/data/services/user_service.dart';
import 'package:ninetigmbh_task/logic/bloc/user_bloc.dart';
import 'package:ninetigmbh_task/logic/bloc/user_event.dart';
import 'package:ninetigmbh_task/logic/bloc/user_state.dart';
import 'package:ninetigmbh_task/logic/cubit/theme_cubit.dart';
import 'package:ninetigmbh_task/presentation/widgets/user_tile.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late ScrollController _scrollController;
  late UserBloc _userBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc(UserService());
    _userBloc.add(const FetchUsers());

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // Only trigger pagination if not searching
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          _searchController.text.isEmpty) {
        _userBloc.add(const FetchUsers());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => _userBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
          ],
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    _userBloc.add(const FetchUsers());
                  } else {
                    _userBloc.add(SearchUsers(value));
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading && state is! UserLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    if (state.users.isEmpty) {
                      return const Center(child: Text('No users found.'));
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) =>
                          UserTile(user: state.users[index]),
                    );
                  } else if (state is UserError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
