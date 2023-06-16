import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/feature/home/widgets/hotels.dart';
import 'package:provider/provider.dart';

import '../../../core/controller/firestore_methods.dart';
import '../../../core/router/router.gr.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<String> getImageUrl(Reference imageRef) async {
    final String downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreMethods firestoreMethods =
        Provider.of<FirestoreMethods>(context);
    Future<List<DocumentSnapshot>> hotelsFuture =
        firestoreMethods.getAllHotels();

    final FirebaseStorage storage = FirebaseStorage.instance;
    return FutureBuilder<List<DocumentSnapshot>>(
      future: hotelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to load, display a progress indicator
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while loading the data, display an error message
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // If the data is available, use it to build your UI
          List<DocumentSnapshot> hotels = snapshot.data!;
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index].data();
                final Map<String, dynamic> hotelData =
                    hotel as Map<String, dynamic>;
                final String imagePath =
                    'gs://hotel-booking-5e032.appspot.com/hotels/${hotels[index].id}/main.jpg';
                final Reference imageRef = storage.refFromURL(imagePath);
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FutureBuilder<String>(
                          future: getImageUrl(imageRef),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // While waiting for the image to load, display a progress indicator
                              return const SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              // If an error occurred while loading the image, display an error message
                              return const Text('Error loading image');
                            } else if (snapshot.hasData) {
                              // If the image URL is available, display the image using Image.network
                              final imageUrl = snapshot.data!;
                              return GestureDetector(
                                onTap: () {
                                  context.router.push(
                                    HotelDetailRoute(
                                      hotelDatas: {
                                        'imageUrl': imageUrl,
                                        'hotelId': hotels[index].id,
                                      } 
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: hotels[index].id,
                                  child: HotelCard(
                                    url: imageUrl,
                                    name: hotelData['name'],
                                    address: hotelData['address'],
                                    description: hotelData['description'],
                                    star: hotelData['star'],
                                    amenities:
                                        List<String>.from(hotelData['amenities']),
                                    nearbyAttractions: List<String>.from(
                                        hotelData['nearbyAttractions']),
                                  ),
                                ),
                              );
                            } else {
                              // If none of the above conditions are met, display a placeholder
                              return const Placeholder();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          // If none of the above conditions are met, display a placeholder
          return const Placeholder();
        }
      },
    );
  }
}
