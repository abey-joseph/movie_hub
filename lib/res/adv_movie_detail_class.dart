class AdvMovie {
  final int id;
  final String title;
  final String poster;
  final String backDrop;
  final String overView;
  final String year;
  final double rating;
  final double runTime;
  final String language;
  final String category;
  final List<String> starring;
  final List<String> directors;
  final List<String> producers;
  final List<String> writers;

  AdvMovie({
    required this.id,
    required this.title,
    required this.poster,
    required this.backDrop,
    required this.overView,
    required this.year,
    required this.rating,
    required this.runTime,
    required this.language,
    required this.category,
    required this.starring,
    required this.directors,
    required this.producers,
    required this.writers,
  });
}
