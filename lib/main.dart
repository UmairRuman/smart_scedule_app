import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:smart_club_app/core/functions/test_function.dart';
import 'package:smart_club_app/core/services/service_locater.dart';
import 'package:smart_club_app/core/services/shared_prefrence_Service.dart';
import 'package:smart_club_app/firebase_options.dart';
import 'package:smart_club_app/pages/welcome_page/view/welcome_page.dart';
import 'package:smart_club_app/util/theme.dart';

const globalUserId = "Macha Dev";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Seting up service locator
  setupLocator();
  await loadCertificateAndUseIt();
  runApp(ProviderScope(child: const ClubApp()));
}

class ClubApp extends StatelessWidget {
  const ClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    var prefs = serviceLocator.get<SharedPrefrenceService>();
    //Intiallizing shared preferences if values are null
    if (!prefs.isAdminKeyInPrefs() || prefs.getAdminKeyFromPrefs() == "") {
      prefs.insertAdminkeyInPrefs();
    }
    if (!prefs.isCurrentPretimerInPrefs()) {
      prefs.insertCurrentPretimer(5);
    }

    testFileAccess();
    FullScreenWindow.setFullScreen(false);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const WelcomePage(),
    );
  }
}
