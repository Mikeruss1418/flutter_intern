import 'package:flutter/material.dart';

class NavigationListitem extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const NavigationListitem(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            )
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}


