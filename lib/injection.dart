import 'package:apod_app/data/local/local_data_source.dart';
import 'package:apod_app/data/local/local_data_source_impl.dart';
import 'package:apod_app/data/mapper/image_data_mapper.dart';
import 'package:apod_app/data/remote/remote_data_source.dart';
import 'package:apod_app/data/remote/remote_data_source_impl.dart';
import 'package:apod_app/database/dao/image_dao.dart';
import 'package:apod_app/database/database.dart';
import 'package:apod_app/domain/image_interactor.dart';
import 'package:apod_app/network/api_service.dart';
import 'package:apod_app/presentation/archive/archive_image_cubit.dart';
import 'package:apod_app/presentation/home/image_cubit.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/mapper/image_ui_mapper.dart';
import 'package:apod_app/presentation/search/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

///[setupInjection] sets dependency injection
void setupInjection() {
  ///Database layer injections
  getIt.registerSingletonAsync<AppDatabase>(() async => AppDatabase());
  getIt.registerLazySingleton<ImageDao>(() => ImageDao(getIt<AppDatabase>()));

  ///Network layer injections
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(dioClient: getIt<Dio>()));

  ///Data layer injections
  getIt.registerLazySingleton<ImageDataMapper>(() => ImageDataMapper());
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(imageDataMapper: getIt<ImageDataMapper>(), imageDao: getIt<ImageDao>()));
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(apiService: getIt<ApiService>(), imageDataMapper: getIt<ImageDataMapper>()));

  ///Domain layer injections
  getIt.registerLazySingleton<ImageInteractor>(
      () => ImageInteractor(remoteDataSource: getIt<RemoteDataSource>(), localDataSource: getIt<LocalDataSource>()));

  ///Presentation layer injections
  getIt.registerLazySingleton<ImageUIMapper>(() => ImageUIMapper());
  getIt.registerLazySingleton<NetworkBloc>(() => NetworkBloc());
  getIt.registerLazySingleton<ImageCubit>(() => ImageCubit(imageInteractor: getIt<ImageInteractor>(), imageUIMapper: getIt<ImageUIMapper>()));
  getIt.registerLazySingleton<ArchiveImageCubit>(
      () => ArchiveImageCubit(imageInteractor: getIt<ImageInteractor>(), imageUIMapper: getIt<ImageUIMapper>()));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(imageInteractor: getIt<ImageInteractor>(), imageUIMapper: getIt<ImageUIMapper>()));
}
