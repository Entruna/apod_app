import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

///[ImageUIModel] defines the properties of the image
@immutable
class ImageUIModel extends Equatable {
  final String title;
  final String date;
  final String imgUrl;

  const ImageUIModel({required this.title, required this.date, required this.imgUrl});

  ImageUIModel copyWith({String? title, String? date, String? imgUrl}) {
    return ImageUIModel(title: title ?? this.title, date: date ?? this.date, imgUrl: imgUrl ?? this.imgUrl);
  }

  @override
  List<Object?> get props => [title, date, imgUrl];
}
