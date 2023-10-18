import 'package:apod_app/presentation/internet_connection/network_bloc.dart';
import 'package:apod_app/presentation/internet_connection/network_event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

///[NetworkHelper] class listen network changes
class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
