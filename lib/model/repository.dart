class Repository {
  final String name;
  final String description;
  final int stars;
  final String language;

  Repository({required this.name, required this.description, required this.stars, required this.language});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'] ?? 'No name',
      description: json['description'] ?? 'No description',
      stars: json['stargazers_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
    );
  }
}
