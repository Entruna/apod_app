import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/presentation/home/image_cubit.dart';
import 'package:apod_app/presentation/home/image_state.dart';
import 'package:apod_app/presentation/home/image_ui_model.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_state.dart';
import 'package:apod_app/presentation/widget/image_error_widget.dart';
import 'package:apod_app/presentation/widget/loading.dart';
import 'package:apod_app/presentation/widget/side_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[HomeScreen] class is the app home screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideMenu(),
        appBar: AppBar(
          title: const Text(StringConstants.home),
          backgroundColor: Colors.black,
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(StringConstants.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
              if (state is NetworkFailure) {
                return const Center(
                    child: Text(
                  StringConstants.noInternetConnection,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ));
              } else if (state is NetworkSuccess) {
                return _buildImage();
              } else {
                return const SizedBox.shrink();
              }
            })),
      ),
    );
  }

  ///[_buildImage] method builds the ui according to the possible states of the image
  Widget _buildImage() {
    return BlocListener<ImageCubit, ImageState>(
      listener: (context, state) {
        if (state is ImageError) {
          const SnackBar(
            content: Text(StringConstants.noImageFound),
          );
        }
      },
      child: BlocBuilder<ImageCubit, ImageState>(
        builder: (context, state) {
          if (state is ImageInitial) {
            return const Loading();
          } else if (state is ImageLoading) {
            return const Loading();
          } else if (state is ImageLoaded) {
            return _buildImageContainer(context, state.imageModel);
          } else if (state is ImageError) {
            return const SizedBox.shrink();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  ///[_buildImageContainer] method builds the ui according to the possible states of the orientation
  Widget _buildImageContainer(BuildContext context, ImageUIModel model) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait ? _buildImageVerticalLayout(context, model) : _buildImageHorizontalLayout(context, model);
    });
  }

  ///[_buildImageVerticalLayout] method builds the ui vertical layout
  Widget _buildImageVerticalLayout(BuildContext context, ImageUIModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AspectRatio(
            aspectRatio: 16.0 / 12.0,
            child: CachedNetworkImage(
              imageUrl: model.imgUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              placeholder: (context, url) => const Loading(),
              errorWidget:  (context, url, error) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                ),
                child: const ImageErrorWidget(color: Colors.white,),
              ),
            ),
          ),
          Text(
            model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            model.date.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  ///[_buildImageHorizontalLayout] method builds the ui horizontal layout
  Widget _buildImageHorizontalLayout(BuildContext context, ImageUIModel model) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: AspectRatio(
                aspectRatio: 16.0 / 12.0,
                child: CachedNetworkImage(
                  imageUrl: model.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  placeholder: (context, url) => const Loading(),
                  errorWidget:  (context, url, error) => const ImageErrorWidget(color: Colors.white,)
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              model.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              model.date.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
