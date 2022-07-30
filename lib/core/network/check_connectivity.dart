import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkConnectivityStatus {
  Future<bool> get isConnected;
}

class NetworkConnectivityStatusImp implements NetworkConnectivityStatus {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkConnectivityStatusImp({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
