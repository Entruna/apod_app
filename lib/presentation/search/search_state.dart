import 'package:apod_app/presentation/home/image_ui_model.dart';
import 'package:equatable/equatable.dart';

///[SearchState] defines the possible states of the search
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ImageUIModel> imageModelList;

  const SearchLoaded(this.imageModelList);
}

class SearchImagesSaving extends SearchState {}

class SearchImagesSaved extends SearchState {}

class SearchImagesSavingError extends SearchState {}

class SearchNoResult extends SearchState {}

class SearchError extends SearchState {}
