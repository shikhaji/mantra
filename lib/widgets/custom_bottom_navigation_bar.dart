import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';
import '../utils/screen_utils.dart';


class PrimaryBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PrimaryBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      showSelectedLabels: true,
      selectedLabelStyle:
      AppTextStyle.body1.copyWith(color: AppColor.primaryColor),
      unselectedLabelStyle: AppTextStyle.body1,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: _buildImageIcon(AppAsset.home),
          activeIcon: _buildImageIcon(AppAsset.homeFill),
        ),
        BottomNavigationBarItem(

          label: 'Courses',
          icon: _buildImageIcon(AppAsset.category),
          activeIcon: _buildImageIcon(AppAsset.categoryFill),
        ),
        BottomNavigationBarItem(
          label: 'My Class',
          icon: _buildImageIcon(AppAsset.bag),
          activeIcon: _buildImageIcon(AppAsset.bagFill),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: _buildImageIcon(AppAsset.userProfile),
          activeIcon: _buildImageIcon(AppAsset.userProfileFill),
        ),
      ],
    );
  }

  Widget _buildImageIcon(String imagePath, {double size = 22}) {
    return Image.asset(
      imagePath,
      height: ScreenUtil().setHeight(size),
      width: ScreenUtil().setHeight(size),
    );
  }
}