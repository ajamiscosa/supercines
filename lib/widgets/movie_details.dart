import 'package:flutter/material.dart';
import 'package:supercines/framework/framework.dart';
import 'package:supercines/models/actores_model.dart';
import 'package:supercines/models/genre_model.dart';
import 'package:supercines/models/movie_model.dart';
import 'package:supercines/screens/tickets_screen.dart';
import 'package:supercines/widgets/trailer_button.dart';
import 'package:supercines/utils/utils.dart' as utils;

class MovieDetails extends StatefulWidget {
  const MovieDetails({
    Key key,
    @required this.genres,
    @required this.actors,
    @required this.movie,
  }) : super(key: key);

  final List<Genre> genres;
  final List<Actor> actors;
  final Movie movie;

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildActions(),
          SizedBox(height: 5.0),
          _buildMovieTitle(context),
          SizedBox(height: 10.0),
          _buildMovieDetails(),
          SizedBox(height: 15.0),
          _buildBuyTicketsButton(context),
          SizedBox(height: 28.0),
          _buildMovieCast(),
        ],
      ),
    );
  }

  Widget _buildMovieCast() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          utils.getActors(widget.actors),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildBuyTicketsButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.062,
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: yellow,
        child: Text(
          'BUY TICKETS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () => _pushMovieDetail(context),
        // onPressed: () => Navigator.of(context)
        //     .pushNamed('/tickets', arguments: widget.movie),
      ),
    );
  }

  _pushMovieDetail(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: TicketsScreen(
              movie: widget.movie,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 800),
      ),
    );
  }

  Widget _buildMovieDetails() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.movie.getYear(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            Text(
              '   ⬤   ',
              style: TextStyle(
                color: yellow,
                fontSize: 6,
              ),
            ),
            Flexible(
              child: Text(
                utils.getGenresFromId(widget.movie.genreIds, widget.genres),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieTitle(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(milliseconds: 500),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.07389,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          widget.movie.title.toUpperCase(),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Row _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TrailerButton(),
        Text(
          'ABOUT MOVIE',
          style: TextStyle(color: yellow, fontSize: 12),
        )
      ],
    );
  }
}
