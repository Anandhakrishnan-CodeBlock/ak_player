import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation/bottom_navigation.dart';
import 'bottom_sheet/bottom_sheet_screen.dart';
import 'grid_view/grid_screen.dart';
import 'list_view/list_screen.dart';
import 'tab_view/tab_screen.dart';
import 'web_macos/web_macos_grid_screen.dart';

class AppNavigationDrawer extends StatefulWidget {
  const AppNavigationDrawer({super.key});

  @override
  State<StatefulWidget> createState() => AppNavigationDrawerState();
}

class AppNavigationDrawerState extends State<AppNavigationDrawer> {
  int _selectedIndex = 0;
  final List<Widget> _child = [
    Container(),
    TabScreen(),
    BottomNavigation(),
    BottomSheetScreen(),
    ListScreen(),
    GridScreen(),
    WebMacosGridScreen(),
  ];
  final List<String> _title = [
    "All",
    "Tab Bar View",
    "Bottom Navigation Bar",
    "Bottom Sheet",
    "List View",
    "Grid View",
    "Web / Mac OS Grid View",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title[_selectedIndex])),
      drawer: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          checkPlatform(index);
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Text(
              'Options',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.space_dashboard_outlined),
            selectedIcon: Icon(Icons.space_dashboard),
            label: Text('All'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.featured_video_outlined),
            selectedIcon: Icon(Icons.featured_video_rounded),
            label: Text('Tab Bar View'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.padding_outlined),
            selectedIcon: Icon(Icons.padding_rounded),
            label: Text('Bottom Navigation Bar'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.call_to_action_outlined),
            selectedIcon: Icon(Icons.call_to_action_rounded),
            label: Text('Bottom Sheet'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.view_list_outlined),
            selectedIcon: Icon(Icons.view_list_rounded),
            label: Text('List View'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.grid_view),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: Text('Grid View'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.grid_view),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: Text('Web / Mac OS Grid View'),
          ),
        ],
      ),

      body: IndexedStack(index: _selectedIndex, children: _child),
      //body: _child[_selectedIndex],
    );
  }

  void checkPlatform(int index) {
    final isMacOrWeb = kIsWeb || defaultTargetPlatform == TargetPlatform.macOS;

    final isAndroidOrIOS =
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);

    if (index == 6 && !isMacOrWeb) {
      Navigator.of(context).pop();
      _showUnsupportedDialog('This view is only available on macOS and Web.');
      return;
    }

    if (index > 0 && index < 6 && !isAndroidOrIOS) {
      Navigator.of(context).pop();
      _showUnsupportedDialog('This view is only available on Android and iOS.');
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  void _showUnsupportedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsupported Platform'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
