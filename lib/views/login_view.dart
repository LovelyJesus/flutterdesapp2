import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:developer' as devtools show log;
import 'package:mydesapp/constants/routes.dart';
import 'package:mydesapp/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';
import 'package:mydesapp/services/auth/auth_exceptions.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );

                // await FirebaseAuth.instance.signInWithEmailAndPassword(
                //   email: email,
                //   password: password,
                // );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // user's email is verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                        (route) => false,
                  );
                } else {
                  // user's email is not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                        (route) => false,
                  );
                }
                // final user = FirebaseAuth.instance.currentUser;
                // if (user?.emailVerified ?? false) {
                //   // user's email is verified
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //     notesRoute,
                //         (route) => false,
                //   );
                // } else {
                //   // user's email is not verified
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //     verifyEmailRoute,
                //         (route) => false,
                //   );
                // }
                // final userCredential =
                // await FirebaseAuth.instance.signInWithEmailAndPassword(
                //   email: email,
                //   password: password,
                // );

                // devtools.log(userCredential.toString());
                // print(userCredential);
              } on UserNotFoundAuthException {
                await showErrorDialog(context,
                    'User not found',
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(context,
                  'Wrong password',
                );
              } on GenericAuthException {
                await showErrorDialog(context,
                  'Authentication Error',
                );
              }
              // on FirebaseAuthException catch (e) {
              //   if (e.code == 'user-not-found') {
              //     // devtools.log('User not found');
              //     await showErrorDialog(
              //       context,
              //       'User not found',
              //     );
              //   } else if (e.code == 'wrong-password') {
              //     // devtools.log('Wrong password');
              //     await showErrorDialog(
              //       context,
              //       'Wrong password',
              //     );
              //   } else if (e.code == 'port:443') {
              //     await showErrorDialog(
              //       context,
              //       'Data connection not solid ',
              //     );
              //   } else {
              //     await showErrorDialog(
              //       context,
              //       'Error: ${e.code}',
              //     );
              //   }
                // if (e.code == 'user-not-found') {
                //   print('User not found');
                // } else if (e.code == 'wrong-password') {
                //   print('Wrong password');
                // }
              // } catch (e) {
              //   await showErrorDialog(
              //     context,
              //     e.toString(),
              //   );
              // }
              // catch (e) {
              //   print('something bad happened');
              //   print(e.runtimeType);
              //   print(e);
              // }
              // Navigator.of(context)
              //     .pushNamedAndRemoveUntil(
              //   '/note/',
              //       (route) => false,
              // );
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text(" I Don't have an account Sign up"),
          )
        ],
      ),
    );
  }
}


// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> {
//   late final TextEditingController _email;
//   late final TextEditingController _password;
//
//   @override
//   void initState() {
//     _email = TextEditingController();
//     _password = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _email.dispose();
//     _password.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: FutureBuilder(
//         future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform,
//         ),
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               return Column(
//                 children: [
//                   TextField(
//                     controller: _email,
//                     enableSuggestions: false,
//                     autocorrect: false,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your email here',
//                     ),
//                   ),
//                   TextField(
//                     controller: _password,
//                     obscureText: true,
//                     enableSuggestions: false,
//                     autocorrect: false,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your password here',
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       final email = _email.text;
//                       final password = _password.text;
//                       try {
//                         final userCredential = await FirebaseAuth.instance
//                             .signInWithEmailAndPassword(
//                           email: email,
//                           password: password,
//                         );
//                         print(userCredential);
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'user-not-found') {
//                           print('User not found');
//                         } else if (e.code == 'wrong-password'){
//                           print('Wrong password');
//                         }
//                       }
//                       // catch (e) {
//                       //   print('something bad happened');
//                       //   print(e.runtimeType);
//                       //   print(e);
//                       // }
//                     },
//                     child: const Text('Sign In'),
//                   ),
//                 ],
//               );
//             default:
//               return const Text('Loading...');
//           }
//         },
//       ),
//     );
//   }
// }
