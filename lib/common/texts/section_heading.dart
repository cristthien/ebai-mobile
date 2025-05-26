import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    required this.title,
    this.showActionButton = true,
    this.actionButton,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title;
  final VoidCallback? onPressed;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showActionButton && actionButton != null)
          IconButton(onPressed: onPressed, icon: actionButton!)
      ],
    );
  }
}
