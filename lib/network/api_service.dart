import 'package:apod_app/network/model/apod_response_dto.dart';
import 'package:dio/dio.dart';

///[ApiService] class handles API calls
class ApiService {
  final Dio _dioClient;
  final String _url = "https://api.nasa.gov/planetary/apod?api_key=q6cCPxa87bWj5sRmqz5cuHrENluHCDHTshBLNCqN";

  const ApiService({
    required Dio dioClient,
  }) : _dioClient = dioClient;

  Future<ApodResponseDto> getLastApod() async {
    try {
      final response = await _dioClient.get(_url);
      return ApodResponseDto.fromJson(response.data);
    } catch (e){
      return ApodResponseDto.withError("Data not found / Connection issue");
    }
  }
}
