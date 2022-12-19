import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mydesapp/constants/routes.dart';
import 'package:mydesapp/views/login_view.dart';
import 'package:mydesapp/views/register_view.dart';
import 'package:mydesapp/views/verify_email_view.dart';
import 'firebase_options.dart';
// import 'dart:developer' as devtools show log;
// import 'dart:developer' show log;
// import 'dart:developer';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomePage(),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          notesRoute: (context) => const NoteView(),
          verifyEmailRoute: (context) => const VerifyEmailView(),
        }),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                 return const NoteView();
                // print('You are a verified user');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
              // print('Verify your email');
            }
            //  return const NoteView();
            // print(FirebaseAuth.instance.currentUser);
            // final user = FirebaseAuth.instance.currentUser;
            // final emailVerified = user?.emailVerified ?? false;
            // if (user.emailVerified) {
            //   print('You are a verified user');
            // }
            // final user = FirebaseAuth.instance.currentUser;
            // print(user);
            // if (user?.emailVerified ?? false) {
            //   return const Text('Done');
            //    // print('You are a verified user');
            // } else {
            //   // print('Verify your email');
            //    return const VerifyEmailView();
            // }

            // Anonymous route
            //        final user = FirebaseAuth.instance.currentUser;
            //         if (user?.emailVerified ?? false) {
            //        } else {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) => const VerifyEmailView(),
            //   ),
            //       Anonymous route
            // );

            // return const Text('Welcome !');
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

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
          PopupMenuButton<MenuAction>(
              onSelected: (value) async {
            // devtools.log(value.toString());
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                          (_) => false,
                  );
                }
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
              onPressed: ()  {
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
