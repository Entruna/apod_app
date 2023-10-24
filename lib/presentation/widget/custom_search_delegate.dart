import 'package:apod_app/constants/constants.dart';
import 'package:apod_app/injection.dart';
import 'package:apod_app/presentation/search/search_cubit.dart';
import 'package:apod_app/presentation/search/search_state.dart';
import 'package:apod_app/presentation/widget/loading.dart';
import 'package:apod_app/presentation/widget/pop_up_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[CustomSearchDelegate] widget for the image title search
class CustomSearchDelegate extends SearchDelegate {
  final BuildContext parentContext;

  CustomSearchDelegate(this.parentContext);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        )),
        hintColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
        ));
  }

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    parentContext.read<SearchCubit>().searchByTitle(query);
    return Container(
      color: Colors.black,
      child: BlocBuilder<SearchCubit, SearchState>(
        bloc: getIt<SearchCubit>(),
        builder: (BuildContext context, SearchState state) {
          switch (state) {
            case SearchImagesSaving():
              return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Loading(),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  StringConstants.syncingData,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ]);
            case SearchImagesSaved():
              return const Center(
                child: Text(
                  StringConstants.dataSynced,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            case SearchImagesSavingError():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            Future.delayed(const Duration(seconds: 1), () async {
                              await parentContext.read<SearchCubit>().saveImages();
                            });
                          },
                          icon: const Icon(Icons.refresh)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      StringConstants.errorSyncingData,
                      maxLines: 2,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              );
            case SearchLoading():
              return const Loading();
            case SearchLoaded():
              return ListView.builder(
                itemBuilder: (listContext, index) => ListTile(
                  title: Text(
                    (state.imageModelList[index]).title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    close(context, state.imageModelList[index]);
                    showDialog(
                        context: parentContext,
                        builder: (context) => PopUpWindow(
                              imageUIModel: (state.imageModelList[index]),
                              parentContext: parentContext,
                            ));
                  },
                ),
                itemCount: state.imageModelList.length,
              );
            case SearchNoResult():
              return const Center(
                child: Text(
                  StringConstants.noResult,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            default:
              return const Center(
                child: Text(
                  StringConstants.errorOccurred,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    parentContext.read<SearchCubit>().searchByTitle(query);
    return Container(
      color: Colors.black,
      child: BlocBuilder<SearchCubit, SearchState>(
          bloc: getIt<SearchCubit>(),
          builder: (BuildContext context, SearchState state) {
            switch (state) {
              case SearchImagesSaving():
                return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Loading(),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    StringConstants.syncingData,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ]);
              case SearchImagesSaved():
                return const Center(
                  child: Text(
                    StringConstants.dataSynced,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              case SearchImagesSavingError():
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            color: Colors.black,
                            onPressed: () {
                              Future.delayed(const Duration(seconds: 1), () async {
                                await parentContext.read<SearchCubit>().saveImages();
                              });
                            },
                            icon: const Icon(Icons.refresh)),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        StringConstants.errorSyncingData,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                );
              case SearchLoading():
                return const Loading();
              case SearchLoaded():
                return ListView.builder(
                  itemBuilder: (listContext, index) => ListTile(
                    title: Text(
                      (state.imageModelList[index]).title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      close(context, state.imageModelList[index]);
                      showDialog(
                          context: parentContext,
                          builder: (context) => PopUpWindow(
                                imageUIModel: (state.imageModelList[index]),
                                parentContext: parentContext,
                              ));
                    },
                  ),
                  itemCount: state.imageModelList.length,
                );
              case SearchNoResult():
                return const Center(
                  child: Text(
                    StringConstants.noResult,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              default:
                return const Center(
                  child: Text(
                    StringConstants.errorOccurred,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
            }
          }),
    );
  }
}
