///[NetworkState] defines the possible states of the internet connection
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {}

class NetworkFailure extends NetworkState {}
