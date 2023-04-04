
import 'package:flutter/material.dart';
import 'package:teachmantra/views/dashboard/profile_screen.dart';
import '../../routes/arguments.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/drawer_widget.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'my_class.dart';
import 'my_order_screen.dart';

class MainHomeScreen extends StatefulWidget {
  final OtpArguments? arguments;
  MainHomeScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  bool isMenuOpen = false;
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.arguments!.bottomIndex != 0) {
      _currentIndexNotifier.value = widget.arguments!.bottomIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: _buildBody(currentIndex),
          drawer: Drawer(
            backgroundColor: Colors.white,
            elevation: 0,
            width: ScreenUtil().screenWidth * 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Sizes.s20.r),
                bottomRight: Radius.circular(Sizes.s20.r),
              ),
            ),
            child: const DrawerWidget(),
          ),
          bottomNavigationBar: PrimaryBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(int _selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
          return const CategoriesScreen();
      case 2:
        return const MyClassScreen();
      case 3:
        return const ProfileScreen();
      default:
    }
    return Container();
  }
}
