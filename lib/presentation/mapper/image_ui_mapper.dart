import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/presentation/home/image_ui_model.dart';

//////[ImageUIMapper] class for mapping
class ImageUIMapper {
  ///[mapImageFromDomain] maps data from [ImageDataModel] data layer class to [ImageUIModel] presentation layer class
  ImageUIModel mapImageFromDomain(final ImageDataModel data) {
    return ImageUIModel(title: data.title, date: data.date, imgUrl: data.imgUrl);
  }
}
