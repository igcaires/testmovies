import 'package:flutter/material.dart';
import 'package:testmovies/common/shared_pref.dart';
import 'package:testmovies/models/movie.dart';
import 'package:testmovies/repository/api_repository.dart';
import 'package:testmovies/screens/home/movie_tile_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> _movies = [];
  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();

    _getMovies();
  }

  Future<void> _getMovies() async {
    try {
      List<Movie> response = await ApiRepository().getMovies();

      if (response != null) {
        sharedPref.remove('movies');
        sharedPref.save('movies', response);

        setState(() {
          this._movies = response;
        });
      }
    } catch (e) {
      var movies = await sharedPref.read('movies');

      if (movies != null) {
        List<Movie> movieList = [];

        movies.forEach((e) => movieList.add(Movie.fromJson(e)));

        setState(() {
          this._movies = movieList;
        });
      }

      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Expanded(
            child: ListView.builder(
              itemCount: (_movies != null) ? _movies.length : 0,
              itemBuilder: (context, i) {
                Movie movie = _movies[i];

                return MovieTile(movie);
              },
            ),
          ),
        ),
      ),
    );
  }
}
