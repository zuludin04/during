import 'package:during/flavor_config.dart';
import 'package:during/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  FlavorConfig('prod', 'ca-app-pub-8689174357144809/7485526554',
      'ca-app-pub-8689174357144809/6172444887');
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}
