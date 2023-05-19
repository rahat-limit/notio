<h1 align="center"> Notio </h1> <br>
<p align="center">
    <img alt="GitPoint" title="GitPoint" src="https://github.com/rahat-limit/notio/blob/master/git-repo-assets/512x512logo.png" width="450">
</p>

<p align="center">
  Simple and Useful Text Editor in your pocket. Built with Flutter.
</p>

<p align="center">
<!--  Link to AppStore  -->
<!--   <a href="/">
    <img alt="Download on the App Store" title="App Store" src="http://i.imgur.com/0n2zqHD.png" width="140">
  </a> -->

<!--   <a href="/"> <---- link to play market
    <img alt="Get it on Google Play" title="Google Play" src="http://i.imgur.com/mtGRPuM.png" width="140">
  </a> -->
</p>

## Introduction
Welcome to my respository, which I created due to practice of learning flutter. Here you can easily take a look at some images of app itself and read more info about it. Hope you like it🤙

**Available for iOS.**

<p align="center">
  <img src = "https://github.com/rahat-limit/notio/blob/master/git-repo-assets/1024_500_description.png" width=600>
</p>

## ✖️ Features

A few of the things you can do with Notio:

* [Firebase Authentication](https://firebase.google.com) 
* [Firestore DataBase](https://firebase.google.com)
* [Additional Functions as Verify, Reset, Delete.](https://firebase.google.com)
* [Local Storage SQflite](https://pub.dev/packages/sqflite)
* [State-management MobX with Provider](https://mobx.netlify.app)
* [Create, Remove, Update text with TextEditor Quil Html Editor](https://pub.dev/packages/quill_html_editor)
* [AdMob](https://logowik.com/content/uploads/images/google-admob6870.jpg)

<p align="center">
    <img src="https://www.gstatic.com/devrel-devsite/prod/vfe8699a5d354c41f3f953a7a9794768d4d2f39d37577d5708b5539be069912e1/firebase/images/lockup.svg" width=200>
    <img src="https://www.mysql.com/common/logos/logo-mysql-170x115.png" width=200>
    <img src="https://mobx.netlify.app/mobx.svg" width=200>
    <img src="https://logowik.com/content/uploads/images/google-admob6870.jpg" width=200>
</p>

## ✖️ Splash Screen and Home Page
<p align='center'>
    <image src='https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2016.56.19.png' width='200'/>
    <image src='https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2016.58.31.png' width='200'/>
</p>

## ✖️ Authentication
Base authentication using providers as email/password and google.
```dart
Future signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn(
        scopes: ['email'],
        clientId: "",
      ).signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }
```
<p align='center'>
    <image src='https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2016.56.51.png' width='200'/>
    <image src='https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2017.00.24.png' width='200'/>
</p>

## ✖️ Text Editor
For this task, I chose plugin QuilHtmlEditor due to simple and useful html concept of working with text edit.

```dart
  Expanded(
    child: QuillHtmlEditor(
      textStyle: const TextStyle(
          fontSize: 24,
          color: Color(0xff817F7F),
          fontWeight: FontWeight.w500,
          fontFamily: 'MontserratMedium'),
      onEditorCreated: () async {
        if (!widget.isNewNote) {
          await _controller!.setText(widget.note.text);
        }
      },
      hintText: 'Unititled',
      padding: const EdgeInsets.symmetric(horizontal: 10),
      hintTextPadding: const EdgeInsets.only(left: 10),
      hintTextStyle: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.grey),
      controller: _controller!,
      backgroundColor: secondaryColor,
      minHeight: 500,
    ),
  )
```
<p align="center">
  <img src = "https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2017.01.20.png" width=200>
</p>

## ✖️ Advertisement
Decided to add banner ad by MobAds. Which I find the simplest way of integration and most suitable for this kind of app.  
<p align="center">
  <img src = "https://github.com/rahat-limit/notio/blob/master/git-repo-assets/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20-%202023-05-18%20at%2017.02.26.png" width=200>
</p>
<h3>Thank you to all! Please hire me... 🙏</h3>

