// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydesapp/services/auth/auth_service.dart';

import '../constants/routes.dart';
import '../enums/menu_action.dart';
import '../main.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY NOTE'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            // devtools.log(value.toString());
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (_) => false,
                  );
                }
              // if (shouldLogout) {
              //   await FirebaseAuth.instance.signOut();
              //   Navigator.of(context).pushNamedAndRemoveUntil(
              //     loginRoute,
              //         (_) => false,
              //   );
              // }
              // devtools.log(shouldLogout.toString());
              //  break;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log out'),
              )
            ];
          })
        ],
      ),
      body: const Text('Hello world !'),
    );
  }
}

Future<bool> showLogDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to Sign out'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil(
              //   '/login/',
              //       (route) => false,
              // );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
