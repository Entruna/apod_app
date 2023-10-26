import 'package:apod_app/data/local/local_data_source.dart';
import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/data/remote/remote_data_source.dart';
import 'package:apod_app/exceptions/exceptions.dart';

///[ImageInteractor] handles data retrieval and data processing
class ImageInteractor {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  const ImageInteractor({required RemoteDataSource remoteDataSource, required LocalDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  Future<ImageDataModel> getLastApod() async {
    try {
      final remoteData = await _remoteDataSource.getLastApod();
      return remoteData;
    } catch (e) {
      throw Exception("Failed to get the picture of the day: $e");
    }
  }

  Future<ImageDataModel> getApodByDate(String date) async {
    if (date.isEmpty) {
      throw DateIsEmptyException("Date is an empty string");
    }
    try {
      final remoteData = await _remoteDataSource.getApodByDate(date);
      return remoteData;
    } catch (e) {
      throw Exception("Failed to get image: $e");
    }
  }

  Future<void> saveImage(String imgUrl) async {
    if (imgUrl.isEmpty) {
      throw ImageUrlIsEmptyException("Image url is an empty string");
    }
    try {
      await _remoteDataSource.downloadApod(imgUrl);
    } catch (e) {
      throw Exception("Failed to download image: $e");
    }
  }

  ///[saveImagesToDatabase] method checks how much data is in the database and updates the database
  Future<void> saveImagesToDatabase() async {
    final DateTime startDate = DateTime(2022, 6, 16);
    final DateTime endDate = DateTime.now();
    final Iterable<ImageDataModel> images;
    double startDifference = (endDate.difference(startDate).inHours) / 24;
    double daysDifference = (endDate.difference(startDate).inHours) / 24;

    int? databaseRows = await _localDataSource.countRows();
    if (databaseRows != null) {
      if (databaseRows == 0) {
        images = await _remoteDataSource.getApodBetweenDates(startDate, endDate);
        await _localDataSource.saveImages(images);
        if (databaseRows != startDifference.ceil()) {
          throw Exception("Failed to download all images");
        }
      } else if (daysDifference > databaseRows) {
          daysDifference = daysDifference - databaseRows;
          final DateTime newStartDate = endDate.subtract(Duration(days: daysDifference.ceil()));
          images = await _remoteDataSource.getApodBetweenDates(newStartDate, endDate);
          await _localDataSource.saveImages(images);
          if (databaseRows != startDifference.ceil()) {
            throw Exception("Failed to download all images");
          }
      }
    }
  }

  Future<Iterable<ImageDataModel>> searchByTitle(String searchText) async {
    final Iterable<ImageDataModel> matches;
    final images = await _localDataSource.getApodByTitle(searchText);
    matches = images.where((element) => element.title.toLowerCase().contains(searchText.toLowerCase()));

    return matches;
  }
}
