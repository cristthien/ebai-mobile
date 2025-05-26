// --- file: lib/data/socket_service/product_socket_services.dart ---
import 'dart:async'; // Import for Completer
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:ebai/data/local_storage/local_storage.dart'; // Import TLocalStorage

class ProductSocketService {
  // Thay đổi từ 'late IO.Socket _socket;' thành 'IO.Socket? _socket;'
  // để cho phép nó là null khi khởi tạo lần đầu.
  IO.Socket? _socket;
  static final ProductSocketService _instance = ProductSocketService._internal();

  factory ProductSocketService() {
    return _instance;
  }

  ProductSocketService._internal();

  IO.Socket get socket => _socket!;

  Future<void> initializeSocket() async {
    final storedToken = TLocalStorage().readData<String>('access_token');
    final socketUrl = dotenv.env['SOCKET_URL'];

    if (socketUrl == null) {
      throw Exception('SOCKET_URL is not defined in .env');
    }

    if (_socket != null && _socket!.connected) { // Sử dụng _socket! để truy cập .connected
      print('Socket already connected. Returning.');
      return;
    }

    // Kiểm tra an toàn null cho _socket
    // Nếu socket đã tồn tại nhưng không kết nối, hãy dispose nó trước khi tạo mới
    if (_socket != null) { // Sử dụng _socket để kiểm tra null
      _socket!.dispose(); // Sử dụng _socket! để gọi dispose()
      print('Disposing existing socket instance.');
    }

    // Sử dụng Completer để báo hiệu khi kết nối hoàn tất (thành công hoặc thất bại)
    final Completer<void> completer = Completer<void>();

    _socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'token': storedToken})
          .enableForceNew() // Luôn tạo kết nối mới
          .build(),
    );

    // Lắng nghe sự kiện kết nối thành công
    _socket!.onConnect((_) { // Sử dụng _socket!
      print('ProductSocketService: Socket Connected: ${_socket!.id}');
      if (!completer.isCompleted) completer.complete();
    });

    // Lắng nghe sự kiện lỗi kết nối
    _socket!.onConnectError((err) { // Sử dụng _socket!
      print('ProductSocketService: Socket Connect Error: $err');
      if (!completer.isCompleted) completer.completeError(err ?? 'Unknown connection error');
    });

    // Lắng nghe các lỗi chung của socket
    _socket!.onError((err) { // Sử dụng _socket!
      print('ProductSocketService: Socket Error: $err');
    });

    // Lắng nghe sự kiện ngắt kết nối
    _socket!.onDisconnect((_) { // Sử dụng _socket!
      print('ProductSocketService: Socket Disconnected');
    });

    // Đợi cho đến khi completer hoàn tất (socket kết nối hoặc lỗi)
    return completer.future;
  }

  // Phương thức để đóng và dispose socket khi không cần nữa
  void disposeSocket() {
    // Kiểm tra _socket != null trước khi truy cập .connected hoặc .disconnect()
    if (_socket != null && _socket!.connected) { // Sử dụng _socket!
      _socket!.disconnect(); // Sử dụng _socket!
      _socket!.dispose(); // Sử dụng _socket!
      print('ProductSocketService: Socket disposed.');
    }
  }
}
