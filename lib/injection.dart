import 'package:apod_app/data/remote/remote_data_source_impl.dart';
import 'package:apod_app/domain/image_interactor.dart';
import 'package:apod_app/network/api_service.dart';
import 'package:apod_app/presentation/image/image_cubit.dart';
import 'package:apod_app/presentation/mapper/image_ui_mapper.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/remote/remote_data_source.dart';
import 'data/mapper/image_data_mapper.dart';

final getIt = GetIt.instance;

void setupInjection() {
  ///Network layer injections
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(dioClient: getIt<Dio>()));

  ///Data layer injections
  getIt.registerLazySingleton<ImageDataMapper>(() => ImageDataMapper());
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(apiService: getIt<ApiService>(), imageDataMapper: getIt<ImageDataMapper>()));

  ///Domain layer injections
  getIt.registerLazySingleton<ImageInteractor>(() => ImageInteractor(remoteDataSource: getIt<RemoteDataSource>()));

  ///Presentation layer injections
  getIt.registerLazySingleton<ImageUIMapper>(() => ImageUIMapper());
  getIt.registerLazySingleton<ImageCubit>(() => ImageCubit(imageInteractor: getIt<ImageInteractor>(), imageUIMapper: getIt<ImageUIMapper>()));




}
