import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      //color: Colors.red,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        // itemBuilder: (_, int index) {
        //   return FadeInImage(
        //     //placeholder: NetworkImage('https://via.placeholder.com/300x400'),
        //     //image: NetworkImage('https://via.placeholder.com/300x400')
        //     placeholder: AssetImage('assets/jar-loading.gif'),
        //     image: AssetImage('assets/no_image.jpeg'),
        //   );
        itemBuilder: (_, int index) {
          //movie.backdropPath;
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: AssetImage('assets/no_image.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
