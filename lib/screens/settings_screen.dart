import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/providers/auth.dart';

import '../models/profile.dart';
import '../providers/profile_provider.dart';

class SettingsScreen extends StatelessWidget {
  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///             Consts and vars
  ///
  /////////////////////////////////////////////////////////////////////////////////////
  static const routeName = '/settings';

  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
  ///
  ////////////////////////////////////////////////////////////////////////////////////
  void showChangePassword(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
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
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ('Enter old password'),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ('Enter new password'),
                    ),
                  ),
                ),
                Text(
                  'Are you sure ?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Change'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  void showChangeUserName(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ('Enter new username'),
                  ),
                ),
              ),
              Text(
                'Are you sure ?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Change'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
        title: Text(
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
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
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
                    title: Text('Change Username'),
                    trailing: Icon(Icons.edit),
                    onTap: () => showChangeUserName(context),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.amber[800],
                    ),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.edit),
                    onTap: () => showChangePassword(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');

                authenticator.logout();
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
