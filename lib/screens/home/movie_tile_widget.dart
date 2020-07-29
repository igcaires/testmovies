import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testmovies/models/full_movie.dart';

import 'package:testmovies/models/movie.dart';
import 'package:testmovies/repository/api_repository.dart';
import 'package:testmovies/screens/movie/movie_page.dart';

class MovieTile extends StatefulWidget {
  final Movie movie;

  MovieTile(this.movie);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: Card(
          color: Colors.grey[100],
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: SizedBox(
              child: CachedNetworkImage(
                imageUrl: widget.movie.posterUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(
              widget.movie.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              widget.movie.releaseDate,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
            trailing: Text(
              widget.movie.voteAverage.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            isThreeLine: true,
          ),
        ),
        onTap: () async {
          FullMovie fullMovie = await ApiRepository().getMovie(widget.movie.id);

          if (fullMovie == null) return;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoviePage(fullMovie)),
          );
        },
      ),
    );
  }
}
