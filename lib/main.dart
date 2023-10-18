import 'package:apod_app/injection.dart';
import 'package:apod_app/presentation/archive/archive_image_cubit.dart';
import 'package:apod_app/presentation/archive/archive_screen.dart';
import 'package:apod_app/presentation/home/home_screen.dart';
import 'package:apod_app/presentation/home/image_cubit.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_event.dart';
import 'package:apod_app/presentation/routes.dart';
import 'package:apod_app/presentation/search/search_cubit.dart';
import 'package:apod_app/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  ///Dependency injection set up
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => MultiBlocProvider(providers: [
              BlocProvider<NetworkBloc>.value(value: getIt<NetworkBloc>()..add(NetworkObserve())),
              BlocProvider<SearchCubit>.value(value: getIt<SearchCubit>())
            ], child: const SplashScreen()),
        AppRoutes.home: (context) => MultiBlocProvider(providers: [
              BlocProvider<NetworkBloc>.value(value: getIt<NetworkBloc>()..add(NetworkObserve())),
              BlocProvider<ImageCubit>.value(value: getIt<ImageCubit>())
            ], child: const HomeScreen()),
        AppRoutes.archive: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<NetworkBloc>.value(value: getIt<NetworkBloc>()..add(NetworkObserve())),
                BlocProvider<ArchiveImageCubit>.value(value: getIt<ArchiveImageCubit>()),
                BlocProvider<SearchCubit>.value(value: getIt<SearchCubit>()),
              ],
              child: const ArchiveScreen(),
            ),
      },
    );
  }
}
