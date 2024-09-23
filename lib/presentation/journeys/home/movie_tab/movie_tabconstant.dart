import 'package:movie_app/common/constants/translation.dart';
import 'package:movie_app/presentation/journeys/home/movie_tab/tab.dart';

class MovieTabconstant {
  static List<Tab> movietab = [
    Tab(index: 0, title: Translation.popular),
    Tab(index: 1, title: Translation.now),
    Tab(index: 2, title: Translation.soon),
  ];
}
