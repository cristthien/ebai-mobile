import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/bidding_controller.dart';

class BiddingComponent extends GetxController{


  @override
  Widget build(BuildContext context) {
    // const controller = Get.put(BiddingController());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hiển thị trạng thái kết nối Socket
          Obx(() => Text(
            'dfdf',
            style: TextStyle(
              // color: controller.isSocketConnected.value ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Tăng kích thước chữ để dễ nhìn
            ),
          )),
        ],
      ),
    );
  }
}