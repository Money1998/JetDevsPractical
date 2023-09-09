// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:jetdevs/commons/shared_pref.dart';
// import 'package:jetdevs/constants/strings.dart';
// import 'package:jetdevs/model/refresh_token_model.dart';
// import 'package:jetdevs/services/masterservice.dart';
//
// import '../../constants/server_url.dart';
//
// class AuthDataRepo {
//   PreferenceUtils preferenceUtils = PreferenceUtils();
//   ApiResponseService masterService = ApiResponseService();
//   Map<String, dynamic> mapData = {};
//
//   Future<RefreshToken> refreshTokenPostAPI(
//       {String? endURL, String? refreshToken}) async {
//     mapData["refreshToken"] = refreshToken;
//     var response = await http
//         .post(Uri.parse(baseUrl + endURL!),
//             headers: <String, String>{
//               HttpHeaders.contentTypeHeader: 'application/json',
//             },
//             body: json.encode(mapData))
//         .timeout(apiTimeout);
//     if (kDebugMode) {
//       print("URL=>${baseUrl + endURL}");
//       print("response=>${response.body}");
//     }
//     return RefreshToken.fromJson(jsonDecode(response.body));
//   }
// }
