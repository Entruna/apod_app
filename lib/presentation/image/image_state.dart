import 'package:equatable/equatable.dart';

import 'image_ui_model.dart';

///[ImageState] defines the possible states of the image
abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final ImageUIModel imageModel;

  const ImageLoaded(this.imageModel);
}

class ImageError extends ImageState {
  final String? message;

  const ImageError(this.message);
}
