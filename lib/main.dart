import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/mobx/note_controller.dart';
import 'package:project/screen_router.dart';
import 'package:provider/provider.dart';

Future main() async {
  // ca-app-pub-7114356792970424~5672152903 - sdk
  // ca-app-pub-7114356792970424/7369266007 - banner
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: (Platform.isIOS || Platform.isMacOS)
        ? const FirebaseOptions(
            apiKey: "AIzaSyCuKq9BAlNFPieJtO5Nulq391P46pDD3E4",
            appId: "1:751140972272:ios:d848703354f41bf10a8435",
            messagingSenderId: "751140972272",
            projectId: "notio-app-7aa0f",
          )
        : const FirebaseOptions(
            apiKey: 'AIzaSyDGzjl9FMkI7Wz4008NVYFHp4VjUR2byBo',
            appId: '1:751140972272:android:08ed7d8fb1859d4e0a8435',
            messagingSenderId: '751140972272',
            projectId: 'notio-app-7aa0f',
          ),
  ).whenComplete(() {
    runApp(MultiProvider(providers: [
      Provider<NoteData>(
        create: (_) => NoteData(),
      )
    ], child: const ScreenRouter()));
  });
}
