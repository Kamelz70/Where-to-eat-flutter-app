import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_to_eat/providers/auth.dart';

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
                title: Text('Mohamed Kamel'),
                leading: CircleAvatar(
                  child: ClipRRect(
                    child: Image.network(
                        'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-9/68406470_2329293560457857_238321876919648256_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEMJynCO3wr772RkgWuBMF5k6fTKdUXlnCTp9Mp1ReWcO9EoxUbQhdTIs-kvnDs8cl9Nsc4DpfRcEh6rNVrdo9a&_nc_ohc=Ax5-x71qRGkAX-ZFy68&_nc_oc=AQk68tQD5_W47ZfoklJwxVteYayUXApQJu7ggMwwyzkAG8jZWn0wA8RSp2yDLE6T8MI&_nc_ht=scontent.fcai1-2.fna&oh=00_AT8TFgic4bd0h4KqxxqiGeGj_HTbfNmxjChxJJMdlQszqg&oe=622A85B2'),
                    borderRadius: BorderRadius.circular(100.0),
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
