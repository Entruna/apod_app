import 'package:apod_app/data/local/local_data_source.dart';
import 'package:apod_app/data/mapper/image_data_mapper.dart';
import 'package:apod_app/data/model/image_data_model.dart';
import 'package:apod_app/database/dao/image_dao.dart';

///[LocalDataSourceImpl] handles communication with the database and passing data to the rest of the application
class LocalDataSourceImpl implements LocalDataSource {
  final ImageDao _imageDao;
  final ImageDataMapper _imageDataMapper;

  const LocalDataSourceImpl({required ImageDao imageDao, required ImageDataMapper imageDataMapper})
      : _imageDao = imageDao,
        _imageDataMapper = imageDataMapper;

  @override
  Future<Iterable<ImageDataModel>> getApodByTitle(String title) async {
  final filteredImages = await _imageDao.getApodByTitle(title);
  final resultImages = filteredImages.map((e) => _imageDataMapper.mapImageFromEntity(e));
  return resultImages;
  }

  @override
  Future<void> saveImages(Iterable<ImageDataModel> imageList) async {
    final images = imageList.map((e) => _imageDataMapper.mapImageFromData(e));
    await _imageDao.saveImages(images);
  }

  @override
  Future<int?> countRows() async {
   return await _imageDao.countRows();
  }
}
