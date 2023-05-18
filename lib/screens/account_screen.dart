import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/auth_screen.dart';
import 'package:project/screens/forgot_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/utils.dart';
import 'package:project/widgets/account_widgets/action_button_widget.dart';
import 'package:project/widgets/account_widgets/button_widget.dart';
import 'package:project/widgets/home_widgets/header_widget.dart';

class AccountScreen extends StatefulWidget {
  static const route = '/account-screen';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? currentUser;
  TextEditingController? _controller;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    checkFirstOpen();
    _controller = TextEditingController();
    currentUser = FirebaseAuth.instance.currentUser;
    await currentUser!.reload();
  }

  Future checkFirstOpen() async {
    await AuthService().isAuthed().then((authed) {
      if (!authed) {
        Navigator.pushNamed(context, AuthScreen.route);
      } else {
        currentUser = FirebaseAuth.instance.currentUser;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future verify() async {
      await AuthService().verifyEmail().whenComplete(() async {
        ScaffoldMessenger.of(context).showSnackBar(snackBar(
            'OK', 'Succeeded, check your email.', () {}, Colors.green));
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBar('OK', 'Error, Something went wrong.', () {}, Colors.red));
      });
    }

    void reset() {
      Navigator.pushNamed(context, ForgotScreen.route);
    }

    Future signout() async {
      await showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Are you sure you want to leave this account?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close')),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .signOut()
                        .whenComplete(() => Navigator.pushReplacementNamed(
                            context, AuthScreen.route))
                        .onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar('OK',
                          'Error, Something went wrong.', () {}, Colors.red));
                    });
                  },
                  child: const Text(
                    'Leave',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          });
    }

    Future updateName(String val) async {
      if (val.isNotEmpty) {
        await currentUser!.updateDisplayName(val);
      }
    }

    Future<void> updateDisplayName() async {
      _controller!.text = '';
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Change Display Name'),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextField(
                    controller: _controller,
                    onSubmitted: (val) {
                      updateName(val);
                      setState(() {});
                    }),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Back'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Rename'),
                onPressed: () {
                  if (_controller!.text.isNotEmpty) {
                    updateName(_controller!.text);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: primeColor,
                  leadingWidth: 100,
                  toolbarHeight: 80,
                ),
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(children: [
                      Center(
                        child: Image.asset(
                          'assets/icons/circle_logo_icon.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const HeaderWidget(
                        text: 'Info',
                        padding: 0,
                        font: 'PlayFair',
                        size: 22,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ButtonWidget(
                        type: 'Email',
                        text: snapshot.data!.email!,
                        callback: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                          type: 'Name:',
                          text: currentUser!.displayName ?? 'no_name',
                          callback: updateDisplayName),
                      const SizedBox(
                        height: 25,
                      ),
                      const HeaderWidget(
                        text: 'Settings',
                        padding: 0,
                        font: 'PlayFair',
                        icon: Icons.settings,
                        size: 22,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FirebaseAuth.instance.currentUser?.emailVerified ?? false
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 23, horizontal: 15),
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Account is Verified',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: 'MontserratMedium',
                                          fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.verified,
                                      size: 28,
                                      color: Colors.green,
                                    )
                                  ]),
                            )
                          : ActionButtonWidget(
                              text: 'Verify Account',
                              color: Colors.green,
                              callback: verify,
                              icon: Icons.verified,
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      ActionButtonWidget(
                          text: 'Reset Password',
                          color: const Color.fromARGB(255, 249, 151, 60),
                          callback: reset,
                          icon: Icons.edit),
                      const SizedBox(
                        height: 10,
                      ),
                      ActionButtonWidget(
                          text: 'Sign Out',
                          color: const Color.fromARGB(255, 160, 120, 120),
                          callback: signout,
                          icon: Icons.exit_to_app),
                      const SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),
                )));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('You are not registered'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, AuthScreen.route),
                      child: const Text('Register'))
                ],
              ),
            );
          }
        });
  }
}
