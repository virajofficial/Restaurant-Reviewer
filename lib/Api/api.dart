import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:restaurant_reviewer/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_reviewer/models/pihArea.dart';
import 'package:restaurant_reviewer/models/restaurant.dart';
import 'package:restaurant_reviewer/models/review.dart';

import '../models/phi.dart';

final BaseOptions options = BaseOptions(baseUrl: 'http://localhost:8080');

final dio = Dio(options);

callApi(method, url, data) async {
  Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic userDetails = jsonDecode(prefs.getString('user_details') ?? '{}');
  print(userDetails);

  Options options =
      Options(headers: {'authorization': userDetails['token'] ?? ''});
  try {
    switch (method) {
      case 'POST':
        response = await dio.post(url, data: data, options: options);
        break;
      case 'PUT':
        response = await dio.put(url, data: data, options: options);
        break;
      case 'DELETE':
        response = await dio.delete(url, options: options);
        break;
      default:
        response = await dio.get(url, options: options);
        break;
    }
    return response.data;
  } catch (e) {
    return e;
  }
}

Future<dynamic> registerCall(String name, String userName, String password,
    String email, String contactNo) async {
  var response = await callApi('POST', '/signup', {
    "name": name,
    "userName": userName,
    "password": password,
    "email": email,
    "contactNumber": contactNo
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> loginCall(String userName, String password) async {
  var response = await callApi(
      'POST', '/login', {"userName": userName, "password": password});
  if (response != null && response is! DioException) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_details', jsonEncode(response['data']));
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> getCurrentUserCall(int userId) async {
  var response = await callApi('GET', '/user-details/$userId', null);
  if (response != null && response is! DioException) {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user_profile', jsonEncode(response['data']));
    return response['data'];
  } else {
    throw response;
  }

  //return response['data'].map((x) => User.fromJson(x));
}

Future<List<String>> getPHIAreasCall() async {
  var response = await callApi('GET', '/meta-data', null);
  if (response != null) {
    return List<String>.from(
        response['data']['locations'].map((x) => x.toString()));
  } else {
    return [];
  }
}

Future<List<Restaurant>> getRestaurantsCall() async {
  var response = await callApi('GET', '/restaurant-details', null);
  print('Restaurant Response');
  print(response);
  return List<Restaurant>.from(
      response['data'].map((x) => Restaurant.fromJson(x)));
}

Future<List<Phi>> getPhisCall() async {
  var response = await callApi('GET', '/phi-details', null);
  if (response != null && response is! DioException) {
    return List<Phi>.from(response['data'].map((x) => Phi.fromJson(x)));
  } else {
    throw response;
  }
}

Future<List<Review>> getReviewsCall() async {
  var response = await callApi('GET', '/review', null);
  print('Reviews Response');
  print(response);
  return List<Review>.from(response['data'].map((x) => Review.fromJson(x)));
}

Future<dynamic> addRestaurantCall(
    String resName,
    String resRegNo,
    String resContactNo,
    String resRegDate,
    String resAddress,
    String resPhiArea) async {
  var response = await callApi('POST', '/restaurant-details', {
    "restaurantName": resName,
    "registrationNo": resRegNo,
    "contactNumber": resContactNo,
    "registrationDate": resRegDate,
    "address": resAddress,
    "phiArea": resPhiArea
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> editRestaurantCall(
  int resId,
  String resName,
  String resContactNo,
  String resAddress,
  String resPhiArea,
) async {
  print('resturant id');
  print(resId);
  var response = await callApi('PUT', '/restaurant-details/$resId', {
    "restaurantName": resName,
    "contactNumber": resContactNo,
    "address": resAddress,
    "phiArea": resPhiArea
  });

  if (response != null && response is! DioException) {
    print('editing restaurant data');
    print(response);
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> removeRestaurantCall(
  int resId,
) async {
  var response = await callApi('PUT', '/restaurant-details/$resId', {
    "active": false,
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> addPHICall(
  String phiName,
  String registrationNo,
  String email,
  String contactNo,
  String address,
  String phiArea,
) async {
  var response = await callApi('POST', '/phi-details', {
    "phiName": phiName,
    "registrationNo": registrationNo,
    "email": email,
    "contactNumber": contactNo,
    "address": address,
    "phiArea": phiArea
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> editPHICall(
  int phiId,
  String phiName,
  String contactNo,
  String address,
  String phiArea,
) async {
  var response = await callApi('PUT', '/phi-details/$phiId', {
    "phiName": phiName,
    "contactNumber": contactNo,
    "address": address,
    "phiArea": phiArea
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> removePHICall(
  int phiId,
) async {
  var response = await callApi('PUT', '/phi-details/$phiId', {
    "active": false,
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

Future<dynamic> addReviewCall(
  String restaurantId,
  String reviewDetails,
  String status,
  String phiArea,
) async {
  // dynamic resPre = await reivewPrediction(reviewDetails);
  // print(resPre['prediction']);
  // if (resPre['prediction'] == "Negative") {
  //   status = "bad";
  // } else if (resPre['prediction'] == "Positive") {
  //   status = "good";
  // }
  var response = await callApi('POST', '/review', {
    "restaurantId": restaurantId,
    "reviewDetails": reviewDetails,
    "status": status,
    "phiArea": phiArea,
  });
  if (response != null && response is! DioException) {
    return response['data'];
  } else {
    throw response;
  }
}

// Future<dynamic> reivewPrediction(
//   String message,
// ) async {
//   final BaseOptions optionsN = BaseOptions(baseUrl: 'http://localhost:5500');

//   final dioNew = Dio();
//   print('prediction called');
//   try {
//     dynamic predRes = await dioNew
//         .post('http://127.0.0.1:5500/send/', data: {"message": message});
//     print("predicted Res:");
//     if (predRes != null) {
//       return predRes;
//     } else {
//       throw predRes;
//     }
//   } catch (e) {
//     print(e);
//   }
// }

Future<dynamic> forgotPWCall(String userName) async {
  var response =
      await callApi('POST', '/forget-password', {"userName": userName});
  if (response != null && response is! DioException) {
    return response;
  } else {
    throw response;
  }
}

Future<dynamic> resetPWCall(
    String userName, String otp, String newPassword) async {
  var response = await callApi('POST', '/password-reset', {
    "userName": userName,
    "oldPassword": otp,
    "currentPassword": newPassword
  });
  if (response != null && response is! DioException) {
    return response;
  } else {
    throw response;
  }
}
