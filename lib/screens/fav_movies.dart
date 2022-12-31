import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class FavoriteMovies extends StatefulWidget {
  const FavoriteMovies({super.key});

  @override
  State<FavoriteMovies> createState() => _FavoriteMoviesState();
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  @override
  Widget build(BuildContext context) {
    List<Movie> myList = context.watch<MovieProvider>().favoriteList;
    return Scaffold(
      appBar: AppBar(
        title: Text("My list (${myList.length})"),
      ),
      body: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (_, index) {
            final currMovie = myList[index];

            return Card(
              key: ValueKey(currMovie.title),
              elevation: 4,
              child: ListTile(
                title: Text(currMovie.title),
                subtitle: Text(currMovie.voteCount.toString()),
                trailing: TextButton(
                  child: const Text(
                    "Remove",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context.read<MovieProvider>().removeFromList(currMovie);
                  },
                ),
              ),
            );
          }),
    );
  }
}
