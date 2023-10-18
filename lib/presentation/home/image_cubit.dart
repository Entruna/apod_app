import 'package:apod_app/domain/image_interactor.dart';
import 'package:apod_app/presentation/home/image_state.dart';
import 'package:apod_app/presentation/mapper/image_ui_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


///[ImageCubit] handles home screen image states
class ImageCubit extends Cubit<ImageState> {
  final ImageInteractor _imageInteractor;
  final ImageUIMapper _imageUIMapper;

  ImageCubit({required ImageInteractor imageInteractor, required ImageUIMapper imageUIMapper})
      : _imageInteractor = imageInteractor,
        _imageUIMapper = imageUIMapper,
        super(ImageInitial()) {
    getLastApod();
  }

  void getLastApod() async {
    try {
      emit(ImageLoading());
      final data = await _imageInteractor.getLastApod();
      final img = _imageUIMapper.mapImageFromDomain(data);
      emit(ImageLoaded(img));
    } catch (e) {
      emit(ImageError());
    }
  }
}
