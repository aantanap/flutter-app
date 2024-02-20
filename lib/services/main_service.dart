// ignore_for_file: constant_identifier_names, library_prefixes, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as Http;

class MyBaseServiceManager {
  static const String BASE_URL_PRODUCTION = "";
  static const String BASE_URL_DEV = "http://192.168.3.62:9095/";
  static const String X_FORM_URLENCODED = "application/x-www-form-urlencoded";
  static const String AUTHORIZATION = "Authorization";
  static const String APPLICATION_JSON_ENCODED = "application/json";

  static String getBaseApiUrl() {
    return BASE_URL_DEV;
  }

  static Future<String> actionGet(String url,
      {Map<String, dynamic>? routeValue}) async {
    String param = "";
    if (routeValue != null) {
      param = "?";
      routeValue.forEach((key, value) {
        if (param.length > 2) {
          param = "$param&";
        }

        param = "$param$key=$value";
      });
    }

    Http.Response response = await Http.get(
        Uri.parse((routeValue != null) ? url + param : url),
        headers: {HttpHeaders.contentTypeHeader: APPLICATION_JSON_ENCODED});

    if (kDebugMode) {
      print("status code = ${response.statusCode}");
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<String> actionPost(String url,
      {Map<String, dynamic>? routeValue}) async {
    Http.Response response = await Http.post(Uri.parse(url),
        body: json.encode(routeValue),
        headers: {HttpHeaders.contentTypeHeader: APPLICATION_JSON_ENCODED});

    if (kDebugMode) {
      print("status code = ${response.statusCode}");
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(response.body);
    }
  }
}
