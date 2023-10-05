import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/presentation/constants.dart';
import 'package:apod_app/presentation/image/image_ui_model.dart';
import 'package:intl/intl.dart';

///Mapping data from [ImageDataModel] data layer class to [ImageUIModel] presentation layer class
class ImageUIMapper {
  ImageUIModel mapImageFromDomain(final ImageDataModel data) {
    DateTime? date = data.date;
    String formattedDate = date != null ? DateFormat("yyyy-MM-dd").format(date) : StringConstants.emptyString;
    return ImageUIModel(title: data.title ?? StringConstants.emptyString, date: formattedDate, imgUrl: data.imgUrl ?? StringConstants.emptyString);
  }
}
