import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viapp/env/environment.dart';
import 'package:viapp/env/theme/app_theme.dart';
import 'package:viapp/shared/providers/functional_provider.dart';
import 'package:viapp/shared/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String environment = const String.fromEnvironment('ENVIRONMENT',defaultValue: Environment.dev);
  Environment().initConfig(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MultiProvider(
      providers: [
       ChangeNotifierProvider(create: (_) => FunctionalProvider()),
      ],
      child: MaterialApp(
        title: 'VIAPP',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
