import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/repo_controller.dart';


class HomeScreen extends StatelessWidget {
  final RepoController repoController = Get.find();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repo Viewer'),
        actions: [
          IconButton(
            icon: Icon(repoController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode),
            onPressed: repoController.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Enter GitHub Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty) {
                  repoController.fetchRepositories(usernameController.text);
                }
              },
              child: Text('Fetch Repos'),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (repoController.isLoading.value) {
                return CircularProgressIndicator();
              }
              if (repoController.errorMessage.value.isNotEmpty) {
                return Column(
                  children: [
                    Text(repoController.errorMessage.value, style: TextStyle(color: Colors.red)),
                    ElevatedButton(
                      onPressed: () => repoController.fetchRepositories(usernameController.text),
                      child: Text('Retry'),
                    ),
                  ],
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: repoController.repositories.length,
                  itemBuilder: (context, index) {
                    final repo = repoController.repositories[index];
                    return ListTile(
                      title: Text(repo.name),
                      subtitle: Text(repo.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('⭐ ${repo.stars}'),
                          SizedBox(width: 10),
                          Text(repo.language),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
