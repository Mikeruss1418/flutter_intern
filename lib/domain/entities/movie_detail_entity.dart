import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final String posterpath;
  final int id;
  final String backdropath;
  final String title;
  final num voteAverage;
  final String releasedate;
  final String? overview;

  const MovieDetailEntity(this.posterpath, this.id, this.backdropath, this.title, this.voteAverage, this.releasedate, this.overview,);

 
  @override
  List<Object?> get props => [id];

}
