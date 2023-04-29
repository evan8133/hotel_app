import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeTest extends StatelessWidget {
  final int id;
  const HomeTest({super.key, @PathParam() required this.id});
  static const String name = '/home-test';

  @override
  Widget build(BuildContext context) {
    return DetailedHotelCard();
  }
}

class DetailedHotelCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
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
            Text(
              'Amenities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Free Wi-Fi'),
            Text('• Complimentary breakfast'),
            Text('• Swimming pool'),
            Text('• Fitness center'),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'This is an example hotel located in the heart of the city. Our hotel offers comfortable rooms, a variety of amenities, and exceptional service. We are dedicated to making your stay enjoyable and memorable.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or action to book a room
              },
              child: Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
