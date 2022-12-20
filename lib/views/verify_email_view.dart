// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mydesapp/constants/routes.dart';
import 'package:mydesapp/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Email Verification',
        ),
      ),
      body: Column(
        children: [
          const Text(
            'An email verification has been sent to you,please verify',
          ),
          const Text(
            'If email verification not received yet by you,press the button below:',
          ),
          TextButton(
            onPressed: () async {
              AuthService.firebase().currentUser;
              await AuthService.firebase().sendEmailVerification();
            },
            // onPressed: () async {
            //   final user = FirebaseAuth.instance.currentUser;
            //   await user?.sendEmailVerification();
            // },
            child: const Text(
              'Send email verification',
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            // onPressed: () async {
            //   await FirebaseAuth.instance.signOut();
            //   Navigator.of(context).pushNamedAndRemoveUntil(
            //     registerRoute,
            //         (route) => false,
            //   );
            // },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
