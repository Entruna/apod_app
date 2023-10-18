import 'package:apod_app/database/database.dart';
import 'package:apod_app/database/entity/image_entity.dart';
import 'package:drift/drift.dart';

part '../../generated/database/dao/image_dao.g.dart';

///[ImageDao] class contains database queries
@DriftAccessor(tables: [ImageEntity])
class ImageDao extends DatabaseAccessor<AppDatabase> with _$ImageDaoMixin {
  ImageDao(AppDatabase db) : super(db);

  ///[saveImages] method save images to database
  Future<void> saveImages(Iterable<ImageEntityCompanion> imageList) async {
    await batch((batch) {
      batch.insertAll(db.imageEntity, imageList, mode: InsertMode.insertOrReplace);
    });
  }

  ///[getApodByTitle] method gets images by title
  Future<Iterable<Image>> getApodByTitle(String searchText) {
    return (select(db.imageEntity)
          ..where((t) => t.title.contains(searchText))
          ..orderBy([(t) => OrderingTerm(expression: t.title)]))
        .get();
  }

  ///[countRows] method counts the rows of the database
  Future<int?> countRows() async {
    var countExp = db.imageEntity.date.count();
    final query = selectOnly(db.imageEntity)..addColumns([countExp]);
    var result = await query.map((row) => row.read(countExp)).getSingle();
    return result;
  }
}
