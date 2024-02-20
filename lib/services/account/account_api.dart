// ignore_for_file: unused_import

import 'dart:convert';
import 'package:rems/model/account/authenticate_model.dart';
import 'package:rems/services/main_service.dart';
import 'package:rems/services/pref_data.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AccountAPI {
  Future<auth> autenticate(Authenticate value) async {
    respAuthenticate respAUTHENTICATE_ = respAuthenticate();
    final response = await http.post(
        Uri.parse(
            '${MyBaseServiceManager.getBaseApiUrl()}api/Account/authenticate/'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(value.toJson()));

    String data = response.body.toString();
    respAUTHENTICATE_ = respAuthenticate.fromJson(json.decode(data));
    auth authen = auth();
    authen.statuscode = response.statusCode.toString();
    authen.res = respAUTHENTICATE_;
    return authen;
  }
}
