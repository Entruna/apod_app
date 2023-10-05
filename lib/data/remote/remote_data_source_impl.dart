import 'package:apod_app/data/remote/remote_data_source.dart';
import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/network/api_service.dart';
import 'package:apod_app/data/mapper/image_data_mapper.dart';

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
}
