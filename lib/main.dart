import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marvel/helper/connection_helper.dart';

import 'package:marvel/helper/route_helper.dart';

import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConnectionHelper.checkInternetConnection();

  if (ConnectionHelper.haveConnection) {
    await dep.init();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marvel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
