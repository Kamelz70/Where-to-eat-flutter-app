import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///             Consts and vars
  static const routeName = 'settings';

  /////////////////////////////////////////////////////////////////////////////////////
  ///
  ///     Functions
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
  ///     Build
  @override
  Widget build(BuildContext context) {
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
                        'https://scontent.fcai1-2.fna.fbcdn.net/v/t1.6435-9/68406470_2329293560457857_238321876919648256_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=174925&_nc_eui2=AeEMJynCO3wr772RkgWuBMF5k6fTKdUXlnCTp9Mp1ReWcO9EoxUbQhdTIs-kvnDs8cl9Nsc4DpfRcEh6rNVrdo9a&_nc_ohc=NJljR0LuKe4AX_ZbigL&_nc_oc=AQn-PO6ty2GwoViD3igjBG7_uPZDjXY8Yz4KBrHBSEDLH_pozAMucnQSqC00CcBQqlc&_nc_ht=scontent.fcai1-2.fna&oh=00_AT8r_Tybi41y5EG3YqrXvqXAIBUBih6ktDMElehQbIApGQ&oe=61E354B2'),
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
              onPressed: () {},
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
