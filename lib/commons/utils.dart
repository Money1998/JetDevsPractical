import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/commons/permission_handler/app_permission.dart';
import 'package:jetdevs/commons/shared_pref.dart';
import 'package:jetdevs/constants/colors.dart';
import 'package:jetdevs/constants/strings.dart';

FToast fToast = FToast();

RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
    side: const BorderSide(color: lightGrey, width: 0.5));

// dynamic returnResponse(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       dynamic responseJson = jsonDecode(response.body);
//       return responseJson;
//     case 201:
//       dynamic responseJson = jsonDecode(response.body);
//       return responseJson;
//     case 204:
//       dynamic responseJson = jsonDecode('{}');
//       return responseJson;
//     case 400:
//       // throw BadRequestException(
//       //     jsonDecode(response.body)['message'] ?? response.body.toString());
//       dynamic responseJson = jsonDecode(response.body);
//       return responseJson;
//     case 401:
//     case 403:
//       throw UnauthorisedException(
//           'You are not authorised to view this. Please logout and login again.');
//     case 500:
//     default:
//       throw FetchDataException('Error occurred while communication with server'
//           ' with status code : ${response.statusCode}');
//   }
// }

Widget loading() => const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: Color(0xFF16B98D),
      ),
    );

Widget noDataFoundWidget() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "noDataFound",
      ),
    );

Widget toast(BuildContext context,
    {String? msgD, String? title, Color? backgroundColor, bool? isAlert}) {
  return FractionallySizedBox(
    widthFactor: 0.8,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 0.2,
            offset: Offset(0.2, 0.2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAlert == true ? Icons.privacy_tip : Icons.done,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title ?? "",
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 05,
                    ),
                    Text(msgD ?? "",
                        style: GoogleFonts.ibmPlexSans(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              child: const Icon(Icons.close, color: Colors.white),
              onTap: () {
                fToast.removeCustomToast();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

InputDecoration inputDecoration = const InputDecoration(
  fillColor: colorBg,
  filled: true,
  isDense: true,
  hintText: enterYourWorkExperience,
  labelText: enterYourWorkExperience,
  contentPadding: EdgeInsets.all(8),
  border: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(width: 0, color: Colors.grey),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(width: 0, color: Colors.grey),
  ),
);

Future<void> showToastMsg(
  BuildContext context, {
  String? msgDesc,
  String? title,
  bool? isAlert,
  Color? color,
}) async {
  fToast.init(context);
  fToast.showToast(
    child: toast(context,
        msgD: msgDesc, title: title, backgroundColor: color, isAlert: isAlert),
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}

Future<void> saveJsonToSharedPreferences(Map<String, dynamic> jsonData) async {
  String jsonString = json.encode(jsonData);
  await PreferenceUtils().save(keyUserJsonData, jsonString);
  await PreferenceUtils().saveBool(keyAddRecord, true);
}

Future<Map<String, dynamic>?> getJsonFromSharedPreferences() async {
  String jsonString = await PreferenceUtils().read(keyUserJsonData);
  if (jsonString != null) {
    return json.decode(jsonString);
  }
}

Future<void> permissionCheckAndGet() async {
  if (Platform.isAndroid) {
    // await PermissionHandler().getPermission().then(
    //     (value) => print("Below 33 android storage permission flag=>$value"));
  }
}
