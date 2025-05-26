import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/color.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_images.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
      title: Text('Coding with T', style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text('support@codingwitht.com', style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}