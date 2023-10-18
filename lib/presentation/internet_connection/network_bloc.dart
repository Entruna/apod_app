import 'package:apod_app/presentation/internet_connection/network_event.dart';
import 'package:apod_app/presentation/internet_connection/network_helper.dart';
import 'package:apod_app/presentation/internet_connection/network_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
///[NetworkBloc] handles internet connection states
class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}