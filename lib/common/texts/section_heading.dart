import 'package:flutter/material.dart'; // Đảm bảo đã import

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'View all',
    required this.title,
    this.showActionButton = true,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final VoidCallback? onPressed; // Changed from Function()? to VoidCallback? for clarity

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton) // Sử dụng if (showActionButton) thay vì if (showActionButton) TextButton
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    ); // Row
  }
}