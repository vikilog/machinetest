import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/widgets/appbar.dart';

import '../services/auth.dart';
import '../services/locator.dart';
import '../services/navigation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  currentUser() async {
    var user = await locator<Auth>().currentUser();
    setState(() {
      this.user = user;
      loading = false;
    });
  }

  @override
  void initState() {
    currentUser();
    super.initState();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            onPressed: () async {
              await locator<Auth>().signOut();
              locator<NavigationService>().navigateToAndRemove('/login');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Email'),
            subtitle: Text(loading ? "Loading ..." : user!.email!),
          )
        ],
      ),
    );
  }
}
