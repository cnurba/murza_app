import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:murza_app/app/brands/presentation/brands_screen.dart';
import 'package:murza_app/app/profile/application/current_user/current_user_provider.dart';
import 'package:murza_app/app/profile/presentation/profile_screen.dart';
import 'package:murza_app/core/presentation/global/toast.dart';
import 'package:murza_app/core/presentation/navs/nav_bar.dart';
import 'package:murza_app/core/presentation/navs/tab_holder.dart';
import 'app/orders/presentation/orders/orders_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _tabController = CupertinoTabController();
  final _toastKey = GlobalKey<ToastState>();

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => ref.read(currentUserProvider.notifier).loadCurrentUser(),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  /// System back button tap count.
  var _backTapCount = 0;
  final _tabHistory = [0];
  final _tabHolders = {
    0: GlobalKey<TabNavigatorHolderState>(),
    1: GlobalKey<TabNavigatorHolderState>(),
    2: GlobalKey<TabNavigatorHolderState>(),
    3: GlobalKey<TabNavigatorHolderState>(),
    4: GlobalKey<TabNavigatorHolderState>(),
  };

  void _onTabChanged(int newTab) {
    final previous = _tabHistory.last;
    _tabHistory.add(newTab);
    if (_tabHistory.length > 2) {
      _tabHistory.removeAt(0);
    }
    if (previous == newTab) {
      // go to the tab's root
      _tabHolders[previous]?.currentState?.navigator.popUntil(
        ModalRoute.withName('/'),
      );
    }
  }

  Future<bool> _onTabPopped() {
    const backTapLimit = 2;
    final currentTab = _tabHistory.last;
    final currentTabNavigator =
        _tabHolders[currentTab]?.currentState?.navigator;
    if (currentTabNavigator!.canPop()) {
      _backTapCount = 0;
      currentTabNavigator.pop();
    } else if (currentTab != 0) {
      _backTapCount = 0;
      _tabController.index = 0;
      _tabHistory.add(0);
      if (_tabHistory.length > 2) {
        _tabHistory.removeAt(0);
      }
    } else {
      _backTapCount++;
      if (_backTapCount < backTapLimit) {
        _toastKey.currentState!.showToast(
          child: const Text("Чтобы выйти нажмите еще раз"),
        );
      }
    }
    return Future.value(_backTapCount == backTapLimit);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onTabPopped,
      child: CupertinoTabScaffold(
        controller: _tabController,
        tabBuilder: (context, tab) {
          return CupertinoTabView(
            builder: (context) {
              switch (tab) {
                case 0:
                  return TabNavigatorHolder(
                    key: _tabHolders[0],
                    child: const BrandsScreen(),
                  );
                case 1:
                  return TabNavigatorHolder(
                    key: _tabHolders[1],
                    child: const OrdersScreen(),
                  );
                case 2:
                  return TabNavigatorHolder(
                    key: _tabHolders[2],
                    child: const ProfileScreen(),
                  );

                default:
                  return TabNavigatorHolder(
                    key: _tabHolders[2],
                    child: Scaffold(
                      body: Column(
                        children: [
                          const Spacer(),
                          Center(child: Text('Tab $tab')),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
              }
            },
          );
        },
        tabBar: NavBar(
          onTab: (newTab) {
            if (newTab == 0) {
              //context.read<DeliveryListCubit>().load(status: 0);
            } else {
              // context.read<DeliveryListCubit>().load(status: 1);
            }
            _onTabChanged(newTab);
          },
        ),
      ),
    );
  }
}
