import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetdevs/commons/shared_pref.dart';
import 'package:jetdevs/commons/utils.dart';
import 'package:jetdevs/commons/widgets/custom_btn.dart';
import 'package:jetdevs/commons/widgets/custom_text_field.dart';
import 'package:jetdevs/constants/colors.dart';
import 'package:jetdevs/constants/strings.dart';
import 'package:jetdevs/screens/auth/login_%20screen.dart';
import 'package:jetdevs/screens/dashboard/home_screen.dart';
import 'package:sizer/sizer.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final skillController = TextEditingController();
  final workExperienceController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  XFile? imageFileList;
  var imagePath = "";
  final _formKeyDetailPage = GlobalKey<FormState>();
  var isProgressBar = false, isAddImageUpload = false, isImageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF16B98D),
        title: Text(addDetailPage,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
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
                              onTap: () {
                                selectImage();
                              },
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
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          selectImage();
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              const Color(0xFF16B98D).withOpacity(0.8),
                          radius: 16, // Radius of the camera icon
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
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
                    controller: nameController,
                    labelText: enterYourName,
                    hint: enterYourName,
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
                    prefixIcon: const Icon(Icons.email_outlined),
                    controller: emailController,
                    labelText: enterYourEmail,
                    hint: enterYourEmail,
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
                    labelText: enterYourSkills,
                    hint: enterYourSkills,
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
                  showCursor: true,
                  cursorColor: const Color(0xFF16B98D),
                  style: const TextStyle(fontSize: 16),
                  decoration: inputDecoration,
                ),
                SizedBox(height: 5.h),
                CustomButton(
                  isLoading: isProgressBar,
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (_formKeyDetailPage.currentState!.validate()) {
                      if (mounted) {
                        setState(() {
                          isProgressBar = true;
                        });
                      }
                      //Json data//
                      Map<String, dynamic> userJsonData = {
                        keyProfileImagePath: imagePath,
                        keyName: nameController.text.trim(),
                        keyEmail: emailController.text.trim(),
                        keySkill: skillController.text.trim(),
                        keyWorkExperience: workExperienceController.text.trim(),
                      };
                      //Json data save in using sharedReference
                      await saveDataManager(userJsonData);
                    }
                  },
                  title: continueLabel.toString().toUpperCase(),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    setState(() {
      isAddImageUpload = true;
    });
    try {
      final XFile? selectedImages =
          await imagePicker.pickImage(source: ImageSource.gallery);
      imageFileList = selectedImages;
      if (imageFileList != null) {
        setState(() {
          imagePath = imageFileList!.path;
          isAddImageUpload = false;
          isImageVisible = true;
        });
        if (kDebugMode) {
          print("imageFileList path=> ${imageFileList!.path}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (mounted) {
      setState(() {
        isAddImageUpload = false;
      });
    }
  }

  Future<void> saveDataManager(Map<String, dynamic> userJsonData) async {
    try {
      await saveJsonToSharedPreferences(userJsonData);
      Future.delayed(const Duration(seconds: 2), () async {
        if (mounted) {
          setState(() {
            isProgressBar = false;
            showToastMsg(
              context,
              color: greenColor,
              title: addProfile,
              isAlert: false,
              msgDesc: profileDataSavedSuccessful,
            );
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> getData() async {
    try {
      Map<String, dynamic>? retrievedData =
          await getJsonFromSharedPreferences();
      Future.delayed(const Duration(seconds: 2), () async {
        if (retrievedData != null) {
          if (kDebugMode) {
            print('Retrieved JSON data: $retrievedData');
          }
        } else {
          if (kDebugMode) {
            print('No JSON data found in shared preferences.');
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
