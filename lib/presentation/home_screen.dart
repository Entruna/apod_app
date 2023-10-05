import 'package:apod_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image/image_cubit.dart';
import 'image/image_state.dart';
import 'image/image_ui_model.dart';

///This is the app start screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: _buildImage(),
    );
  }

  ///This method builds the ui according to the possible states of the image
  Widget _buildImage() {
    return BlocProvider<ImageCubit>(
      create: (_) => getIt<ImageCubit>(),
      child: BlocListener<ImageCubit, ImageState>(
        listener: (context, state) {
          if (state is ImageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<ImageCubit, ImageState>(
          builder: (context, state) {
            if (state is ImageInitial) {
              return _buildLoading();
            } else if (state is ImageLoading) {
              return _buildLoading();
            } else if (state is ImageLoaded) {
              return _buildImageContainer(context, state.imageModel);
            } else if (state is ImageError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
  ///This method builds the ui according to the possible states of the orientation
  Widget _buildImageContainer(BuildContext context, ImageUIModel model) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait ? _buildImageVerticalLayout(context, model) : _buildImageHorizontalLayout(context, model);
    });
  }
  ///This method builds the ui vertical layout
  Widget _buildImageVerticalLayout(BuildContext context, ImageUIModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Image.network(model.imgUrl, fit: BoxFit.cover),
      ),
      Text(
        model.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
      Text(
        model.date.toString(),
        style: const TextStyle(fontSize: 16),
        overflow: TextOverflow.ellipsis,
      )
    ],
      ),
    );
  }
  ///This method builds the ui horizontal layout
  Widget _buildImageHorizontalLayout(BuildContext context, ImageUIModel model) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Image.network(model.imgUrl, fit: BoxFit.cover),
                ),
              ),
              Text(
                model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                model.date.toString(),
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ],
        ),
      ),
    );
  }

  ///This method builds the loading screen
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
