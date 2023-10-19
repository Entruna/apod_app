import 'package:apod_app/domain/image_interactor.dart';
import 'package:apod_app/presentation/mapper/image_ui_mapper.dart';
import 'package:apod_app/presentation/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///[SearchCubit] handles search states
class SearchCubit extends Cubit<SearchState> {
  final ImageInteractor _imageInteractor;
  final ImageUIMapper _imageUIMapper;

  SearchCubit({required ImageInteractor imageInteractor, required ImageUIMapper imageUIMapper})
      : _imageInteractor = imageInteractor,
        _imageUIMapper = imageUIMapper,
        super(SearchInitial());

  Future<void> saveImages() async {
      emit(SearchImagesSaving());
      await _imageInteractor.saveImagesToDatabase();
      emit(SearchImagesSaved());
  }

  Future<void> searchByTitle(String searchText) async {
    if (state != SearchImagesSaving()) {
      try {
        emit(SearchLoading());
        final resultImages = await _imageInteractor.searchByTitle(searchText);
        final mappedImages = resultImages.map((e) => _imageUIMapper.mapImageFromDomain(e));
        if (mappedImages.isEmpty) {
          emit(SearchNoResult());
        } else {
          emit(SearchLoaded(mappedImages.toList()));
        }
      } catch (_) {
        emit(SearchError());
      }
    }
  }
}
