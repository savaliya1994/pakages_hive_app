import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_app/url_launcher.dart';
import 'package:hive_app/video_player.dart';
import 'package:hive_app/webview_screen.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'google_map.dart';
import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await Permission.location.isDenied) {
    Permission.location.request();
  }

  Directory directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  await Hive.openBox<String>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UrlScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
