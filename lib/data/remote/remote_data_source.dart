import 'package:apod_app/data/model/image_data_model.dart';

abstract class RemoteDataSource {
  Future<ImageDataModel> getLastApod();

  Future<ImageDataModel> getApodByDate(String date);

  Future<void> downloadApod(String imgUrl);

  Future<Iterable<ImageDataModel>> getApodBetweenDates(DateTime startDate, DateTime endDate);

}