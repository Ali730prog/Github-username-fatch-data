import 'package:api/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/repo_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RepoController repoController = Get.put(RepoController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'GitHub Repo Viewer',
      theme: repoController.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    ));
  }
}
