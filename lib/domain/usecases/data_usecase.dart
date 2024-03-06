import 'package:cookie_auth_app/data/models/data_model.dart';
import 'package:cookie_auth_app/domain/repository/data_repository.dart';

class DataUseCase {
  final DataRepository dataRepository;
  DataUseCase({required this.dataRepository});

  Future<DataModel> getData() async {
    return await dataRepository.getData();
  }
}
