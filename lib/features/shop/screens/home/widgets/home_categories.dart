
import 'package:flutter/material.dart';

import '../../../../../common/image_text_widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            icon: Icons.smartphone,
            title: 'Shoes',
            onTap: () {},
          ); // TVerticalImageText
        },
      ), // ListView.builder
    );
  }
}

