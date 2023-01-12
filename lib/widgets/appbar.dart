import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  bool showBackButton = false;
  List<Widget> actions = [];
  CustomAppBar(
      {super.key,
      required this.title,
      this.showBackButton = false,
      this.actions = const []});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      automaticallyImplyLeading: widget.showBackButton,
      centerTitle: false,
      actions: widget.actions,
      elevation: 0,
    );
  }
}
