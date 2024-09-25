// class CastCrewModel {
//   int? id;
//   List<CastModel>? cast;
//   List<Crew>? crew;

//   CastCrewModel({this.id, this.cast, this.crew});

//   CastCrewModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['cast'] != null) {
//       cast = <CastModel>[];
//       json['cast'].forEach((v) {
//         cast!.add(CastModel.fromJson(v));
//       });
//     }
//     if (json['crew'] != null) {
//       crew = <Crew>[];
//       json['crew'].forEach((v) {
//         crew!.add(Crew.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     if (cast != null) {
//       data['cast'] = cast!.map((v) => v.toJson()).toList();
//     }
//     if (crew != null) {
//       data['crew'] = crew!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CastModel {
//   bool? adult;
//   int? gender;
//   int? id;
//   String? knownForDepartment;
//   String? name;
//   String? originalName;
//   double? popularity;
//   String? profilePath;
//   int? castId;
//   String? character;
//   String? creditId;
//   int? order;

//   CastModel(
//       {this.adult,
//       this.gender,
//       this.id,
//       this.knownForDepartment,
//       this.name,
//       this.originalName,
//       this.popularity,
//       this.profilePath,
//       this.castId,
//       this.character,
//       this.creditId,
//       this.order});

//   CastModel.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     gender = json['gender'];
//     id = json['id'];
//     knownForDepartment = json['known_for_department'];
//     name = json['name'];
//     originalName = json['original_name'];
//     popularity = json['popularity'];
//     profilePath = json['profile_path'];
//     castId = json['cast_id'];
//     character = json['character'];
//     creditId = json['credit_id'];
//     order = json['order'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['adult'] = adult;
//     data['gender'] = gender;
//     data['id'] = id;
//     data['known_for_department'] = knownForDepartment;
//     data['name'] = name;
//     data['original_name'] = originalName;
//     data['popularity'] = popularity;
//     data['profile_path'] = profilePath;
//     data['cast_id'] = castId;
//     data['character'] = character;
//     data['credit_id'] = creditId;
//     data['order'] = order;
//     return data;
//   }
// }

// class Crew {
//   bool? adult;
//   int? gender;
//   int? id;
//   String? knownForDepartment;
//   String? name;
//   String? originalName;
//   double? popularity;
//   String? profilePath;
//   String? creditId;
//   String? department;
//   String? job;

//   Crew(
//       {this.adult,
//       this.gender,
//       this.id,
//       this.knownForDepartment,
//       this.name,
//       this.originalName,
//       this.popularity,
//       this.profilePath,
//       this.creditId,
//       this.department,
//       this.job});

//   Crew.fromJson(Map<String, dynamic> json) {
//     adult = json['adult'];
//     gender = json['gender'];
//     id = json['id'];
//     knownForDepartment = json['known_for_department'];
//     name = json['name'];
//     originalName = json['original_name'];
//     popularity = json['popularity'];
//     profilePath = json['profile_path'];
//     creditId = json['credit_id'];
//     department = json['department'];
//     job = json['job'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['adult'] = adult;
//     data['gender'] = gender;
//     data['id'] = id;
//     data['known_for_department'] = knownForDepartment;
//     data['name'] = name;
//     data['original_name'] = originalName;
//     data['popularity'] = popularity;
//     data['profile_path'] = profilePath;
//     data['credit_id'] = creditId;
//     data['department'] = department;
//     data['job'] = job;
//     return data;
//   }
// }
//above is the latest api usage

import '../../domain/entities/cast_entity.dart';

class CastCrewResultModel {
  int? id;
  List<CastModel>? cast;
  List<Crew>? crew;

  CastCrewResultModel({this.id, this.cast, this.crew});

  CastCrewResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // if (json['cast'] != null) {
    //   final List cast = [];
    //   json['cast'].forEach((v) {
    //     cast.add(CastModel.fromJson(v));
    //   });
    // }
    if (json['cast'] != null) {
      final List<CastModel> castList = []; // Ensure type for list
      json['cast'].forEach((v) {
        CastModel castMember = CastModel.fromJson(v);
        print(
            'Cast ProfilePath: ${castMember.profilePath}'); // Print profilePath
        castList.add(castMember);
      });
      cast = castList; // Assign to class variable
    }
    if (json['crew'] != null) {
      final List crew = [];
      json['crew'].forEach((v) {
        crew.add(Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (cast != null) {
      data['cast'] = cast?.map((v) => v.toJson()).toList();
    }
    if (crew != null) {
      data['crew'] = crew?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CastModel extends CastEntity {
  final int? castId;
  final String character;
  final String creditId;
  final int? gender;
  final int? id;
  final String name;
  final int? order;
  final String? profilePath;

  CastModel({
    this.castId,
    required this.character,
    required this.creditId,
    this.gender,
    this.id,
    required this.name,
    this.order,
    required this.profilePath,
  }) : super(creditId, name, profilePath ?? '', character);

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      gender: json['gender'],
      id: json['id'],
      name: json['name'],
      order: json['order'],
      profilePath: json['profile_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profilePath ?? '';
    return data;
  }
}

class Crew {
  String? creditId;
  String? department;
  int? gender;
  int? id;
  String? job;
  String? name;
  String? profilePath;

  Crew(
      {this.creditId,
      this.department,
      this.gender,
      this.id,
      this.job,
      this.name,
      this.profilePath});

  Crew.fromJson(Map<String, dynamic> json) {
    creditId = json['credit_id'];
    department = json['department'];
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit_id'] = creditId;
    data['department'] = department;
    data['gender'] = gender;
    data['id'] = id;
    data['job'] = job;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}
