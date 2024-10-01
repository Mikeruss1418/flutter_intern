// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// void main() {
//   //normal way of creating map
//   var obj = {
//     'name': 'Rojesh',
//     'age': 21,
//   };
//   // print('$obj'); //whole structure of make with braces
//   // print('${obj.values}');

//   //another way
//   var mapObj2 = <String, dynamic>{};
//   mapObj2["name"] = "Dastagir Ahmed";
//   mapObj2["age"] = 34;
//   mapObj2["country"] = "Bangladesh";

//   // print(mapObj2);
//   // print('1st obj name:${mapObj2['name']}');

//   //another way of accessing the keys using forEach method
//   //like this
//   // obj.forEach(
//   //   (key, value) => print('$key: $value'),
//   // );
//   //   print('');
//   // print('');
//   // print('');
//   // //another way is like this
//   // print('using entries');
//   // mapObj2.entries.forEach(
//   //   (element) => print('${element.key}: ${element.value}'),
//   // );
// mapObj2.entries.map((entry) {
//   print(entry);
// }).toList();
//   var index = mapObj2.entries.elementAt(0);
//   print(index);//MapEntry(name: Dastagir Ahmed)
// }

void main() {
  Map<String, Profile> profiles = {
    '1': Profile(name: 'A', address: 'AA'),
    '2': Profile(name: 'B', address: 'BB'),
    '3': Profile(name: 'C', address: 'CC'),
    '4': Profile(name: 'D', address: 'DD'),
  };
  // profiles.forEach(
  //   (key, value) => print(
  //       '$key :Profile("name": ${value.name} , "address": ${value.address})'),
  // );
  var keys = profiles.keys.toList(); //just for keys
  var value = profiles.values.toList(); //just for values in list
  var keymap = profiles.keys;
  var valuemap = profiles.values;
  var entry = profiles.entries
      .map(
        (e) =>
            '${e.key} :Profile(name: ${e.value.name}, address: ${e.value.address} )',
      ) //(A :Profile(name: A, address: AA ), B :Profile(name: B, address: BB ), C :Profile(name: C, address: CC ), D :Profile(name: D, address: DD ))
      .toList(); //[A :Profile(name: A, address: AA ), B :Profile(name: B, address: BB ), C :Profile(name: C, address: CC ), D :Profile(name: D, address: DD )]
  print(entry);
  print(entry.elementAt(0));//1 :Profile(name: A, address: AA )
  print(keys); //[1, 2, 3, 4]
  print(value[1].name); //B
  print(value[0]); //instance of model
  print(keymap.elementAt(0)); //A
  print(keymap); //(1, 2, 3, 4)
  print(
      valuemap); //(Instance of 'Profile', Instance of 'Profile', Instance of 'Profile', Instance of 'Profile')
  print(valuemap.elementAt(0).name); //A
}

class Profile {
  String name;
  String address;
  Profile({
    required this.name,
    required this.address,
  });
  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address};
  }
  //alternatively use foreach here
  // @override
  // String toString() {
  //   return 'Profile(name: $name, address: $address)';
  // }
}
