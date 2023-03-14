import 'package:cloud_kitchen/pages/profilepage/profile_page_body.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile'),
          backgroundColor: Color.fromARGB(255, 223, 123, 80),
        ),
        body: ProfilePageBody(),
      ),
      onWillPop: () async {
        return false;
      });
}
