import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_box_test/models/pihArea.dart';
import 'package:sized_box_test/models/restaurant.dart';
import 'package:sized_box_test/models/review.dart';

import '../models/phi.dart';

final BaseOptions options = BaseOptions(baseUrl: 'http://localhost:8080');

final dio = Dio(options);

callApi(method, url, data) async {
  Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic userDetails = jsonDecode(prefs.getString('user_details') ?? '{}');
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
  if (response != null) {
    return response['data'];
  } else {
    print('Unable to register');
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
  return List<Phi>.from(response['data'].map((x) => Phi.fromJson(x)));
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

Future<dynamic> addReviewCall(
  String restaurantId,
  String reviewDetails,
  String status,
  String phiArea,
) async {
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
