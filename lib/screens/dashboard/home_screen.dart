import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/commons/shared_pref.dart';
import 'package:jetdevs/commons/utils.dart';
import 'package:jetdevs/commons/widgets/custom_btn.dart';
import 'package:jetdevs/commons/widgets/custom_text_field.dart';
import 'package:jetdevs/constants/colors.dart';
import 'package:jetdevs/constants/strings.dart';
import 'package:jetdevs/screens/auth/login_%20screen.dart';
import 'package:jetdevs/screens/dashboard/edit_profile_screen.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final skillController = TextEditingController();
  final workExperienceController = TextEditingController();
  var imagePath = "";
  final _formKeyDetailPage = GlobalKey<FormState>();
  var isProgressButton = false,
      isAddImageUpload = false,
      isProgressBar = false,
      isImageVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16B98D),
        title: Text(homePage,
            style: GoogleFonts.ibmPlexSans(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
              Future.delayed(const Duration(seconds: 1)).then((value) {
                PreferenceUtils().removeAll();
              });
            },
          ),
        ],
      ),
      body: isProgressBar
          ? loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Form(
                  key: _formKeyDetailPage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 2.h),
                      Center(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            isImageVisible
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(48.0),
                                    child: Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                      width: 100.0,
                                      height: 100.0,
                                    ),
                                  ) //Image File List
                                : InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {},
                                    child: const CircleAvatar(
                                      radius: 48,
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        name,
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      SizedBox(
                        child: CustomTextField(
                          fillColor: colorBg,
                          readOnly: true,
                          controller: nameController,
                          // labelText: "Enter Your Name",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return nameRequiredMSg;
                            }
                            return null;
                          },
                          obscure: false,
                          iconVisible: false,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        email,
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      SizedBox(
                        child: CustomTextField(
                          fillColor: colorBg,
                          readOnly: true,
                          prefixIcon: const Icon(Icons.email_outlined),
                          controller: emailController,
                          // labelText: "Enter Your Email",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return emailRequiredMSg;
                            } else if (!emailRegExp.hasMatch(value)) {
                              return validEmailMSg;
                            }
                            return null;
                          },
                          obscure: false,
                          iconVisible: false,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        skills,
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      SizedBox(
                        child: CustomTextField(
                          fillColor: colorBg,
                          controller: skillController,
                          readOnly: true,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return skillRequiredMSg;
                            }
                            return null;
                          },
                          obscure: false,
                          iconVisible: false,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        workExperience,
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      TextField(
                        maxLines: 4,
                        controller: workExperienceController,
                        readOnly: true,
                        showCursor: false,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          fillColor: colorBg,
                          filled: true,
                          isDense: true,
                          hintText: '',
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 0, color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(width: 0, color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      CustomButton(
                        isLoading: isProgressButton,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage()),
                              (Route<dynamic> route) => false);
                        },
                        title: editLabel.toString().toUpperCase(),
                      ),
                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> getUserData() async {
    if (mounted) {
      setState(() {
        isProgressBar = true;
      });
    }
    try {
      Map<String, dynamic>? jsData = await getJsonFromSharedPreferences();
      Future.delayed(const Duration(seconds: 2), () async {
        if (mounted) {
          setState(() {
            isProgressBar = false;
            if (jsData != null) {
              if (kDebugMode) {
                print('Retrieved JSON data: $jsData');
              }
              imagePath = jsData[keyProfileImagePath];
              if (imagePath.isNotEmpty) {
                isImageVisible = true;
              }
              nameController.text = jsData[keyName];
              emailController.text = jsData[keyEmail];
              skillController.text = jsData[keySkill];
              workExperienceController.text = jsData[keyWorkExperience];
            } else {
              setState(() {
                isProgressBar = false;
              });
              if (kDebugMode) {
                print('No JSON data found in shared preferences.');
              }
            }
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
