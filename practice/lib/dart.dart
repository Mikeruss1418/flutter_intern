import 'dart:convert';
class Person {
  String? user;
  int? age;
  
  Person({required this.user, required this.age});
  
  factory Person.fromJson(Map<String,dynamic > map) {
    return Person(
    user: map['name'],
      age:map['old'],
    );
  }
}
class User {
  String? user;
  int? age;
  
  User({required this.user, required this.age});
  factory User.fromJson(Map<String,dynamic> map) {
    return User(
    user:map['name'],
      age:map['olds'],
    );
  }
}
void main () {
  String jsonString='{"name":"rojesh","olds":25}';
  print(jsonString);
  /*{
    "name":"rojesh",
    "olds":25
  }*/
  Map<String,dynamic> personmap= jsonDecode(jsonString);
  print(personmap);
  /*
  {
    name:rojesh,
    olds:25
  }
  */ 
  Person per =Person.fromJson(personmap);
  print('${per.user} ${per.age}');//rojesh null
  
  User use = User.fromJson(personmap);
  print('${use.user} ${use.age}');//rojesh 25
;  
}