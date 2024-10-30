
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

import '../model/repository.dart';


class RepoController extends GetxController {
  var repositories = <Repository>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isDarkMode = false.obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = storage.read('isDarkMode') ?? false;
  }

  void fetchRepositories(String username) async {
    isLoading.value = true;
    errorMessage.value = '';
    repositories.clear();

    final url = 'https://api.github.com/users/$username/repos';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        repositories.value = data.map((e) => Repository.fromJson(e)).toList();
      } else {
        errorMessage.value = 'User not found';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    storage.write('isDarkMode', isDarkMode.value);
  }
}
