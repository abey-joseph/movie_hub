import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_hub/res/adv_movie_detail_class.dart';

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
                ...movie, // Spread all fields from each movie object
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

// Search Function

Future<List> searchMovies(String query) async {
  // Get API key from .env
  final apiKey = dotenv.env['TMDBKEY'];

  // Ensure apiKey is not null or empty
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API key not found. Check your .env file.');
  }

  // URL for the search endpoint with the query and API key
  final url = Uri.parse(
    'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}',
  );

  // Send the GET request to TMDB
  final response = await http.get(url);

  // Check if the response is successful
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Filter out movies with null or empty values in 'poster_path' or 'backdrop_path'
    final filteredResults = data['results']
        .where((movie) =>
            movie['poster_path'] != null &&
            movie['poster_path'].isNotEmpty &&
            movie['backdrop_path'] != null &&
            movie['backdrop_path'].isNotEmpty)
        .toList();

    return filteredResults; // Return the filtered list of search results
  } else {
    throw Exception('Failed to load search results');
  }
}

Future<List<String>> fetchBackdropImages(int movieId) async {
  final String apiKey = dotenv.env['TMDBKEY'] ?? '';
  final url =
      'https://api.themoviedb.org/3/movie/$movieId/images?api_key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Extract the file paths for backdrops
    List<String> backdrops = (data['backdrops'] as List)
        .map((backdrop) =>
            'https://image.tmdb.org/t/p/w500${backdrop['file_path']}')
        .toList();

    return backdrops;
  } else {
    throw Exception('Failed to load backdrop images');
  }
}

Future<AdvMovie> fetchAdvMovieDetails(int movieId) async {
  final apiKey = dotenv.env['TMDBKEY'] ?? '';

  // Fetch basic movie details
  final detailsUrl =
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey';
  final detailsResponse = await http.get(Uri.parse(detailsUrl));

  if (detailsResponse.statusCode != 200) {
    throw Exception('Failed to load movie details');
  }

  final detailsData = json.decode(detailsResponse.body);

  // Fetch movie credits (cast and crew)
  final creditsUrl =
      'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';
  final creditsResponse = await http.get(Uri.parse(creditsUrl));

  if (creditsResponse.statusCode != 200) {
    throw Exception('Failed to load movie credits');
  }

  final creditsData = json.decode(creditsResponse.body);

  // Parse basic details
  final int id = detailsData['id'];
  final String title = detailsData['title'] ?? 'Unknown Title';
  final String poster =
      'https://image.tmdb.org/t/p/w500${detailsData['poster_path']}';
  final String backDrop =
      'https://image.tmdb.org/t/p/w500${detailsData['backdrop_path']}';
  final String overView = detailsData['overview'] ?? '';
  final String year = (detailsData['release_date'] ?? '').split('-').first;
  final double rating = (detailsData['vote_average'] ?? 0).toDouble();
  final double runTime = (detailsData['runtime'] ?? 0).toDouble();
  final String language = detailsData['original_language'] ?? 'Unknown';

  // Parse genres (categories) into a single comma-separated string
  final String category =
      (detailsData['genres'] as List).map((genre) => genre['name']).join(', ');

  // Parse starring (top 5 cast members)
  final List<String> starring = (creditsData['cast'] as List)
      .take(5)
      .map((member) => member['name'] as String)
      .toList();

  // Parse directors, producers, and writers from the crew data
  final List<String> directors = (creditsData['crew'] as List)
      .where((member) => member['job'] == 'Director')
      .map((member) => member['name'] as String)
      .toList();

  final List<String> producers = (creditsData['crew'] as List)
      .where((member) => member['job'] == 'Producer')
      .map((member) => member['name'] as String)
      .toList();

  final List<String> writers = (creditsData['crew'] as List)
      .where((member) =>
          member['job'] == 'Writer' || member['job'] == 'Screenplay')
      .map((member) => member['name'] as String)
      .toList();

  // Create and return an AdvMovie object with all the gathered information
  return AdvMovie(
    id: id,
    title: title,
    poster: poster,
    backDrop: backDrop,
    overView: overView,
    year: year,
    rating: rating,
    runTime: runTime,
    language: language,
    category: category,
    starring: starring,
    directors: directors,
    producers: producers,
    writers: writers,
  );
}
