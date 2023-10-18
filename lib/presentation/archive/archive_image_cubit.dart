import 'package:apod_app/domain/image_interactor.dart';
import 'package:apod_app/presentation/archive/archive_image_state.dart';
import 'package:apod_app/presentation/mapper/image_ui_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

///[ArchiveImageCubit] handles archive image states
class ArchiveImageCubit extends Cubit<ArchiveImageState> {
  final ImageInteractor _imageInteractor;
  final ImageUIMapper _imageUIMapper;

  ArchiveImageCubit({required ImageInteractor imageInteractor, required ImageUIMapper imageUIMapper})
      : _imageInteractor = imageInteractor,
        _imageUIMapper = imageUIMapper,
        super(ArchiveImageInitial());

  Future<void> getApodByDate(DateTime date) async {
    final formattedDate = DateFormat("yyyy-MM-dd").format(date);
    try {
      emit(ArchiveImageLoading());
      final data = await _imageInteractor.getApodByDate(formattedDate);
      final img = _imageUIMapper.mapImageFromDomain(data);
      emit(ArchiveImageLoaded(img));
      emit(ArchiveImageInitial());
    } catch (_) {
      emit(ArchiveImageError());
      emit(ArchiveImageInitial());
    }
  }

  Future<void> saveImage(String imgUrl) async {
    await _imageInteractor.saveImage(imgUrl);
  }
}
