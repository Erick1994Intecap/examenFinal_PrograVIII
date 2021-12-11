import 'package:card_swiper/card_swiper.dart';
import 'package:cartelera/models/models.dart';
import 'package:cartelera/models/production_companies.dart';
import 'package:cartelera/providers/movies_provider.dart';
import 'package:flutter/material.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  static const routeName = '/companies';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Companies;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            poster: args.logoPath,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(id: args.id),
            _Overview(
              id: args.id,
            ),
            _HeaderCard(title: 'Logotipos'),
            CardSwiper(
              codigo: args.id,
            )
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String poster;
  const _CustomAppBar({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace:
          FlexibleSpaceBar(centerTitle: true, background: _fImage(poster)),
    );
  }

  FadeInImage _fImage(String image) {
    if (image.isEmpty) {
      return FadeInImage(
        placeholder: AssetImage('assets/no_image.jpeg'),
        image: AssetImage('assets/loading.gif'),
        fit: BoxFit.cover,
        width: 130,
        height: 190,
      );
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/no_image.jpeg'),
        image: NetworkImage("https://www.themoviedb.org/t/p/original" + image),
        width: 130,
        height: 190,
        fit: BoxFit.contain,
      );
    }
  }
}

class _PosterAndTitle extends StatelessWidget {
  final int id;
  const _PosterAndTitle({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TEMA
    final TextTheme textTheme = Theme.of(context).textTheme;
    //MEDIA QUERY
    final size = MediaQuery.of(context).size;
    late Future<Companies> np;
    np = MoviesProvider().getCompany(this.id);
    return _getCompany(context, np);
  }

  Widget _getCompany(BuildContext context, Future<Companies> np) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder<Companies>(
          future: np,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: size.width - 190),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.name,
                              style: textTheme.headline5,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Text(
                              'Pais: ' + snapshot.data!.headquarters,
                              style: textTheme.subtitle1,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Text('No hay datos');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class _Overview extends StatelessWidget {
  final int id;
  const _Overview({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Future<Companies> np;
    np = MoviesProvider().getCompany(id);
    return _getDesc(context, np);
  }

  Widget _getDesc(BuildContext context, Future<Companies> np) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: FutureBuilder<Companies>(
          future: np,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _overview(context, snapshot.data!.description));
            } else if (snapshot.hasError) {
              return Text('No hay datos');
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Widget _overview(BuildContext context, String text) {
    if (text == '') {
      return (Text(
        text,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ));
    } else {
      return (Text(
        'UPS!! Parece que no hay informacion a mostrar',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ));
    }
  }
}

class CardSwiper extends StatelessWidget {
  final int codigo;
  const CardSwiper({Key? key, required this.codigo}) : super(key: key);

//   @override
//   _CardSwiperState createState() => _CardSwiperState(codigo);
// }

// class _CardSwiperState extends State<CardSwiper> {
//   final int id;
//   _CardSwiperState( required this.id);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late Future<CompanyImageResponse> np;
    np = MoviesProvider().getLogo(codigo);

    return getLogo(context, np);
  }

  Widget getLogo(BuildContext context, Future<CompanyImageResponse> np) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: FutureBuilder<CompanyImageResponse>(
          future: np,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Swiper(
                itemCount: snapshot.data!.logos.length,
                layout: SwiperLayout.STACK,
                itemWidth: size.width * 0.6,
                itemHeight: size.height * 0.4,
                itemBuilder: (_, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage("https://image.tmdb.org/t/p/w200" +
                          snapshot.data!.logos[index].filePath),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('No hay datos');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;

  const _HeaderCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
