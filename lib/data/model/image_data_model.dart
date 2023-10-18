import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///[ImageDataModel] class represents part of the api response in data layer
@immutable
class ImageDataModel extends Equatable {
  final String title;
  final String date;
  final String imgUrl;

  const ImageDataModel({required this.title, required this.date, required this.imgUrl});

  @override
  List<Object?> get props => [title, date, imgUrl];
}
