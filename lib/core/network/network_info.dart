import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl extends NetworkInfo {
  NetworkInfoImpl(this.connectivity);
  final Connectivity connectivity;

  @override
  Future<bool> isConnected() async {
    String connectionStatus = 'Unknown';
    final Connectivity _connectivity = Connectivity();
    connectionStatus = (await _connectivity.checkConnectivity()).toString();
    if (connectionStatus == 'ConnectivityResult.mobile' ||
        connectionStatus == 'ConnectivityResult.wifi') {
      return true;
    } else {
      return false;
    }
  }
}
