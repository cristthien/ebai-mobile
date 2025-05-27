import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../data/services/category_services.dart';
import '../../../utils/http/http_client.dart';
import '../models/category_model.dart';

class CreateAuctionController extends GetxController {
  static CreateAuctionController get instance => Get.find();

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  RxInt? selectedCategoryId = RxInt(0); // Khởi tạo với 0 hoặc null, sau đó validate
  RxList<CategoryModel> availableCategories = <CategoryModel>[].obs;
  RxBool fetchingCategories = false.obs; // Để hiển thị loader khi đang tải danh mục

  final TextEditingController startingBid = TextEditingController();
  final TextEditingController condition = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  final Map<int, TextEditingController> _specKeyControllers = {};
  final Map<int, TextEditingController> _specValueControllers = {};
  RxList<Map<String, String>> specifications = <Map<String, String>>[
    {'key': '', 'value': ''}
  ].obs;

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  RxList<XFile> selectedImages = <XFile>[].obs;

  final GlobalKey<FormState> createAuctionFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    _initializeSpecificationControllers();// Gọi hàm này khi controller được khởi tạo
  }
  void _initializeSpecificationControllers() {
    for (int i = 0; i < specifications.length; i++) {
      _specKeyControllers[i] = TextEditingController(text: specifications[i]['key']);
      _specValueControllers[i] = TextEditingController(text: specifications[i]['value']);
    }
  }

  // Lấy TextEditingController cho Key theo index
  TextEditingController getKeyController(int index) {
    if (!_specKeyControllers.containsKey(index)) {
      _specKeyControllers[index] = TextEditingController(text: specifications[index]['key']);
    }
    return _specKeyControllers[index]!;
  }

  // Lấy TextEditingController cho Value theo index
  TextEditingController getValueController(int index) {
    if (!_specValueControllers.containsKey(index)) {
      _specValueControllers[index] = TextEditingController(text: specifications[index]['value']);
    }
    return _specValueControllers[index]!;
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    startingBid.dispose();
    condition.dispose();
    brand.dispose();
    model.dispose();
    super.dispose();
  }

  // --- NEW: Fetch Categories from API ---
  Future<void> fetchCategories() async {
    try {
      fetchingCategories.value = true;
      final TCategoryService categoryService = TCategoryService();
      final categories = await categoryService.getCategoriesList();
      availableCategories.assignAll(categories);
      if (availableCategories.isNotEmpty) {
        selectedCategoryId!.value = availableCategories.first.id;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
      print(e);
    } finally {
      fetchingCategories.value = false;
    }
  }

  // --- Methods for Specifications ---
  void addSpecification() {
    specifications.add({'key': '', 'value': ''});
    // Khi thêm mới, cũng cần tạo controller mới cho cặp này
    final newIndex = specifications.length - 1;
    _specKeyControllers[newIndex] = TextEditingController(text: '');
    _specValueControllers[newIndex] = TextEditingController(text: '');
  }

  void updateSpecificationKey(int index, String key) {
    if (index >= 0 && index < specifications.length) {
      specifications[index]['key'] = key;
      // Không cần specifications.refresh() ở đây nữa vì TextController đã tự cập nhật
    }
  }

  void updateSpecificationValue(int index, String value) {
    if (index >= 0 && index < specifications.length) {
      specifications[index]['value'] = value;
      // Không cần specifications.refresh() ở đây nữa
    }
  }

  void removeSpecification(int index) {
    if (index >= 0 && index < specifications.length) {
      specifications.removeAt(index);
      // Khi xóa, cần dispose controller tương ứng và dọn dẹp map
      _specKeyControllers.remove(index)?.dispose();
      _specValueControllers.remove(index)?.dispose();

      // Cập nhật lại các key trong map controllers để tránh trùng lặp khi index thay đổi
      // Đây là một cách đơn giản, có thể cần phức tạp hơn nếu bạn có ID duy nhất cho mỗi spec
      // For simplicity, we just clear and re-initialize if the order matters
      _specKeyControllers.clear();
      _specValueControllers.clear();
      _initializeSpecificationControllers(); // Tái khởi tạo lại controllers sau khi xóa
    }
  }

  // --- Image Picker ---
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage(
      imageQuality: 70,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (images != null && images.isNotEmpty) {
      selectedImages.addAll(images);
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  // --- Date Pickers ---
  Future<void> pickStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(startDate.value ?? DateTime.now()),
      );
      if (pickedTime != null) {
        startDate.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? startDate.value ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: startDate.value ?? DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(endDate.value ?? DateTime.now()),
      );
      if (pickedTime != null) {
        endDate.value = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  // --- Create Auction Logic (Cập nhật category_id) ---
  Future<void> createAuction() async {
    try {
      isLoading.value = true;


      if (!createAuctionFormKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      // Validate selected category
      if (selectedCategoryId!.value == 0 || selectedCategoryId!.value == null) { // Giả sử 0 là giá trị mặc định cho "Choose Category"
        Get.snackbar('Error', 'Please select a category.');
        isLoading.value = false;
        return;
      }
      if (selectedImages.isEmpty) {
        Get.snackbar('Error', 'Please select at least one image.');
        isLoading.value = false;
        return;
      }
      if (startDate.value == null || endDate.value == null) {
        Get.snackbar('Error', 'Please select both start and end dates.');
        isLoading.value = false;
        return;
      }
      if (startDate.value!.isAfter(endDate.value!)) {
        Get.snackbar('Error', 'Start date cannot be after end date.');
        isLoading.value = false;
        return;
      }

      // 1. Cập nhật dữ liệu từ TextEditingControllers vào specifications RxList
      // Điều này quan trọng để đảm bảo dữ liệu mới nhất từ UI được đưa vào RxList
      for (int i = 0; i < specifications.length; i++) {
        specifications[i]['key'] = getKeyController(i).text; // Lấy từ controller của nó
        specifications[i]['value'] = getValueController(i).text; // Lấy từ controller của nó
      }

      final List<Map<String, String>> validSpecifications = specifications.where(
              (spec) => spec['key']!.isNotEmpty && spec['value']!.isNotEmpty
      ).toList();

      // 2. Chuẩn bị các trường dữ liệu (fields) cho FormData
      final Map<String, String> fields = {
        'name': name.text.trim(),
        'description': description.text.trim(),
        'category_id': selectedCategoryId!.value.toString(),
        'starting_bid': startingBid.text.trim(),
        'start_date': startDate.value!.toUtc().toIso8601String(), // Gửi UTC
        'end_date': endDate.value!.toUtc().toIso8601String(),       // Gửi UTC
        'condition': condition.text.trim(),
        'brand': brand.text.trim(),
        'model': model.text.trim(),
        'specifications': json.encode(validSpecifications),
      };

      // 3. Chuẩn bị các file ảnh (files) cho FormData
      final List<http.MultipartFile> imageFiles = [];
      for (XFile image in selectedImages) {
        imageFiles.add(
          await http.MultipartFile.fromPath(
            'images', // Tên trường mà server của bạn mong đợi cho các file ảnh (phải khớp với backend)
            image.path,
            filename: image.name, // Tên file gốc
          ),
        );
      }

      // 4. Gọi API POST với FormData
      print('Sending Auction Fields: $fields');
      print('Sending Auction Images count: ${imageFiles.length}');
      // print('Sending Auction Images names: ${imageFiles.map((e) => e.filename)}');

      final response = await THttpHelper.postMultipart(
        'auctions', // <-- Thay thế bằng endpoint POST API của bạn (ví dụ: 'auctions', 'api/v1/products')
        fields,
        imageFiles,
      );

      // 5. Xử lý phản hồi từ API
      if (response['statusCode'] == 200 || response['statusCode'] == 201) {
        Get.snackbar('Success', 'Auction created successfully!');
        clearForm();
        Get.back(); // Quay lại màn hình trước
      } else {
        // THttpHelper đã xử lý hiển thị snackbar lỗi, chỉ cần ném exception để ngắt flow
        throw Exception(response['message'] ?? 'Failed to create auction.');
      }

    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to create auction: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    name.clear();
    description.clear();
    // categoryId.clear(); // BỎ DÒNG NÀY ĐI
    selectedCategoryId!.value = 0; // Reset về giá trị mặc định
    startingBid.clear();
    condition.clear();
    brand.clear();
    model.clear();
    specifications.value = [{'key': '', 'value': ''}];
    startDate.value = null;
    endDate.value = null;
    selectedImages.clear();
    createAuctionFormKey.currentState?.reset();
  }
}