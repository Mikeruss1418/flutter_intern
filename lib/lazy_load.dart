

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LazyLoadingList extends StatefulWidget {
  const LazyLoadingList({super.key});

  @override
  _LazyLoadingListState createState() => _LazyLoadingListState();
}

class _LazyLoadingListState extends State<LazyLoadingList> {
  final _scrollController = ScrollController();

  // Dummy list of items
  List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadMoreItems);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to simulate loading more items
  Future<void> _loadMoreItems() async {
    // Trigger loading more items when reaching the end of the list
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Simulating a delay of 1 second
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        items.addAll(List.generate(20, (index) => 'Item ${items.length + index}'));
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Flutter Foundation - Lazy Loading Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + 1, // Adding 1 for loading indicator
        itemBuilder: (context, index) {
          if (index == items.length) {
            // If reached the end of the list, show a loading indicator
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // Displaying the actual item
            return ListTile(
              title: Text(items[index]),
            );
          }
        },
      ),
    );
  }
}
