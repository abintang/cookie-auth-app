import 'package:cookie_auth_app/data/models/data_model.dart';

abstract class DataRepository {
  Future<DataModel> getData();
}
