import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/model/genre.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BuildCategory extends StatefulWidget {
  final int selectedGenre;

  const BuildCategory({Key? key, this.selectedGenre = 28}) : super(key: key);

  @override
  State<BuildCategory> createState() => _BuildCategoryState();
}

class _BuildCategoryState extends State<BuildCategory> {
  late int selectedGenre;
  late Future<List<Genre>> fetchGenres;

  @override
  void initState() {
    super.initState();

    selectedGenre = widget.selectedGenre;

    Future.microtask(
        () => context.read<MovieProvider>().getMovieByGenre(selectedGenre));
    fetchGenres = context.read<MovieProvider>().getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder(
          future: fetchGenres,
          // context.read<MovieProvider>().getGenreList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Genre> genres = snapshot.data;
              return SizedBox(
                height: 45,
                child: ListView.separated(
                  itemCount: genres.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  itemBuilder: (context, index) {
                    Genre genre = genres[index];

                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGenre = genre.id;
                              context
                                  .read<MovieProvider>()
                                  .getMovieByGenre(selectedGenre);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: genre.id == selectedGenre
                                  ? Colors.black45
                                  : Colors.white,
                            ),
                            child: Text(
                              genre.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: genre.id == selectedGenre
                                    ? Colors.white
                                    : Colors.black45,
                                fontFamily: 'muli',
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else {
              // Loading
              return SizedBox(
                height: 45,
                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 45,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            'new playing'.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
              fontFamily: 'muli',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<MovieProvider>(
          builder: (_, state, ___) {
            if (state.isLoading) {
              return SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 250,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 10,
                                width: 190,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 10,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            } else {
              List<Movie> movies = state.movies;

              return SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (ctx, index) => const VerticalDivider(
                    color: Colors.transparent,
                    width: 15,
                  ),
                  itemBuilder: (ctx, index) {
                    Movie movie = movies[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            context
                                .read<MovieProvider>()
                                .getMovieDetail(movie.id)
                                .then(
                                  (value) => Navigator.push(
                                    _,
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          MovieDetailScreen(movie: value!),
                                    ),
                                  ),
                                );
                          },
                          child: ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                              imageBuilder: (ctx, imageProvider) {
                                return Container(
                                  width: 190,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              progressIndicatorBuilder:
                                  (context, url, progress) => Container(
                                width: 190,
                                height: 250,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                              ),
                              errorWidget: (ctx, url, error) => Container(
                                width: 190,
                                height: 250,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/img_not_found.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 190,
                          child: Text(
                            movie.title.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'muli'),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              RatingBar.builder(
                                initialRating: movie.voteAverage / 2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemSize: 14,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (ctx, index) {
                                  return const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                                onRatingUpdate: (rating) {},
                              ),
                              Text(
                                movie.voteAverage.toString(),
                                style: const TextStyle(color: Colors.black45),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}
