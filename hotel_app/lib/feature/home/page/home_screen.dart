import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/router/router.gr.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  static const String name = '/home';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://media.istockphoto.com/id/104731717/photo/luxury-resort.jpg?s=612x612&w=0&k=20&c=cODMSPbYyrn1FHake1xYz9M8r15iOfGz9Aosy9Db7mI=',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hotel Example',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '123 Main Street, City, Country',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Price: \$100/night',
              style: TextStyle(fontSize: 18, color: Colors.blue[900]),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.pushRoute(HomeTest(id: 1));
              },
              child: Text('See More'),
            ),
          ],
        ),
      ),
    ));
  }
}
