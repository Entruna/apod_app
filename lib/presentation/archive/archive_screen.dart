import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/presentation/archive/archive_image_cubit.dart';
import 'package:apod_app/presentation/archive/archive_image_state.dart';
import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_state.dart';
import 'package:apod_app/presentation/widget/custom_search_delegate.dart';
import 'package:apod_app/presentation/widget/pop_up_window.dart';
import 'package:apod_app/presentation/widget/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[ArchiveScreen] class
class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = DateTime(1995, 6, 16);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(StringConstants.archive),
            backgroundColor: Colors.black,
            actions: [
              IconButton(onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate(context)), icon: const Icon(Icons.search))
            ],
          ),
          drawer: const SideMenu(),
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
                return _buildArchiveScreenContent();
              } else {
                return const SizedBox.shrink();
              }
            }),
          )),
    );
  }

  ///[_buildArchiveScreenContent] method builds archive screen content and displays popups, datepicker
  Widget _buildArchiveScreenContent() {
    return Center(
      child: BlocListener<ArchiveImageCubit, ArchiveImageState>(
        listener: (listenerContext, state) {
          if (state is ArchiveImageError) {
            showDialog(
                context: listenerContext,
                builder: (context) => PopUpWindow(
                      imageUIModel: null,
                      parentContext: listenerContext,
                    ));
          }
          if (state is ArchiveImageLoaded) {
            showDialog(
                context: listenerContext,
                builder: (context) => PopUpWindow(
                      imageUIModel: state.imageModel,
                      parentContext: listenerContext,
                    ));
          }
        },
        child: BlocBuilder<ArchiveImageCubit, ArchiveImageState>(
          builder: (context, state) {
            if (state is ArchiveImageInitial) {
              return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: MediaQuery.of(context).orientation == Orientation.landscape
                      ? const EdgeInsets.only(left: 200.0, right: 200.0)
                      : const EdgeInsets.only(left: 40.0, right: 40.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        StringConstants.selectImageDate,
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.calendar_today, color: Colors.white),
                    ],
                  ),
                ),
                onTap: () async => await _buildMaterialDatePicker(context),
              );
            } else if (state is ArchiveImageError) {
              return const SizedBox.shrink();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  ///[_buildMaterialDatePicker] method builds date picker
  _buildMaterialDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      selectableDayPredicate: _decideWhichDayIsAvailable,
      firstDate: firstDate,
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      cancelText: StringConstants.cancel,
      confirmText: StringConstants.ok,
    );
    if (pickedDate != null) {
      context.read<ArchiveImageCubit>().getApodByDate(pickedDate);
    }
  }

  ///This method decides which day is available
  bool _decideWhichDayIsAvailable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(DateTime.now().difference(firstDate))) && day.isBefore(DateTime.now().add(const Duration(days: 0)))) {
      return true;
    }
    return false;
  }
}
