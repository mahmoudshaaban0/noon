import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noon/features/cart/presentation/screens/cart_screen.dart';
import 'package:noon/features/home/screens/home_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late PersistentTabController controller;

  @override
  void initState() {
    super.initState();

    controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentTabConfig> _tabs() {
    return [
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: ItemConfig(
          title: 'Home',
          icon: const Icon(CupertinoIcons.home),
        ),
      ),
      PersistentTabConfig(
        screen: const SizedBox(),
        item: ItemConfig(
          title: 'Categories',
          icon: const Icon(CupertinoIcons.doc_on_clipboard),
        ),
      ),
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: ItemConfig(
          title: 'Account',
          icon: const Icon(CupertinoIcons.person),
        ),
      ),
      PersistentTabConfig(
        screen: const CartScreen(),
        item: ItemConfig(
          title: 'Cart',
          icon: const Icon(CupertinoIcons.shopping_cart),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
            tabs: _tabs(),
            controller: controller,
            avoidBottomPadding: false,
            navBarHeight: 70,
            navBarBuilder: (navBarConfig) =>
                Style1BottomNavBar(navBarConfig: navBarConfig)));
  }
}
