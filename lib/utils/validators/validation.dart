 class TValidator {
   static String? validateEmail(String? value) {
     if (value == null || value.isEmpty) {
       return 'Email is required.';
     }

     // Sử dụng regex tương đồng với kiểm tra email chuẩn (như @IsEmail)
     // Regex này được cải tiến để phù hợp hơn với các tiêu chuẩn email phổ biến
     final emailRegExp = RegExp(
         r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
     );

     if (!emailRegExp.hasMatch(value)) {
       return 'Invalid email address.';
     }

     return null;
   }

   // Validator cho Password
   static String? validatePassword(String? value) {
     if (value == null || value.isEmpty) {
       return 'Password is required.';
     }

     // Kiểm tra độ dài tối thiểu (>= 8)
     if (value.length < 8) {
       return 'Password must be at least 8 characters long.';
     }

     // Kiểm tra độ dài tối đa (<= 20)
     if (value.length > 20) {
       return 'Password must be no longer than 20 characters.';
     }

     // Kiểm tra có ít nhất một số (\d)
     if (!value.contains(RegExp(r'\d'))) {
       return 'Password must contain at least one number.';
     }

     // Kiểm tra có ít nhất một ký tự đặc biệt từ tập [@$!%*?&]
     // Điều chỉnh regex để khớp chính xác với backend
     if (!value.contains(RegExp(r'[@$!%*?&]'))) {
       return 'Password must contain at least one special character.';
     }

     // Lưu ý: Backend có @Matches(/[A-Za-z0-9@$!%*?&]/).
     // Nếu các kiểm tra riêng lẻ về số và ký tự đặc biệt được đáp ứng,
     // kiểm tra này thường sẽ tự động đúng nếu mật khẩu còn chứa ký tự chữ.
     // Chúng ta không cần thêm regex riêng cho điều kiện này nếu đã kiểm tra số và ký tự đặc biệt.
     // Nếu backend yêu cầu ít nhất 1 chữ cái (ngoài số và ký tự đặc biệt), bạn có thể thêm kiểm tra
     // if (!value.contains(RegExp(r'[A-Za-z]'))) { return 'Password must contain at least one letter.'; }
     // Tuy nhiên, dựa vào các regex backend cung cấp, chỉ số và @$!%*?& là bắt buộc rõ ràng.

     // Kiểm tra không chứa khoảng trắng (thường nên có trong password validation)
     if (value.contains(' ')) {
       return 'Password cannot contain spaces.';
     }


     return null; // Mật khẩu hợp lệ
   }

   // Validator cho Username
   static String? validateUsername(String? value) {
     if (value == null || value.isEmpty) {
       return 'Username is required.';
     }

     // Kiểm tra độ dài tối thiểu (>= 3)
     if (value.length < 3) {
       return 'Username must be at least 3 characters long.';
     }

     // Kiểm tra độ dài tối đa (<= 20)
     if (value.length > 20) {
       return 'Username must be no longer than 20 characters.';
     }

     // Bạn có thể thêm các kiểm tra khác cho username nếu backend có
     // Ví dụ: chỉ cho phép chữ, số, gạch dưới:
     // if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
     //   return 'Username can only contain letters, numbers, and underscores.';
     // }


     return null; // Username hợp lệ
   }
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }
}
