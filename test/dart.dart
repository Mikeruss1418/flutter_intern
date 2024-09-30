// import 'package:dartz/dartz.dart';

// void main() {
//   Option<int> someValue = some(10);
//   Option<int> noneValue = none();

//   someValue.fold(
//     () => print('No value'),
//     (value) => print('Value is $value'),
//   );

//   noneValue.fold(
//     () => print('No value'),
//     (value) => print('Value is $value'),
//   );
// }

import 'package:flutter/material.dart';

class DraggableScrollableSheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Scrollable Sheet Example'),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(
              'Background Content',
              style: TextStyle(fontSize: 24),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.2, // Start at 20% of the screen height
            minChildSize: 0.2,     // Minimum size is 20% of the screen height
            maxChildSize: 0.8,     // Maximum size is 80% of the screen height
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 30, // Example: a list with 30 items
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.list),
                      title: Text('Item $index'),
                      subtitle: Text('This is the detail for item $index'),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
