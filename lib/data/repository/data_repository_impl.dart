// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cookie_auth_app/core/constants.dart';
import 'package:cookie_auth_app/data/models/data_model.dart';
import 'package:cookie_auth_app/domain/repository/data_repository.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';

class DataRepositoryImpl implements DataRepository {
  final CookieJar cookieJar;

  DataRepositoryImpl({required this.cookieJar});

  @override
  Future<DataModel> getData() async {
    var client = http.Client();
    // load cookies
    final cookies = await cookieJar.loadForRequest(Uri.parse(baseURL));
    var requests = http.Request('GET', Uri.parse("${baseURL}listData"));
    var cookiesHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
    print(cookiesHeader);

    /// put cookie to an request headers
    requests.headers['cookie'] = cookiesHeader;
    var streamedResponse = await client.send(requests);
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      // do whatever you want to the response body there
      final data = json.decode(response.body)['data'];
      return data;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load');
    }
  }
}
