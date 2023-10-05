import 'package:apod_app/data/model/image_data_model.dart';

abstract class RemoteDataSource {
  Future<ImageDataModel> getLastApod();
}