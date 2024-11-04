import 'package:flutter/material.dart';
import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/tiles/movie_tile.dart';
//import 'package:movie_hub/tiles/movie_tile_in_search.dart'; // Import your MovieTileInSearch widget

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List movies = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        fetchSearchResults(_searchController.text);
      } else {
        setState(() {
          movies = [];
        });
      }
    });
  }

  Future<void> fetchSearchResults(String query) async {
    try {
      final results = await searchMovies(query);
      setState(() {
        movies = results;
      });
    } catch (e) {
      print('Error fetching search results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? const Center(child: Text('Enter a movie name to search'))
                : movies.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        scrollDirection:
                            Axis.horizontal, // Set to horizontal scrolling
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 rows
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                          childAspectRatio:
                              220 / 150, // Match card aspect ratio
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movieData = movies[index];
                          final movie = Movie(
                            movieData['id'].toString(),
                            movieData['title'] ?? 'No Title',
                            'https://image.tmdb.org/t/p/w500${movieData['poster_path']}',
                            'https://image.tmdb.org/t/p/w500${movieData['backdrop_path']}',
                          );
                          return MovieTileInSearch(
                            movie: movie,
                            tag: movieData['id']
                                .toString(), // Use the movie ID as the tag
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
