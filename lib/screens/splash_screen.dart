import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/commons/shared_pref.dart';
import 'package:jetdevs/constants/strings.dart';
import 'package:jetdevs/screens/auth/login_%20screen.dart';
import 'package:jetdevs/screens/dashboard/add_profile_screen.dart';
import 'package:jetdevs/screens/dashboard/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

PreferenceUtils preferenceUtils = PreferenceUtils();

class _SplashScreenState extends State<SplashScreen> {
  bool registerKey = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(seconds: 2), () async {
        var isRegister = await preferenceUtils.hasKey(keyLogin);
        var isRecordAdded = await preferenceUtils.hasKey(keyAddRecord);
        if (isRegister) {
          isRegister = await preferenceUtils.readBool(keyLogin);
        }
        if (isRegister) {
          if (!isRecordAdded) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AddProfilePage()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(appName,
              style: GoogleFonts.ibmPlexSans(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
