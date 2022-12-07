import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;



class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
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
appBar: AppBar(title: const Text('Sign up'),
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
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
                // print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-email') {
                  devtools.log('Invalid Email');
                } else if (e.code == 'email-already-in-use') {
                  devtools.log('Email already exist');
                } else if (e.code == 'weak-password') {
                  devtools.log('Weak Password');
                }

                // if (e.code == 'invalid-email') {
                //   print('Invalid Email');
                // } else if (e.code == 'email-already-in-use') {
                //   print('Email already exist');
                // } else if (e.code == 'weak-password') {
                //   print('Weak Password');
                // }
                // else {
                //   print(e.code);
                // } to check for handle errors
              }
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                '/login/',
                    (route) => false,
              );
            },
            child: const Text('Sign Up'),
          ),
          TextButton(onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(
              '/login/',
                  (route) => false,
            );

          },
            child: const Text('Already have an account'),
          ),
        ],
      ),
    );
  }
}









// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import '../firebase_options.dart';
//
// class RegisterView extends StatefulWidget {
//   const RegisterView({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterView> createState() => RegisterViewState();
// }
//
// class RegisterViewState extends State<RegisterView> {
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
//         title: const Text('Sign Up'),
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
//                             .createUserWithEmailAndPassword(
//                           email: email,
//                           password: password,
//                         );
//                         print(userCredential);
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'invalid-email') {
//                           print('Invalid Email');
//                         } else if (e.code == 'email-already-in-use') {
//                           print('Email already exist');
//                         } else if (e.code == 'weak-password') {
//                           print('Weak Password');
//                         }
//                         // else {
//                         //   print(e.code);
//                         // } to check for handle errors
//                       }
//                     },
//                     child: const Text('Sign Up'),
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
