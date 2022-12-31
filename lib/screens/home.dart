// https://www.youtube.com/watch?v=ZPdG0mCtTYg
import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/movie_screen.dart';
import 'package:movies/widgets/movie_list_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieProvider>().getPopular());
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = context.watch<MovieProvider>().movies;
    bool isLoading = context.watch<MovieProvider>().isLoading;
    dynamic response = context.watch<MovieProvider>().response;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Center(
              child: Text(
                "Explore",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 150,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    TextSpan(
                        text: "Featured ",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "Movies")
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Text(isLoading.toString()),
              // Text(movies.toString()),
              // Text(response.toString()),
              // Loading
              if (isLoading)
                for (int i = 0; i < 5; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          // width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),

              for (final movie in movies)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieScreen(movie: movie),
                      ),
                    );
                  },
                  child: MovieListItem(
                    posterPath: movie.posterPath,
                    title: movie.title,
                    overview: movie.releaseDate,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // throw UnimplementedError();
    return true;
  }
}
