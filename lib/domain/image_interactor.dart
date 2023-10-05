import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/data/remote/remote_data_source.dart';

///[ImageInteractor] handles data retrieval and data processing
class ImageInteractor {
  final RemoteDataSource _remoteDataSource;

  const ImageInteractor({required RemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  Future<ImageDataModel> fetchApodDataFromRemote() async {
    try {
      final remoteData = await _remoteDataSource.getLastApod();
      return remoteData;
    } catch (e) {
      throw Exception("Data not found / Connection issue: $e");
    }
  }
}
