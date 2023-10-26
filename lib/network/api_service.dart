import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/network/model/apod_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';

///[ApiService] class handles API calls
class ApiService {
  final Dio _dioClient;
  String? apiKey = dotenv.env["APY_KEY"];

  ApiService({
    required Dio dioClient,
  }) : _dioClient = dioClient;

  Future<ApodResponseDto> getLastApod() async {
    try {
      final response = await _dioClient.get("${StringConstants.url}?api_key=$apiKey");
      return ApodResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception("Data not found / Connection issue: $e");
    }
  }

  Future<ApodResponseDto> getApodByDate(String date) async {
    try {
      final response = await _dioClient.get("${StringConstants.url}?api_key=$apiKey&date=$date");
      return ApodResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception("Data not found / Connection issue: $e");
    }
  }

  Future<void> downloadApod(String imgUrl) async {
    final regex = RegExp(r'/([^/]+)$');
    final match = regex.firstMatch(imgUrl);
    final imageName = match?.group(1);

    try {
      final response = await _dioClient.get(imgUrl, options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: imageName);
    } catch (e) {
      throw Exception('Error occurred while downloading the image: $e');
    }
  }

  ///[getApodBetweenDates] method retrieves images from the server in half year batches
  Future<Iterable<ApodResponseDto>> getApodBetweenDates(DateTime startDate, DateTime endDate) async {
    List<ApodResponseDto> resultImages = [];
    Iterable<ApodResponseDto> fetchedImages = [];

    resultImages = await compute((DateTime startD) async {
      List<ApodResponseDto> resultList = [];
      while (startD.isBefore(endDate)) {
        final DateTime nextYear = DateTime(startD.year, startD.month + 6, 1);
        final DateTime queryEndDate = nextYear.isBefore(endDate) ? nextYear : endDate;
        String formattedStartDate = DateFormat("yyyy-MM-dd").format(startD);
        String formattedEndDate = DateFormat("yyyy-MM-dd").format(queryEndDate);
        print("NEXT YEAR: $nextYear");

        fetchedImages = await repeatFetchImages(formattedStartDate, formattedEndDate);
        if (fetchedImages.isEmpty) {
          return resultList;
        }
        resultList.addAll(fetchedImages);

        startD = nextYear;
      }

      return resultList;
    }, startDate);

    return resultImages;
  }

  Future<Iterable<ApodResponseDto>> repeatFetchImages(String startDate, String endDate) async {
    const int maxRetries = 3;
    int retry = 0;
    List<ApodResponseDto> images = [];

    while (retry < maxRetries) {
      try {
        final response = await _dioClient.get("${StringConstants.url}?api_key=$apiKey&start_date=$startDate&end_date=$endDate");
        final Iterable<dynamic> data = response.data;
        images = data.map((image) => ApodResponseDto.fromJson(image)).toList();
        return images;
      } catch (e) {
        print("Connection issue, retry: $retry, exception: $e, images:${images.length}");
      }

      retry++;
    }

    return const Iterable.empty();
  }
}
