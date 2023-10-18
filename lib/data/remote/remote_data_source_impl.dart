import 'package:apod_app/data/mapper/image_data_mapper.dart';
import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/data/remote/remote_data_source.dart';
import 'package:apod_app/network/api_service.dart';

///[RemoteDataSourceImpl] handles communication with the server and passing data to the rest of the application
class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService _apiService;

  final ImageDataMapper _imageDataMapper;

  const RemoteDataSourceImpl({required ApiService apiService, required ImageDataMapper imageDataMapper})
      : _apiService = apiService,
        _imageDataMapper = imageDataMapper;

  @override
  Future<ImageDataModel> getLastApod() async {
    try {
      final response = await _apiService.getLastApod();
      return _imageDataMapper.mapImageFromDto(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<ImageDataModel> getApodByDate(String date) async {
    try {
      final response = await _apiService.getApodByDate(date);
      return _imageDataMapper.mapImageFromDto(response);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<void> downloadApod(String imgUrl) async {
    try {
      await _apiService.downloadApod(imgUrl);
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Iterable<ImageDataModel>> getApodBetweenDates(DateTime startDate, DateTime endDate) async {
    try {
      final stopwatch = Stopwatch()..start();
      final response = await _apiService.getApodBetweenDates(startDate, endDate);
      print('Get apods between dates: ${stopwatch.elapsed.inMinutes}');
      final images = response.map((e) => _imageDataMapper.mapImageFromDto(e));
      return images;
    } on Exception {
      rethrow;
    }
  }
}
