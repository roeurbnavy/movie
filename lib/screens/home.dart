// https://www.youtube.com/watch?v=ZPdG0mCtTYg

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/screens/movie_detail.dart';
import 'package:movies/model/person.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/category.dart';
import 'package:movies/widgets/show_loading.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MovieProvider>().getNowPlayingMovie());
    Future.microtask(() => context.read<MovieProvider>().getTrendingPerson());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black45,
        ),
        title: Text(
          'Movies-db'.toUpperCase(),
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Colors.black45,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'muli',
              ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
            ),
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<MovieProvider>(
                  builder: (_, state, __) {
                    bool isLoading = state.isLoading;
                    List<Movie> movies = state.nowPlayingMovies;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading
                            ? CarouselSlider.builder(
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  return Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  pauseAutoPlayOnTouch: true,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                ),
                              )
                            : CarouselSlider.builder(
                                itemCount: movies.length,
                                itemBuilder: (BuildContext context, int index,
                                    int pageViewIndex) {
                                  Movie movie = movies[index];

                                  return GestureDetector(
                                    onTap: () {
                                      // loading
                                      showLoadingDialog(context);
                                      context
                                          .read<MovieProvider>()
                                          .getMovieDetail(movie.id)
                                          .then(
                                        (value) {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  MovieDetailScreen(
                                                      movie: value!),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/original${movie.backdropPath}',
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder:
                                                (ctx, url, progress) =>
                                                    Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/img_not_found.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 15,
                                            left: 15,
                                          ),
                                          child: Text(
                                            movie.title.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'muli',
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 5,
                                                  offset: Offset(1, 1),
                                                ),
                                              ],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  pauseAutoPlayOnTouch: true,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 12,
                              ),
                              const BuildCategory(),
                              Text(
                                "Trending person on this week".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                  fontFamily: 'muli',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  Selector<MovieProvider,
                                      Tuple2<List<Person>, bool>>(
                                    selector: (_, provider) => Tuple2(
                                        provider.trendingPerson,
                                        provider.isLoading),
                                    builder: (_, state, __) {
                                      if (state.item2) {
                                        return SizedBox(
                                          height: 80,
                                          // width: 80,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: ListView.separated(
                                              itemCount: 10,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder: (_, index) =>
                                                  const VerticalDivider(
                                                width: 5,
                                                color: Colors.transparent,
                                              ),
                                              itemBuilder: (_, index) {
                                                return Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      } else {
                                        List<Person> trendingPersons =
                                            state.item1;

                                        return SizedBox(
                                          height: 110,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: trendingPersons.length,
                                            separatorBuilder: (ctx, index) =>
                                                const VerticalDivider(
                                              color: Colors.transparent,
                                              width: 5,
                                            ),
                                            itemBuilder: (ctx, index) {
                                              Person person =
                                                  trendingPersons[index];
                                              return Column(
                                                children: <Widget>[
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    elevation: 3,
                                                    child: ClipRRect(
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            'https://image.tmdb.org/t/p/w200${person.profilePath ?? '/zzWGRw277MNoCs3zhyG3YmYQsXv.jpg'}',
                                                        imageBuilder: (context,
                                                            imageProvider) {
                                                          return Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          );
                                                        },
                                                        fit: BoxFit.cover,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    progress) =>
                                                                Shimmer
                                                                    .fromColors(
                                                          baseColor: Colors
                                                              .grey.shade300,
                                                          highlightColor: Colors
                                                              .grey.shade100,
                                                          child: Container(
                                                            height: 80,
                                                            width: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/img_not_found.jpg'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        person.name
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.black45,
                                                          fontFamily: 'muli',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Text(
                                                        person
                                                            .knownForDepartment
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          color: Colors.black45,
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
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
