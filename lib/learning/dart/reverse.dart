// void main() {
//   Map<String, int> original = {'a': 1, 'b': 2, 'c': 3};
//   Map<int, String> reverse = <int, String>{};

//   original.forEach(
//     (key, value) => reverse[value] = key,
//   );
//   print(reverse);
// }

class User {
  String name;
  String category;

  User(this.name, this.category);
}

void main() {
   var userList = [User('John', 'Admin'), User('Jane', 'User'), User('Nolas','Admin')];
   var userMap = {};
   for (var user in userList) {
     (userMap[user.category] = userMap[user.category] ?? []).add(user.name);
   }
     print(userMap);
}

// void main() {
//   var map = {'Name': 'John', 'Age': 23};
//   map.entries.forEach((entry) =>
//       print('Using forEach Key: ${entry.key}, Value: ${entry.value}'));
//   var emap = map.entries.map(
//     (e) => '${e.key} : ${e.value}',
//   );

//   print(emap);
// }
