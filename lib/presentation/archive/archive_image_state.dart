import 'package:apod_app/presentation/home/image_ui_model.dart';
import 'package:equatable/equatable.dart';

///[ArchiveImageState] defines the possible states of the archive image
abstract class ArchiveImageState extends Equatable {
  const ArchiveImageState();

  @override
  List<Object?> get props => [];
}

class ArchiveImageInitial extends ArchiveImageState {}

class ArchiveImageLoading extends ArchiveImageState {}

class ArchiveImageLoaded extends ArchiveImageState {
  final ImageUIModel imageModel;

  const ArchiveImageLoaded(this.imageModel);
}

class ArchiveImageError extends ArchiveImageState {}
