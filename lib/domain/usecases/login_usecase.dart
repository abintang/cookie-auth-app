import 'package:cookie_auth_app/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase({required this.loginRepository});

  Future<String> login(String email, String password) async {
    return await loginRepository.login(email, password);
  }
}
