import 'package:dio/dio.dart';
import 'package:testmovies/common/toast.dart';
import 'package:testmovies/models/full_movie.dart';
import 'package:testmovies/models/movie.dart';

class ApiRepository {
  Dio _dio = Dio();

  ApiRepository() {
    _dio.options.baseUrl = 'https://desafio-mobile.nyc3.digitaloceanspaces.com';
  }

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(
        '/movies',
      );

      if (response.data == null) return null;

      var retorno = List<Movie>();

      response.data.forEach((e) {
        var item = Movie.fromJson(e);
        retorno.add(item);
      });

      return retorno;
    } catch (e) {
      showError('Application without connection to the server');
      throw e;
    }
  }

  Future<FullMovie> getMovie(int id) async {
    var retorno = FullMovie();

    try {
      Response response = await _dio.get('/movies/${id.toString()}');

      if (response.data == null) {
        return null;
      }

      retorno = FullMovie.fromJson(response.data);
    } catch (e) {
      showError('Application without connection to the server');
      throw e;
    }

    return retorno;
  }
}
