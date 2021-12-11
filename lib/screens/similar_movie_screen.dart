import 'package:cartelera/models/models.dart';
import 'package:cartelera/models/top_rated_response.dart' show TopRatedResponse;
import 'package:cartelera/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimilarMovieScreen extends StatelessWidget {
  const SimilarMovieScreen({Key? key}) : super(key: key);
//   @override
//   _HomeSwippedState createState() => _HomeSwippedState();
// }

//class _HomeSwippedState extends State<HomeSwippedScreen> {

  static const routeName = '/similar';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Movie;
    late Future<SimilarMoviesResponse> np;
    np = MoviesProvider().getSimilarMovie(args.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas Similares'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([getInfo(context, np)]))
        ],
      ),
    );
  }

  Widget getInfo(BuildContext context, Future<SimilarMoviesResponse> np) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    //MEDIA QUERY
    final size = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder<SimilarMoviesResponse>(
        future: np,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.results.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Card(
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                            margin: EdgeInsets.only(top: 2),
                            padding: EdgeInsets.only(bottom: 2),
                            child: Row(
                              children: [
                                Hero(
                                  tag: snapshot.data!.results[index].id,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage(
                                      placeholder:
                                          AssetImage('assets/no_image.jpeg'),
                                      image: NetworkImage(
                                          "https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
                                              snapshot.data!.results[index]
                                                  .posterPath),
                                      height: 150,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: size.width - 190),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.results[index].title,
                                        style: textTheme.headline5,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        snapshot
                                            .data!.results[index].originalTitle,
                                        style: textTheme.subtitle1,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star_outline,
                                            size: 15,
                                            color: Colors.cyan,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                              snapshot.data!.results[index]
                                                  .voteAverage
                                                  .toStringAsPrecision(2),
                                              style: textTheme.caption),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          TextButton(
                                            child: const Text('Detalles'),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, 'details',
                                                  arguments: Movie(
                                                      adult: snapshot.data!
                                                          .results[index].adult,
                                                      backdropPath: snapshot
                                                          .data!
                                                          .results[index]
                                                          .backdropPath,
                                                      id: snapshot.data!
                                                          .results[index].id,
                                                      originalTitle: snapshot
                                                          .data!
                                                          .results[index]
                                                          .originalTitle,
                                                      overview: snapshot
                                                          .data!
                                                          .results[index]
                                                          .overview,
                                                      popularity: snapshot
                                                          .data!
                                                          .results[index]
                                                          .popularity,
                                                      posterPath: snapshot
                                                          .data!
                                                          .results[index]
                                                          .posterPath,
                                                      releaseDate: snapshot
                                                          .data!
                                                          .results[index]
                                                          .releaseDate,
                                                      title: snapshot.data!
                                                          .results[index].title,
                                                      video: snapshot.data!
                                                          .results[index].video,
                                                      voteAverage: snapshot
                                                          .data!
                                                          .results[index]
                                                          .voteAverage,
                                                      voteCount: snapshot
                                                          .data!
                                                          .results[index]
                                                          .voteCount));
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('No hay datos');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
