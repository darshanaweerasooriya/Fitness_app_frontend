// // lib/services/socket_service.dart
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class SocketService {
//   static final SocketService _instance = SocketService._internal();
//   factory SocketService() => _instance;
//   SocketService._internal();
//
//   IO.Socket? socket;
//   final String apiBase = "http://10.0.2.2:3001"; // change to your backend base
//
//   void connect({required String userId, String? token}) {
//     if (socket != null && socket!.connected) return;
//
//     socket = IO.io(apiBase, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//       // add auth if your server expects it:
//       if (token != null) 'extraHeaders': {'Authorization': 'Bearer $token'},
//     });
//
//     socket!.connect();
//
//     socket!.onConnect((_) {
//       print('Socket connected: ${socket!.id}');
//       socket!.emit('register', userId);
//     });
//
//     socket!.onDisconnect((_) => print('Socket disconnected'));
//     socket!.onConnectError((data) => print('Socket connect error: $data'));
//   }
//
//   void disconnect() {
//     socket?.disconnect();
//     socket = null;
//   }
// }
