import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String title,type,key;

  const VideoEntity(this.title, this.type, this.key);

  @override
  List<Object> get props => [title];

  @override
  bool get stringify => true;
}
