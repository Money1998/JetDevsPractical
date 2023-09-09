import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/commons/shared_pref.dart';
import 'package:jetdevs/commons/utils.dart';
import 'package:jetdevs/commons/widgets/custom_btn.dart';
import 'package:jetdevs/commons/widgets/custom_text_field.dart';
import 'package:jetdevs/constants/assets_images.dart';
import 'package:jetdevs/constants/colors.dart';
import 'package:jetdevs/constants/strings.dart';
import 'package:jetdevs/screens/dashboard/add_profile_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLogin = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailAddressFocusNode = FocusNode();
  bool passwordVisible = false,
      isProgressBar = false,
      forgotPasswordFlag = false,
      rememberMe = false;

  @override
  void initState() {
    super.initState();
    initMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(child: loginWidget()),
      ),
    );
  }

  Widget loginWidget() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const ShapeDecoration(
              color: Color(0xFF16B98D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(70),
              child: Lottie.asset(
                lottieLogin,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFCFDDE2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      login,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ibmPlexSans(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Container(
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignCenter,
                              color: Color(0xFFCFDDE2),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  child: CustomTextField(
                    fillColor: colorBg,
                    controller: emailAddressController,
                    labelText: emailLabel,
                    hint: emailLabel,
                    obscure: false,
                    iconVisible: false,
                    prefixIcon: const Icon(Icons.email_outlined),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emailRequiredMSg;
                      } else if (!emailRegExp.hasMatch(value)) {
                        return validEmailMSg;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  child: CustomTextField(
                    fillColor: colorBg,
                    controller: passwordController,
                    labelText: passwordLabel,
                    hint: passwordLabel,
                    obscure: !passwordVisible,
                    iconVisible: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return passwordRequiredMSg;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 02.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.grey),
                        child: Checkbox(
                          onChanged: handleRememberMe,
                          value: rememberMe,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      rememberMeLabel,
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 12.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomButton(
                  isLoading: isProgressBar,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKeyLogin.currentState!.validate()) {
                      loginManager();
                    }
                  },
                  title: login.toString().toUpperCase(),
                ),
                SizedBox(
                  height: 03.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleRememberMe(bool? value) async {
    rememberMe = value!;
    await PreferenceUtils().saveBool(keyRememberMe, value);
    await PreferenceUtils()
        .save(keyUserEmail, emailAddressController.text.trim());
    await PreferenceUtils().save(keyPassword, passwordController.text);
    rememberMe = value;
    setState(() {
      rememberMe = value;
    });
  }

  void loginManager() {
    if (mounted) {
      setState(() {
        isProgressBar = true;
      });
    }
    try {
      Future.delayed(const Duration(seconds: 2), () async {
        if (emailAddressController.text.trim() ==
                "developers+rahul.makvana@hminfotech.co.in" &&
            passwordController.text.trim() == "rahulmakwana") {
          await PreferenceUtils().saveBool(keyLogin, true);
          if (mounted) {
            setState(() {
              isProgressBar = false;
              showToastMsg(
                context,
                color: greenColor,
                title: login,
                isAlert: false,
                msgDesc: loginSuccessful,
              );
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProfilePage()));
          }
        } else {
          if (mounted) {
            setState(() {
              isProgressBar = false;
              showToastMsg(
                context,
                color: redColor,
                title: login,
                isAlert: true,
                msgDesc: invalidCredentials,
              );
            });
          }
        }
        if (emailAddressController.text.isNotEmpty) {
          emailAddressController.clear();
        }
        if (passwordController.text.isNotEmpty) {
          passwordController.clear();
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void initMethod() {
    permissionCheckAndGet();
    if (kDebugMode) {
      emailAddressController.text = "developers+rahul.makvana@hminfotech.co.in";
      passwordController.text = "rahulmakwana";
    }
  }
}
