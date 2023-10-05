import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///Image data model
@immutable
class ImageDataModel extends Equatable {
  final String? title;
  final DateTime? date;
  final String? imgUrl;

  const ImageDataModel({this.title, this.date, this.imgUrl});

  @override
  List<Object?> get props => [title, date, imgUrl];
}
