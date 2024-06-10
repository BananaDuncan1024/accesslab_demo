import 'package:accesslab_demo/app/app.bottomsheets.dart';
import 'package:accesslab_demo/app/app.dialogs.dart';
import 'package:accesslab_demo/app/app.environment.dart';
import 'package:accesslab_demo/app/app.locator.dart';
import 'package:accesslab_demo/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupEnvironment();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  Logger.level = Level.verbose;

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AccessLab',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.userListView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
