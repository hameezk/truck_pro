import 'connectivity.dart';

var connectionStatus = ConnectionStatusListener.getInstance();
bool showWidget = false;

initNoInternetListener() async {
  await connectionStatus.initialize();

  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  }

  connectionStatus.connectionChange.listen((event) {
    updateConnectivity(event, connectionStatus);
  });
}

updateConnectivity(
  dynamic hasConnection,
  ConnectionStatusListener connectionStatus,
) {
  if (!hasConnection) {
    connectionStatus.hasConnection = false;
    //Handle no internet here
    showWidget = true;
  } else {
    if (connectionStatus.hasConnection) {
      connectionStatus.hasConnection = true;
      //Handle internet is resumed here
      showWidget = true;
    } else {
      connectionStatus.hasConnection = false;
      showWidget = true;
    }
  }
}
