import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final void Function()? onPress, onActionPress;
  final bool isLeading, isAction;
  final IconData icon, actionIcon;
  const CustomAppBarWidget({
    super.key,
    required this.text,
    this.onPress,
    required this.isLeading,
    this.onActionPress,
    this.isAction = false,
    this.icon = Icons.home,
    this.actionIcon = Icons.exit_to_app,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Color(0xFF00d5fa),
          fontWeight: FontWeight.bold,
          fontFamily: 'elhelw',
        ),
      ),
      actions: [
        isAction
            ? IconButton(
                onPressed: onActionPress,
                icon: Icon(actionIcon),
              )
            : const SizedBox(),
      ],
      leading: isLeading
          ? IconButton(
              onPressed: onPress,
              icon: Icon(icon),
            )
          : null,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
