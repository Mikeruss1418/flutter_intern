import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final String creditId;
  final String name;
  final String posterpath;
  final String character;

  const CastEntity(this.creditId, this.name, this.posterpath, this.character);
  
  @override
  List<Object> get props => [creditId];
}
