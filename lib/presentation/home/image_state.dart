import 'package:apod_app/presentation/home/image_ui_model.dart';
import 'package:equatable/equatable.dart';

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

class ImageError extends ImageState {}
