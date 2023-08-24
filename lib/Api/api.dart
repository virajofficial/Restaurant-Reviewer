import 'package:dio/dio.dart';
import 'package:sized_box_test/models/restaurant.dart';

import '../models/phi.dart';

final BaseOptions options = BaseOptions(baseUrl: 'http://localhost:8080');

final dio = Dio(options);

callApi(method, url, data) async {
  Response response;
  try {
    switch (method) {
      case 'POST':
        response = await dio.post(url, data: data);
        break;
      case 'PUT':
        response = await dio.put(url, data: data);
        break;
      case 'DELETE':
        response = await dio.delete(url);
        break;
      default:
        response = await dio.get(url);
        break;
    }
    return response.data;
  } catch (e) {
    print(e);
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
