import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieService {
  static final MovieService _instance = MovieService._internal();
  factory MovieService() => _instance;
  MovieService._internal();

  final String apiKey = dotenv.env['TMDBKEY'] ?? '';
  List forYouList = [];
  List topTrendingList = [];
  List nowPlayingList = [];
  List popularList = [];
  List topRatedList = [];
  List upComingList = [];

  Future<void> fetchAllMovies() async {
    await Future.wait([
      fetchMovies('trending', topTrendingList),
      fetchMovies('now_playing', nowPlayingList),
      fetchMovies('popular', popularList),
      fetchMovies('top_rated', topRatedList),
      fetchMovies('upcoming', upComingList),
      fetchMovies(
          'discover', forYouList), // forYouList can be customized if desired
    ]);
  }

  Future<void> fetchMovies(String category, List listToPopulate) async {
    String url;

    switch (category) {
      case 'trending':
        url = 'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey';
        break;
      case 'now_playing':
        url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
        break;
      case 'popular':
        url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
        break;
      case 'top_rated':
        url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
        break;
      case 'upcoming':
        url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';
        break;
      case 'discover':
        url = 'https://api.themoviedb.org/3/discover/movie?api_key=$apiKey';
        break;
      default:
        throw Exception('Unknown category');
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final movies = data['results']
          .take(10) // Limit to 10 movies per category
          .map((movie) => {
                'title': movie['title'],
                'posterPath':
                    'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                'backdropPath':
                    'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}'
              })
          .toList();
      listToPopulate.addAll(movies);
    } else {
      throw Exception('Failed to load $category movies');
    }
  }
}
