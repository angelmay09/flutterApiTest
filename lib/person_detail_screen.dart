import 'package:flutter/material.dart';

class PersonDetailScreen extends StatelessWidget {
  final dynamic person;
  PersonDetailScreen(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body:Center(child: Column(
          children: [
            Image.network(person['image'], width: 150, height: 150, errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person, size: 120);
            },
            ),
            Text("${person['firstname']} ${person['lastname']}", style: TextStyle(fontSize: 30)),
            Text(person['email'], style: TextStyle(fontSize: 24)),
            Text(person['website'], style: TextStyle(fontSize: 24)),
          ],
        )
          ,),
      );
  }
}
