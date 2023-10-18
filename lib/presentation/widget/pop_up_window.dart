import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/injection.dart';
import 'package:apod_app/presentation/archive/archive_image_cubit.dart';
import 'package:apod_app/presentation/home/image_ui_model.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_state.dart';
import 'package:apod_app/presentation/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///[PopUpWindow] widget
class PopUpWindow extends StatefulWidget {
  final ImageUIModel? imageUIModel;
  final BuildContext parentContext;

  const PopUpWindow({
    super.key,
    required this.imageUIModel,
    required this.parentContext,
  });

  @override
  State<PopUpWindow> createState() => _PopUpWindowState();
}

class _PopUpWindowState extends State<PopUpWindow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 0,
          backgroundColor: Colors.grey,
          content: BlocBuilder(
              bloc: getIt<NetworkBloc>(),
              builder: (context, state) {
                if (state is NetworkFailure) {
                  return SizedBox(
                    width: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxHeight * 1.4 : constraints.maxWidth,
                    height: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxWidth : constraints.maxHeight * 0.4,
                    child: const Center(
                        child: Text(
                      StringConstants.noInternetConnection,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  );
                } else if (state is NetworkSuccess) {
                  if (widget.imageUIModel != null) {
                    return _buildAlertDialogContent(constraints);
                  } else {
                    return _buildNoImageAlertDialog(constraints);
                  }
                } else {
                  return const SizedBox.shrink();
                }
              }),
        );
      }),
    );
  }

  ///[_buildNoImageAlertDialog] method builds the no image alert dialog
  Widget _buildNoImageAlertDialog(BoxConstraints constraints) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxHeight * 1.4 : constraints.maxWidth,
      height: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxWidth : constraints.maxHeight * 0.4,
      child: const Center(
          child: Text(
        StringConstants.noImageFound,
        style: TextStyle(color: Colors.white, fontSize: 18),
      )),
    );
  }

  ///[_buildAlertDialogContent] method builds the image alert dialog
  Widget _buildAlertDialogContent(BoxConstraints constraints) {
    return SizedBox(
      width: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxHeight * 1.4 : constraints.maxWidth,
      height: MediaQuery.of(context).orientation == Orientation.landscape ? constraints.maxWidth : constraints.maxHeight * 0.4,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: widget.imageUIModel!.imgUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            placeholder: (context, url) => const Loading(),
            errorWidget: (context, url, error) => const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(Icons.error), Text(StringConstants.noImageFound)],
            ),
          ),
        ),
        ListTile(
          title: Text(
            widget.imageUIModel!.title,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 2.0),
          trailing: widget.imageUIModel!.imgUrl.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    widget.parentContext.read<ArchiveImageCubit>().saveImage(widget.imageUIModel!.imgUrl);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(StringConstants.savingImageToGallery),
                      ),
                    );
                  }),
        ),
      ]),
    );
  }
}
