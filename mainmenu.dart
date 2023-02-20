import 'package:assignment_2/config.dart';
import 'package:assignment_2/user.dart';
import 'package:flutter/material.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  const MainMenuWidget({super.key, required this.user});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  late double screenHeight;
  var pathAsset = "assets/images/profile.png";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: 250,
      elevation: 10,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(widget.user.email.toString()),
            accountName: Text(widget.user.name.toString()),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              child: ClipOval(
                child: Image.network(
                  "${Config.SERVER}/assets/profileimages/${widget.user.id}.png",
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(pathAsset);
                  },
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Buyer'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Seller'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {},
          ),
          const Divider(
            color: Colors.blue,
          ),
          SizedBox(
            height: screenHeight / 2.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Text("Version 0.1b")],
            ),
          )
        ],
      ),
    );
  }
}
