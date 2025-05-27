import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class AddressEditPopup extends StatefulWidget {
  final String? initialAddress;
  final String? initialPhoneNumber;
  final Function(String newAddress, String newPhoneNumber) onSave;

  const AddressEditPopup({
    super.key,
    this.initialAddress,
    this.initialPhoneNumber,
    required this.onSave,
  });

  @override
  State<AddressEditPopup> createState() => _AddressEditPopupState();
}

class _AddressEditPopupState extends State<AddressEditPopup> {
  late TextEditingController _addressController;
  late TextEditingController _phoneNumberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.initialAddress ?? '');
    _phoneNumberController = TextEditingController(text: widget.initialPhoneNumber ?? '');
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.cardRadiusLg)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // Màu nền của popup
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Update Order Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: TTexts.address,
                    hintText: 'Enter complete address',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  maxLines: 3, // Cho phép nhập nhiều dòng cho địa chỉ
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                TextFormField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: TTexts.phoneNo,
                    hintText: 'Enter phone number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number cannot be empty';
                    }
                    if (!GetUtils.isPhoneNumber(value)) { // Sử dụng GetX để validate SĐT
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onSave(_addressController.text.trim(), _phoneNumberController.text.trim());
                          Get.back(); // Đóng popup
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}