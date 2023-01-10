import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/cast.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/model/movie_detail.dart';
import 'package:movies/model/screen_short.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieDetail movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Stack(
                  children: <Widget>[
                    ClipPath(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/original/${movie.backdropPath}",
                          height: MediaQuery.of(context).size.height / 2,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/img_not_found.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              final youtubeUrl = Uri.parse(
                                  'https://www.youtube.com/embed/${movie.trailerId}');
                              if (!await launchUrl(
                                youtubeUrl,
                                mode: LaunchMode.inAppWebView,
                              )) {
                                throw 'Could not launch $youtubeUrl';
                              }
                            },
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  const Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.yellow,
                                    size: 65,
                                  ),
                                  Text(
                                    movie.title.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'muli',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // height: 155,
                          height: (MediaQuery.of(context).size.height / 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Overview".toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 35,
                                child: Text(
                                  movie.overview.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontFamily: 'muli'),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Release date'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'muli'),
                                      ),
                                      Text(
                                        movie.releaseDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: Colors.yellow[800],
                                                fontSize: 12,
                                                fontFamily: 'muli'),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'run time'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'muli',
                                            ),
                                      ),
                                      Text(
                                        movie.runtime.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              color: Colors.yellow[800],
                                              fontSize: 12,
                                              fontFamily: 'muli',
                                            ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'budget'.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'muli',
                                            ),
                                      ),
                                      Text(
                                        movie.budget.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              color: Colors.yellow[800],
                                              fontSize: 12,
                                              fontFamily: 'muli',
                                            ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Screenshots'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli'),
                              ),
                              Container(
                                height: 155,
                                child: ListView.separated(
                                  itemCount: movie.movieImage!.backdrops.length,
                                  separatorBuilder: (__, index) =>
                                      const VerticalDivider(
                                    color: Colors.transparent,
                                    width: 5,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (__, index) {
                                    ScreenShort image =
                                        movie.movieImage!.backdrops[index];
                                    return Container(
                                      child: Card(
                                        elevation: 3,
                                        borderOnForeground: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                            fit: BoxFit.cover,
                                            placeholder: (__, url) => Center(
                                              child: Platform.isAndroid
                                                  ? CircularProgressIndicator()
                                                  : CupertinoActivityIndicator(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Casts'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'muli'),
                              ),
                              Container(
                                height: 115,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: movie.castList!.length,
                                  separatorBuilder: (__, index) =>
                                      const VerticalDivider(
                                    color: Colors.transparent,
                                    width: 5,
                                  ),
                                  itemBuilder: (_, index) {
                                    Cast cast = movie.castList![index];

                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            elevation: 3,
                                            child: ClipRRect(
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                                imageBuilder:
                                                    (__, imageProvider) {
                                                  return Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(100),
                                                      ),
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                placeholder: (__, url) =>
                                                    Container(
                                                  width: 80,
                                                  height: 80,
                                                  child: Platform.isAndroid
                                                      ? const CircularProgressIndicator()
                                                      : const CupertinoActivityIndicator(),
                                                ),
                                                errorWidget:
                                                    (ctx, url, error) =>
                                                        Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(100),
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
                                          Container(
                                            child: Center(
                                              child:
                                                  Text(cast.name.toUpperCase(),
                                                      style: const TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 8,
                                                        fontFamily: 'muli',
                                                      )),
                                            ),
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                  cast.character.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 8,
                                                    fontFamily: 'muli',
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
