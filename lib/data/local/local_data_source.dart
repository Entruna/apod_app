import 'package:apod_app/data/model/image_data_model.dart';

abstract class LocalDataSource {
  Future<void> saveImages(Iterable<ImageDataModel> imageList);
  Future<Iterable<ImageDataModel>> getApodByTitle(String title);
  Future<int?> countRows();
}