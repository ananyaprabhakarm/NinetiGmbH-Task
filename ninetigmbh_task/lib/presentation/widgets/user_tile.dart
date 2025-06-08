import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ninetigmbh_task/presentation/screens/user_detail_screen.dart';
import '../../data/models/user_model.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.image),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text(user.email),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailScreen(userId: user.id, user: user),
          ),
        );
      },
    );
  }
}
