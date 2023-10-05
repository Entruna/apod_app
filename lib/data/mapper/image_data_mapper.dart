import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/extensions/let_extension.dart';
import 'package:apod_app/network/model/apod_response_dto.dart';

///Mapping data from [ApodResponseDto] network layer class to [ImageDataModel] data layer class
class ImageDataMapper {
  ImageDataModel mapImageFromDto(final ApodResponseDto data) => ImageDataModel(
      title: data.title, date: data.date?.let((value) => DateTime.parse(value)), imgUrl: data.hdUrl);
}
