// --- file: lib/app/modules/bidding/controllers/bidding_controller.dart ---
import 'dart:async'; // Import for Timer
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For formatting numbers
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../data/local_storage/local_storage.dart';
import '../../../data/socket_service/product_socket_services.dart';
import '../../../utils/popups/loaders.dart';
import '../models/individual_bid.dart'; // Đảm bảo bạn có TLoaders


class BiddingController extends GetxController {
  final ProductSocketService _socketService = Get.find<ProductSocketService>();
  late IO.Socket _socket; // Thay đổi từ IO.Socket? _socket; vì nó sẽ được gán trong onInit
  final bidAmountController = TextEditingController();

  // Reactive variables for UI
  final RxBool isSocketConnected = false.obs; // Trạng thái kết nối socket
  final Rx<IndividualBid?> bids = Rx<IndividualBid?>(null); // Dữ liệu bid hiện tại
  final RxString bidAmount = ''.obs; // Giá trị nhập vào của người dùng cho bid
  final RxDouble highestBid = 0.0.obs; // Giá trị nhập vào của người dùng cho bid
  final RxInt numOfBid = 0.obs; // Giá trị nhập vào của người dùng cho bid numOfBid = '0'.obs; // Giá trị nhập vào của người dùng cho bid
  final RxString timeLeft = 'Calculating.... '.obs; // Thời gian còn lại
  final RxString highestBider = 'No'.obs; // Thời gian còn lại
  final RxBool isDisabled = false.obs; // Trạng thái disable của nút bid

  // Dữ liệu sản phẩm (fixed cứng như bạn đã yêu cầu)
  final String productSlug;
  final DateTime endDate;

  // Timer cho countdown
  Timer? _timer;
  String? _accessToken;

  BiddingController({required this.productSlug, required this.endDate});

  @override
  void onInit() async {
    super.onInit();
    _socket = _socketService.socket; // Lấy instance socket

    // Bước 1: Kết nối Socket và xử lý lỗi
    try {
      print('BiddingController: Attempting to initialize socket...');
      await _socketService.initializeSocket();
      isSocketConnected.value = true;
      _accessToken= await TLocalStorage().readData('access_token');
      TLoaders.successSnackBar(title: 'Kết Nối Thành Công', message: 'Socket đã kết nối!');
      _socket.emit('joinAuction', productSlug);
      print('BiddingController: Emitted joinAuction for: $productSlug');

      // Bước 3: Đăng ký Listeners cho các sự kiện bid
      _setupSocketListeners();

      // Bước 4: Khởi động bộ đếm ngược
      _startCountdownTimer();

    } catch (e) {
      isSocketConnected.value = false;
      isDisabled.value = true; // Disable bidding if connection fails
      print('BiddingController: Failed to initialize socket: $e');
      TLoaders.errorSnackBar(title: 'Lỗi Kết Nối', message: 'Không thể kết nối đến máy chủ đấu giá: $e');
    }
  }

  void _setupSocketListeners() {
    // Lắng nghe trạng thái kết nối chung của socket
    _socket.onConnect((_) {
      isSocketConnected.value = true;
      print('BiddingController: Socket reconnected. Rejoining auction...');
      _socket.emit('joinAuction', productSlug); // Tham gia lại đấu giá khi kết nối lại
    });
    _socket.onDisconnect((_) {
      isSocketConnected.value = false;
      print('BiddingController: Socket disconnected.');
    });
    _socket.onConnectError((err) {
      isSocketConnected.value = false;
      print('BiddingController: Socket connect error: $err');
    });

    // Listener cho dữ liệu bid ban đầu (khi mới vào)
    _socket.on('initalizeBid', (data) {
      print('BiddingController: Received initial bid data: $data');
      if (data != null) {
        try {
          // bids.value = BidModel.fromJson(data['bids']);
          highestBid.value = double.tryParse(data['highest_bid']?.toString() ?? '') ?? 0.0;
          numOfBid.value = int.tryParse(data['numOfBid']?.toString() ?? '') ?? 0;
          if (data.containsKey('bids') && data['bids'] is List) {
            final List bidsList = data['bids'] as List;
            if (bidsList.isNotEmpty) {
              final firstBid = bidsList[0];
              if (firstBid is Map<String, dynamic> && firstBid.containsKey('username')) {
                highestBider.value = firstBid["username"]?.toString() ?? 'Unknown';
              } else {
                // Trường hợp firstBid không phải Map hoặc không có key 'username'
                highestBider.value = 'No Bider (Invalid bid format)';
              }
            } else {
              // Trường hợp bidsList rỗng
              highestBider.value = 'No Bider';
            }
          }
        } on FormatException catch (formatError) {
          print('FormatException parsing BidModel: $formatError');
          TLoaders.errorSnackBar(
            title: 'Data Format Error',
            message: 'Unable to parse initial bid data correctly.',
          );
        } on Exception catch (e) {
          print('General exception parsing initial BidModel: $e');
          TLoaders.errorSnackBar(
            title: 'Data Error',
            message: 'An error occurred while reading initial bid data.',
          );
        } catch (error) {
          // Bắt tất cả các lỗi còn lại không thuộc Exception
          print('Unknown error parsing initial BidModel: $error');
          TLoaders.errorSnackBar(
            title: 'Unknown Error',
            message: 'An unexpected error occurred.',
          );
        }
      }
    });

   /// Listener cho cập nhật bid mới từ server
    _socket.on('updateBid', (data) {

      if (data != null) {
        try {
          highestBid.value = double.tryParse(data['highestBid']?.toString() ?? '') ?? 0.0;
          numOfBid.value+=1;
          highestBider.value = data["highestBidder"];
        } catch (e) {
          print('Error parsing new bid data: $e');
          TLoaders.errorSnackBar(title: 'Lỗi Cập Nhật', message: 'Không thể đọc dữ liệu bid mới.');
        }
      }


    });

    // Listener cho lỗi bid từ server
    _socket.on('bidError', (errorMessage) {
      print('BiddingController: Bid error from server: $errorMessage');
      TLoaders.errorSnackBar(title: 'Lỗi Đặt Bid', message: errorMessage ?? 'Có lỗi không xác định xảy ra khi đặt bid.');
    });
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final remaining = endDate.difference(now);

      if (remaining.isNegative) {
        timeLeft.value = 'Đấu giá đã kết thúc';
        isDisabled.value = true;
        _timer?.cancel(); // Hủy timer khi kết thúc
        _socket.emit('leaveAuction', productSlug); // Thông báo rời phiên đấu giá
      } else {
        // Định dạng thời gian còn lại (HH:MM:SS)
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        String twoDigitMinutes = twoDigits(remaining.inMinutes.remainder(60));
        String twoDigitSeconds = twoDigits(remaining.inSeconds.remainder(60));
        timeLeft.value = "${twoDigits(remaining.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
        isDisabled.value = false; // Đảm bảo nút không bị disable nếu còn thời gian
      }
    });
  }

  // Phương thức thiết lập số tiền bid từ UI
  void setBidAmount(String value) {
    bidAmount.value = value;
    bidAmountController.text = value;
    bidAmountController.selection = TextSelection.collapsed(offset: value.length);
  }

  // Phương thức xử lý khi người dùng nhấn nút "Đặt Bid"
  void placeBid() {
    if (isDisabled.value) {
      TLoaders.warningSnackBar(title: 'Đấu giá đã kết thúc', message: 'Bidding is closed for this product.');
      return;
    }
    if (bidAmount.value.isEmpty) {
      TLoaders.warningSnackBar(title: 'Bid không hợp lệ', message: 'Vui lòng nhập số tiền bid.');
      return;
    }

    final double? bidValue = double.tryParse(bidAmount.value);
    if (bidValue == null || bidValue <= 0) {
      TLoaders.warningSnackBar(title: 'Bid không hợp lệ', message: 'Vui lòng nhập một số dương hợp lệ cho bid của bạn.');
      return;
    }

    // Optional: Client-side validation against current highest bid
      if (highestBid.value != null && bidValue <= highestBid.value) {
        TLoaders.errorSnackBar(title: 'Bid quá thấp', message: 'Bid của bạn phải cao hơn bid hiện tại (${highestBid.value}).');
        return;
      }

    // Gửi bid lên server
    _socket.emit('placeBid', {
      'slug': productSlug,
      'bidAmount': bidValue,
      'accessToken': _accessToken,
    });
    setBidAmount('0');

    TLoaders.successSnackBar(title: 'Bid Đã Đặt', message: 'Bid của bạn \$${bidValue.toStringAsFixed(0)} đã được đặt.');
  }

  @override
  void onClose() {
    // Hủy timer
    _timer?.cancel();

    // Rời khỏi phiên đấu giá khi controller đóng
    _socket.emit('leaveAuction', productSlug);
    bidAmountController.dispose();

    // Loại bỏ các listener socket cụ thể của controller này
    _socket.off('initializeBid');
    _socket.off('newBid');
    _socket.off('bidError');
    _socket.off('connect'); // Loại bỏ listener chung đã thêm trong controller
    _socket.off('disconnect');
    _socket.off('connect_error');


    // Không gọi _socketService.disposeSocket() ở đây
    // vì ProductSocketService là singleton cho toàn bộ ứng dụng.
    // Chỉ nên dispose nó khi toàn bộ ứng dụng đóng hoặc khi không còn cần socket nữa.
    super.onClose();
  }
}