import 'dart:convert';

import 'package:dio/dio.dart';

Map<String, dynamic> returnResponce(Response responce) {
  switch (responce.statusCode) {
    case 200:
      Map<String, dynamic> responceJson = jsonDecode(responce.toString());
      return responceJson;
    case 400:
      Map<String, dynamic> responceJson = jsonDecode(responce.toString());
      return responceJson;
    case 403:
      Map<String, dynamic> responceJson = jsonDecode(responce.toString());
      return responceJson;
    case 404:
      Map<String, dynamic> responceJson = jsonDecode(responce.toString());
      return responceJson;
    case 500:
      Map<String, dynamic> responceJson = jsonDecode(responce.toString());
      return responceJson;
    default:
      return {
        'message': 'No response found',
        'statusCode': responce.statusCode,
        'response': responce.statusMessage
      };
  }
}
