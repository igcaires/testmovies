import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testmovies/models/full_movie.dart';
import 'package:url_launcher/url_launcher.dart';

class MoviePage extends StatefulWidget {
  final FullMovie movie;

  MoviePage(this.movie);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.movie.title}'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: _floatingButtonImdb(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Center(
                child: CachedNetworkImage(
                  height: 300,
                  imageUrl: widget.movie.posterUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    size: 200,
                  ),
                ),
              ),
              _buildOverview(),
              _buildGenres(),
              _buildProductionCompanies(),
            ],
          ),
        ),
      ),
    );
  }

  _buildOverview() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Overview',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      children: <Widget>[
        Text(
          widget.movie.overview,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  _buildGenres() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Genres',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      children: <Widget>[
        Text(
          widget.movie.genres.join(', '),
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  _buildProductionCompanies() {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        'Production Companies',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      children: <Widget>[
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 10,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: (widget.movie.productionCompanies != null)
                ? widget.movie.productionCompanies.length
                : 0,
            itemBuilder: (context, i) {
              ProductionCompanies prodCompanie =
                  widget.movie.productionCompanies[i];

              return _buildProductionCompanie(prodCompanie);
            },
          ),
        ),
      ],
    );
  }

  _buildProductionCompanie(ProductionCompanies companie) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 80,
            child: CachedNetworkImage(
              imageUrl: (companie.logoUrl ?? ''),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
              ),
            ),
          ),
          Text(companie.name)
        ],
      ),
    );
  }

  FloatingActionButton _floatingButtonImdb() {
    return FloatingActionButton(
      heroTag: 'btnImdb',
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 30,
          ),
          Text(
            '${widget.movie.voteAverage.toString()}/10',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () async {
        if ((widget.movie.imdbId ?? '').isEmpty) return;

        String url =
            'https://www.imdb.com/title/${widget.movie.imdbId}';

        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }
}
