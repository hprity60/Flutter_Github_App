import 'package:flutter/material.dart';

import '../../../utils/GIcons.dart';
import '../../../utils/g_card.dart';
import '../models/repository_response_model.dart';

class RepoDetailPage extends StatelessWidget {
  const RepoDetailPage({Key? key, required this.items}) : super(key: key);
  final RepositoryResponseModel items;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Text(items.name!),
          GCard(
            width: double.infinity,
            radius: 0,
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                GestureDetector(
                  // onTap: () => Navigator.of(context).push(
                  //   UserPage.getPageRoute(context, login: model.owner.login),
                  // ),
                  child: CircleAvatar(
                    child: Image.network(items.owner!.avatarUrl!),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  items.fullName!,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                Text(
                  items.description ?? "",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
               const SizedBox(height: 8),
                // Text(
                //   item.createdAt!,
                //   style: Theme.of(context).textTheme.bodyText2,
                // ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    _iconWithText(
                        context, GIcons.star_fill_24, "${items.fork!} Stars",
                        iconColor: Colors.red, onPressed: () {}),
                    const SizedBox(width: 20),
                    // _iconWithText(
                    //   context,
                    //   GIcons.git_fork_24,
                    //   "${items.fork!} Forks",
                    // ),
                  ],
                ),
              const  SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithText(context, IconData icon, String text,
      {required Color iconColor, required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
