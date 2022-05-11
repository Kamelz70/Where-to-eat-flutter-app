import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/providers/auth.dart';

import '../providers/profile_provider.dart';

class SettingsScreen extends StatelessWidget {
  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///             Consts and vars
  ///
  /////////////////////////////////////////////////////////////////////////////////////
  static const routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////////
  void showChangePassword(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ('Enter old password'),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ('Enter new password'),
                    ),
                  ),
                ),
                const Text(
                  'Are you sure ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Change'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  void showChangeUserName(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ('Enter new username'),
                  ),
                ),
              ),
              const Text(
                'Are you sure ?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Change'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ]),
          );
        });
  }

  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///     Build Method
  ///
  ////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final authenticator = Provider.of<Auth>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final profile = profileProvider.viewedProfile;
// final profile = context.watch<Profile>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(profile.name),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: ClipRRect(
                    child: Image.network(
                      /////image here
                      profile.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (_, as, asd) {
                        return Icon(Icons.person,
                            size: 20,
                            color: Theme.of(context).colorScheme.onPrimary);
                      },
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.amber[800],
                    ),
                    title: const Text('Change Username'),
                    trailing: const Icon(Icons.edit),
                    onTap: () => showChangeUserName(context),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.amber[800],
                    ),
                    title: const Text('Change Password'),
                    trailing: const Icon(Icons.edit),
                    onTap: () => showChangePassword(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');

                authenticator.logout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
