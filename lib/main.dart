import 'package:english_dictionary/core/module_init.dart';
import 'package:english_dictionary/core/router/navigator_observer.dart';
import 'package:english_dictionary/core/router/routes.dart';
import 'package:english_dictionary/core/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final globalRouteObserver = GlobalRouteObserver();

  WidgetsFlutterBinding.ensureInitialized();
  _sqfliteTestInit();
  AppModule(navigatorKey).configure();

  return runApp(AppWidget(navigatorKey, globalRouteObserver));
}

class AppWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  final GlobalRouteObserver _globalRouteObserver;
  const AppWidget(
    this._navigatorKey,
    this._globalRouteObserver, {
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        widget._globalRouteObserver,
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      navigatorKey: widget._navigatorKey,
      title: 'Word Explorer',
      theme: AppTheme.themeData,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}

void _sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}
