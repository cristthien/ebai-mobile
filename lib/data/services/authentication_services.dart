import 'package:get/get.dart'; // Import GetX
import '../../utils/http/http_client.dart'; // Đảm bảo đường dẫn đúng

class AuthenticationServices extends GetxController {
  // Endpoint đăng ký
  static const String _registerEndpoint = 'auth/register';
  static const String _loginEndpoint = 'auth/login';

  // Phương thức đăng ký người dùng
  /// Phương thức đăng ký người dùng
  /// Gửi request POST đến endpoint đăng ký với thông tin người dùng.
  ///
  /// Trả về Future<Map<String, dynamic>> chứa dữ liệu phản hồi từ server
  /// khi đăng ký thành công.
  /// Ném ra exception nếu có lỗi xảy ra trong quá trình gọi API.
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // Chuẩn bị dữ liệu gửi đi
      final Map<String, dynamic> requestData = {
        'username': username,
        'email': email,
        'password': password,
      };

      // Gửi request POST sử dụng helper
      final Map<String, dynamic> responseData = await THttpHelper.post(
        _registerEndpoint,
        requestData,
      );

      // In dữ liệu phản hồi (để debug)
      print('Registration successful response: $responseData');

      // TRẢ VỀ dữ liệu phản hồi khi thành công
      return responseData;

    } catch (e) {
      // Bắt lỗi, in ra thông báo lỗi chi tiết hơn
      print('Error during registration: $e');
      // Ném lại lỗi để code gọi hàm này có thể xử lý (ví dụ: hiển thị thông báo lỗi cho người dùng)
      rethrow; // Sử dụng rethrow giữ nguyên stack trace của lỗi gốc
    }
  }

  // Các phương thức xác thực khác (Google, Facebook, Logout, Delete User, v.v.)
  // mà bạn đã liệt kê trong comments, ví dụ:

  /// [EmailAuthentication] - SignIn
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'username': email,
        'password': password,
      };
      final Map<String, dynamic> responseData = await THttpHelper.post(
        _loginEndpoint, // Endpoint đăng nhập
        requestData,    // Dữ liệu email và password
      );
      // 3. In dữ liệu phản hồi (để debug)
      print('Login successful response: $responseData');
      // 4. TRẢ VỀ dữ liệu phản hồi khi thành công
      // Dữ liệu này thường chứa token xác thực, thông tin người dùng, v.v.
      return responseData;
    } catch (e) {
      print('Error during login: $e');

      // Ném lại lỗi để hàm gọi login() có thể bắt và xử lý (ví dụ: hiển thị thông báo lỗi cho người dùng)
      rethrow; // Giữ nguyên stack trace của lỗi gốc để dễ debug hơn
    }
  }

  /// [EmailAuthentication] - REGISTER
  // Phương thức register đã có ở trên.

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateUser() async {
    // Implement re-authenticate logic here
    throw UnimplementedError('reAuthenticateUser has not been implemented.');
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    // Implement email verification logic here
    throw UnimplementedError('sendEmailVerification has not been implemented.');
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    // Implement forget password logic here
    throw UnimplementedError('sendPasswordResetEmail has not been implemented.');
  }

  /* --------------------------------------------------------- Federated identity & social sign-in --------------------------------------------------------- */

  /// [GoogleAuthentication] - GOOGLE
  Future<Map<String, dynamic>> signInWithGoogle() async {
    // Implement Google sign-in logic here
    throw UnimplementedError('signInWithGoogle has not been implemented.');
  }

  /// [FacebookAuthentication] - FACEBOOK
  Future<Map<String, dynamic>> signInWithFacebook() async {
    // Implement Facebook sign-in logic here
    throw UnimplementedError('signInWithFacebook has not been implemented.');
  }

  /* ----------------------------------------------------- ./end Federated identity & social sign-in ----------------------------------------------------- */

  /// [LogoutUser] - Valid for any authentication.
  Future<void> logoutUser() async {
    // Implement logout logic here
    throw UnimplementedError('logoutUser has not been implemented.');
  }

  /// DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteUserAccount() async {
    // Implement delete user account logic here
    throw UnimplementedError('deleteUserAccount has not been implemented.');
  }
}