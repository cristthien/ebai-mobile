import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/texts/section_heading.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/create_new_auction_controller.dart';
class CreateAuction extends StatelessWidget {
  const CreateAuction({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateAuctionController());
    final DateFormat formatter = DateFormat('MMM dd, BCE HH:mm');

    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Create New Auction')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.createAuctionFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TSectionHeading(title: 'Product Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TextFormField(
                controller: controller.name,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty ? 'Product name is required.' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TextFormField(
                controller: controller.description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Description is required.' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // --- Thay thế TextFormField cho Category ID bằng DropdownButtonFormField ---
              Obx(() {
                if (controller.fetchingCategories.value) {
                  return const Text('Submiting Auction'); // Hoặc một Shimmer loader cho dropdown
                }
                if (controller.availableCategories.isEmpty) {
                  return Text('No categories available. Please try again later.', style: Theme.of(context).textTheme.bodySmall);
                }
                return DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Category'),
                  value: controller.selectedCategoryId!.value == 0 || controller.selectedCategoryId!.value == null
                      ? null // Set to null if default/no selection
                      : controller.selectedCategoryId!.value,
                  hint: const Text('Select a category'),
                  items: [
                    // Tùy chọn, thêm một item "Choose Category" không chọn được
                    // DropdownMenuItem(
                    //   value: 0, // Giá trị 0 hoặc null cho "Choose Category"
                    //   child: const Text('Choose Category', style: TextStyle(color: Colors.grey)),
                    // ),
                    ...controller.availableCategories.map((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name),
                      );
                    }).toList(),
                  ],
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      controller.selectedCategoryId!.value = newValue;
                    }
                  },
                  validator: (value) {
                    if (value == null || value == 0) { // Validate nếu chưa chọn
                      return 'Please select a category.';
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(height: TSizes.spaceBtwItems),
              // --- Hết phần DropdownButtonFormField ---

              TextFormField(
                controller: controller.startingBid,
                decoration: const InputDecoration(labelText: 'Starting Bid'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Starting bid is required.' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TextFormField(
                controller: controller.condition,
                decoration: const InputDecoration(labelText: 'Condition (e.g., New, Used)'),
                validator: (value) => value == null || value.isEmpty ? 'Condition is required.' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TextFormField(
                controller: controller.brand,
                decoration: const InputDecoration(labelText: 'Brand'),
                validator: (value) => value == null || value.isEmpty ? 'Brand is required.' : null,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TextFormField(
                controller: controller.model,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              const TSectionHeading(title: 'Specifications (Key-Value)', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.specifications.length,
                itemBuilder: (_, index) {
                  // Lấy controller từ CreateAuctionController
                  final keyController = controller.getKeyController(index);
                  final valueController = controller.getValueController(index);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: TSizes.sm),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: keyController, // Dùng controller được quản lý
                            decoration: const InputDecoration(labelText: 'Key'),
                            onChanged: (value) {
                              controller.updateSpecificationKey(index, value); // Cập nhật dữ liệu
                            },
                          ),
                        ),
                        const SizedBox(width: TSizes.sm),
                        Expanded(
                          child: TextFormField(
                            controller: valueController, // Dùng controller được quản lý
                            decoration: const InputDecoration(labelText: 'Value'),
                            onChanged: (value) {
                              controller.updateSpecificationValue(index, value); // Cập nhật dữ liệu
                            },
                          ),
                        ),
                        const SizedBox(width: TSizes.sm),
                        if (controller.specifications.length > 1)
                          IconButton(
                            icon: const Icon(Iconsax.trash),
                            onPressed: () {
                              // Khi xóa, cần cập nhật UI và controller
                              controller.removeSpecification(index);
                            },
                            color: TColors.error,
                          ),
                      ],
                    ),
                  );
                },
              )),
              const SizedBox(height: TSizes.spaceBtwItems/4),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: controller.addSpecification,
                  icon: const Icon(Iconsax.add),
                  label: const Text('Add More Specification'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),


              const TSectionHeading(title: 'Auction Schedule', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() => ListTile(
                title: Text(
                  controller.startDate.value == null
                      ? 'Select Start Date'
                      : 'Start Date: ${formatter.format(controller.startDate.value!)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Iconsax.calendar_1),
                onTap: () => controller.pickStartDate(context),
              )),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() => ListTile(
                title: Text(
                  controller.endDate.value == null
                      ? 'Select End Date'
                      : 'End Date: ${formatter.format(controller.endDate.value!)}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                trailing: const Icon(Iconsax.calendar_1),
                onTap: () => controller.pickEndDate(context),
              )),
              const SizedBox(height: TSizes.spaceBtwSections),

              const TSectionHeading(title: 'Product Images', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: controller.pickImages,
                  icon: const Icon(Iconsax.image),
                  label: const Text('Add Images'),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Obx(() {
                if (controller.selectedImages.isEmpty) {
                  return const Text('No images selected yet.');
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.selectedImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: TSizes.md,
                    mainAxisSpacing: TSizes.md,
                  ),
                  itemBuilder: (_, index) {
                    final image = controller.selectedImages[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                          child: Image.file(
                            File(image.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => controller.removeImage(index),
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: TColors.black,
                              child: Icon(Iconsax.close_square, color: TColors.white, size: TSizes.iconSm),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
              const SizedBox(height: TSizes.spaceBtwSections),

              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.createAuction,
                  child: controller.isLoading.value
                      ?const Text('Submiting Auction')
                      : const Text('Create Auction'),
                ),
              )),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}