import 'package:during/flavor_config.dart';
import 'package:during/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  FlavorConfig('dev', 'ca-app-pub-3940256099942544/6300978111',
      'ca-app-pub-3940256099942544/1033173712');
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}
