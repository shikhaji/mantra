// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

import '../utils/app_text_style.dart';
import '../utils/screen_utils.dart';
import 'app_text.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // titleSpacing: 10,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColor.red,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SecondaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? action;
  final double? elevation;
  final bool? isLeading;
  final VoidCallback? onBackPressed;
  final IconData? leadingIcon;

  const SecondaryAppBar({
    Key? key,
    this.title,
    this.action,
    this.isLeading = true,
    this.elevation,
    this.leading,
    this.leadingIcon,
    this.onBackPressed,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SecondaryAppBarState createState() => _SecondaryAppBarState();
}

class _SecondaryAppBarState extends State<SecondaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: widget.elevation,
        centerTitle: true,
        title: appText(
          widget.title ?? "",
          style: AppTextStyle.appBarTextTitle.copyWith(color: AppColor.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: widget.action),
          )
        ],
        leading: widget.isLeading == true
            ? IconButton(
          icon: Icon(
            widget.leadingIcon ?? Icons.arrow_back_ios_outlined,
            color: AppColor.black,
          ),
          onPressed: widget.onBackPressed ??
                  () {
                Navigator.pop(context);
              },
        )
            : const SizedBox.shrink());
  }
}



