import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_state.dart';
import 'package:apod_app/presentation/routes.dart';
import 'package:apod_app/presentation/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
       if (state is NetworkSuccess) {
          Future.delayed(const Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed(AppRoutes.home));

          Future.delayed(const Duration(seconds: 1), () async {
            await context.read<SearchCubit>().saveImages();
          });
        }
      }, builder: (context, state) {
        if (state is NetworkSuccess) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(StringConstants.splashScreenImage),
                fit: BoxFit.contain,
              ),
            ),
          );
        } else if (state is NetworkInitial || state is NetworkFailure) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.black,
            child: const Center(
                child: Text(
                  StringConstants.splashScreenError,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
