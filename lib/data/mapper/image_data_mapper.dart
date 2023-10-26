import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/database/database.dart';
import 'package:apod_app/network/model/apod_response_dto.dart';
import 'package:drift/drift.dart';

///[ImageDataMapper] class for mapping
class ImageDataMapper {
  ///[mapImageFromDto] method maps data from [ApodResponseDto] network layer class to [ImageDataModel] data layer class
  ImageDataModel mapImageFromDto(final ApodResponseDto data) => ImageDataModel(
      title: data.title ?? StringConstants.emptyString,
      date: data.date ?? StringConstants.emptyString,
      imgUrl: data.hdUrl ?? StringConstants.emptyString);

  ///[mapImageFromData] method maps data from [ImageDataModel] data layer class to [ImageEntityCompanion] database layer class
  ImageEntityCompanion mapImageFromData(final ImageDataModel dataModel) =>
      ImageEntityCompanion(title: Value(dataModel.title), date: Value(DateTime.parse(dataModel.date)), url: Value(dataModel.imgUrl));

  ///[mapImageFromEntity] method maps data from [Image] database layer class to [ImageDataModel] data layer class
  ImageDataModel mapImageFromEntity(final Image entity) => ImageDataModel(title: entity.title, date: entity.date.toIso8601String(), imgUrl: entity.url);
}
