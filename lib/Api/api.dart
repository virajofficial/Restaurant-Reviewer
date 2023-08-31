import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_box_test/models/restaurant.dart';

import '../models/phi.dart';

final BaseOptions options = BaseOptions(baseUrl: 'http://localhost:8080');

final dio = Dio(options);

callApi(method, url, data) async {
  Response response;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Options options =
      Options(headers: {'authorization': prefs.getString('access_token')});
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
    return null;
  }
}

Future<List<Restaurant>> getRestaurantsCall() async {
  var response = await callApi('GET', '/restaurant-details', null);
  return List<Restaurant>.from(
      response['data'].map((x) => Restaurant.fromJson(x)));
}

Future<List<Phi>> getPhisCall() async {
  var response = await callApi('GET', '/phi-details', null);
  return List<Phi>.from(response['data'].map((x) => Phi.fromJson(x)));
}

Future<dynamic> loginCall(String userName, String password) async {
  var response = await callApi(
      'POST', '/login', {"userName": userName, "password": password});
  if (response != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', response['data']['token']);
    return response['data'];
  } else {
    print('Unable to login');
  }
}
