import 'package:drift/drift.dart';

///[ImageEntity] class represents part of the api response in database layer
@DataClassName("Image")
class ImageEntity extends Table {
  TextColumn get title => text()();

  TextColumn get date => text()();

  TextColumn get url => text()();

  @override
  Set<Column> get primaryKey => {date};
}
