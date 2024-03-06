import 'package:cookie_auth_app/domain/repository/login_repository.dart';
import '../../core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';

class LoginRepositoryImpl implements LoginRepository {
  final CookieJar cookieJar;

  LoginRepositoryImpl({required this.cookieJar});

  @override
  Future<String> login(String email, String password) async {
    final response = await http.post(Uri.parse("${baseURL}login"),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      // retrieve token from set-cookie headers
      final refreshToken = _getTokenFromHeader(
          response.headers['set-cookie']!, "refresh_token=");
      final token =
          _getTokenFromHeader(response.headers['set-cookie']!, "token=");

      List<Cookie> cookies = [
        Cookie('refresh_token', refreshToken),
        Cookie('token', token)
      ];

      // save cookies
      await cookieJar.saveFromResponse(Uri.parse(baseURL), cookies);
      return refreshToken;
    } else {
      throw Exception("Failed to Login");
    }
  }

  String _getTokenFromHeader(String header, String split) {
    List<String> parts = header.split(split);
    if (parts.length > 1) {
      List<String> tokenParts = parts[1].split(";");
      return tokenParts[0];
    }
    return "";
  }
}
