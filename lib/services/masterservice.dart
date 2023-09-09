// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
//
// // import 'package:http/http.dart' as http;
// // import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:jetdevs/commons/shared_pref.dart';
// import 'package:jetdevs/constants/server_url.dart';
// import 'package:jetdevs/constants/strings.dart';
// import 'package:jetdevs/services/repositories/auth_repo.dart';
// import '../commons/utils.dart';
//
// class ApiResponseService {
//   PreferenceUtils preferenceUtils = PreferenceUtils();
//
//   Future putAPIResponse({Map<String, dynamic>? data, String? endURL}) async {
//     dynamic responseJson;
//     String token = await preferenceUtils.read(keyUserToken);
//     if (kDebugMode) {
//       print("token => $token");
//     }
//     String refreshToken = await preferenceUtils.read(keyRefreshToken);
//
//     bool check = await jwtTokenExpirationCheck(jwtToken: token);
//     if (check) {
//       await AuthDataRepo()
//           .refreshTokenPostAPI(
//               refreshToken: refreshToken, endURL: refreshTokenReqURL)
//           .then((value) async {
//         if (!value.error!) {
//           token = value.accessToken!;
//           await preferenceUtils.save(keyUserToken, value.accessToken);
//           await preferenceUtils.saveBool(isLogin, true);
//         } else {
//           await preferenceUtils.removeAll();
//         }
//       });
//     }
//
//     var response = await http
//         .put(Uri.parse(baseUrl + endURL!),
//             headers: <String, String>{
//               HttpHeaders.contentTypeHeader: 'application/json',
//               HttpHeaders.authorizationHeader: 'Bearer $token'
//             },
//             body: json.encode(data))
//         .timeout(apiTimeout);
//     if (kDebugMode) {
//       print("URL=>${baseUrl + endURL}");
//       print("body data=>$data");
//       print("response=>${response.body}");
//     }
//     responseJson = returnResponse(response);
//     return responseJson;
//   }
//
//   Future<dynamic> postAPIResponse(
//       {Map<String, dynamic>? data, String? endURL}) async {
//     dynamic responseJson;
//     String token = await preferenceUtils.read(keyUserToken);
//     // if (kDebugMode) {
//     //   print("token => $token");
//     // }
//     // String refreshToken = await preferenceUtils.read(keyRefreshToken);
//     // bool check = await jwtTokenExpirationCheck(jwtToken: token);
//     // if (check) {
//     //   await AuthDataRepo()
//     //       .refreshTokenPostAPI(
//     //           refreshToken: refreshToken, endURL: refreshTokenReqURL)
//     //       .then((value) async {
//     //     if (!value.error!) {
//     //       token = value.accessToken!;
//     //       await preferenceUtils.save(keyUserToken, value.accessToken);
//     //       await preferenceUtils.saveBool(isLogin, true);
//     //     } else {
//     //       await preferenceUtils.removeAll();
//     //     }
//     //   });
//     // }
//
//     var response = await http
//         .post(Uri.parse(baseUrl + endURL!),
//             headers: <String, String>{
//               HttpHeaders.contentTypeHeader: 'application/json',
//               HttpHeaders.authorizationHeader: 'Bearer $token'
//             },
//             body: json.encode(data))
//         .timeout(apiTimeout);
//     if (kDebugMode) {
//       print("URL=>${baseUrl + endURL}");
//       print("body data=>$data");
//       print("response=>${response.body}");
//       print("response Status Code=>${response.statusCode}");
//     }
//
//     responseJson = returnResponse(response);
//     return responseJson;
//   }
//
//   Future<dynamic> getAPIResponse({String? endURL}) async {
//     dynamic responseJson;
//     String token = await preferenceUtils.read(keyUserToken);
//     // if (kDebugMode) {
//     //   print("token => $token");
//     // }
//     // String refreshToken = await preferenceUtils.read(keyRefreshToken);
//     // bool check = await jwtTokenExpirationCheck(jwtToken: token);
//     // if (check) {
//     //   await AuthDataRepo()
//     //       .refreshTokenPostAPI(
//     //           refreshToken: refreshToken, endURL: refreshTokenReqURL)
//     //       .then((value) async {
//     //     if (!value.error!) {
//     //       token = value.accessToken!;
//     //       await preferenceUtils.save(keyUserToken, value.accessToken);
//     //       await preferenceUtils.saveBool(isLogin, true);
//     //     } else {
//     //       await preferenceUtils.removeAll();
//     //     }
//     //   });
//     // }
//     responseJson = await http.get(
//       Uri.parse(baseUrl + endURL!),
//       headers: <String, String>{
//         HttpHeaders.contentTypeHeader: 'application/json',
//         HttpHeaders.authorizationHeader: 'Bearer $token'
//       },
//     ).timeout(apiTimeout);
//     if (kDebugMode) {
//       print("URL=>${baseUrl + endURL}");
//       print("response=>${responseJson.body}");
//     }
//     return returnResponse(responseJson);
//   }
//
//   Future<bool> jwtTokenExpirationCheck({String? jwtToken}) async {
//     bool isExpire = false;
//     // if (JwtDecoder.isExpired(jwtToken!)) {
//     //   isExpire = true;
//     // }
//     if (kDebugMode) {
//       print("isExpire=> $isExpire");
//     }
//     return isExpire;
//   }
//
//   Future<dynamic> jwtTokenExpirationDecode({String? jwtToken}) async {
//     dynamic responseJson;
//     // responseJson = JwtDecoder.decode(jwtToken!);
//     return responseJson;
//   }
// }
