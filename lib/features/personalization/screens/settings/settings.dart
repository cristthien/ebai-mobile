import 'package:ebai/features/personalization/screens/my_auctions/my_auctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/custom_shapes/containers/circular_container_widget.dart';
import '../../../../common/texts/section_heading.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/local_storage/local_storage.dart';
import '../../../../utils/constants/color.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/screens/login/login.dart';
import '../create_auction/create_auction.dart';
import '../my_bids/my_bids.dart';
import '../my_orders/my_orders.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Future<void> _logout(BuildContext context) async {
    await TLocalStorage().clearAll();
    Get.offAll(() => const LoginScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// -- Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [

                  /// AppBar
                  TAppBar(title: Text('Account', style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white))),

                  /// User Profile Card
                  const TUserProfileTile(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                ],
              ),
            ),

            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [

                  /// -- Account Settings
                  const TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(icon: Iconsax.add_circle,
                      title: 'Create New Auction',
                      subTitle: 'Create and publish a new auction',
                      onTap: () => Get.to(() => const CreateAuction()) // <--- Corrected onTap and added MyOrders screen
                  ),
                  TSettingsMenuTile(icon: Icons.gavel,
                      title: 'My Auctions',
                      subTitle:  'Manage your listings for auction',
                      onTap: () => Get.to(() => const MyAuctions())
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'My Orders',
                      subTitle: 'In-progress and Completed Orders', // <--- Add a comma here if not already present
                      onTap: () => Get.to(() => const MyOrders()) // <--- Corrected onTap and added MyOrders screen
                  ),

                  TSettingsMenuTile(icon: Iconsax.bank,
                      title: 'My Bids',
                      subTitle: 'Check history of all bids',
                      onTap: () => Get.to(() => const MyBids())
                  ),
                  TSettingsMenuTile(icon: Iconsax.notification,
                      title: 'Notifications',
                      subTitle: 'Set any kind of notification message',
                      onTap: () => Get.to(() => const MyBids())
                  ),

                  const TSettingsMenuTile(icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts'),
                  /// -- App Settings
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(
                      title: 'App Settings', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  /// -- Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () {
                          _logout(context);
                        }, child: const Text('Logout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

