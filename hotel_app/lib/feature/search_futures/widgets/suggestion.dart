import 'package:auto_route/auto_route.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/core/controller/firestore_methods.dart';
import 'package:hotel_app/core/router/router.gr.dart';
import 'package:provider/provider.dart';

class SuggestionsWidget extends StatelessWidget {
  const SuggestionsWidget({Key? key}) : super(key: key);
  Future<String> getImageUrl(Reference imageRef) async {
    final String downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    FirestoreMethods firestoreMethods =
        Provider.of<FirestoreMethods>(context, listen: false);
    FirebaseStorage storage = FirebaseStorage.instance;
    return FutureBuilder<List<DocumentSnapshot>>(
      future: firestoreMethods.getAllHotels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final hotels = snapshot.data!;
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length < 10 ? hotels.length : 10,
              itemBuilder: (context, index) {
                final hotel = hotels[index % hotels.length];
                final String imagePath =
                    'gs://hotel-booking-5e032.appspot.com/hotels/${hotels[index].id}/main.jpg';
                final Reference imageRef = storage.refFromURL(imagePath);

                return FutureBuilder<List<DocumentSnapshot>>(
                  future: firestoreMethods.getAllRoomsForHotel(hotel.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final rooms = snapshot.data!;
                      final randomRooms = rooms..shuffle();
                      final displayedRooms = randomRooms.take(10).toList();
                      return FutureBuilder(
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
                            return GestureDetector(
                              onTap: () {
                                context.router.push(
                                  HotelDetailRoute(
                                    hotelDatas: {
                                      'hotelId': hotel.id,
                                      'imageUrl': snapshot.data,
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                width: 150,
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      snapshot
                                          .data!, // Assuming snapshot.data contains the image URL
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.black.withOpacity(
                                                0.5), // Adjust the opacity as needed
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context.router.push(
                                          HotelDetailRoute(
                                            hotelDatas: {
                                              'hotelId': hotel.id,
                                              'imageUrl': snapshot.data,
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              snapshot
                                                  .data!, // Assuming snapshot.data contains the image URL
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Colors.black.withOpacity(
                                                        0.7), // Adjust the opacity as needed
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 125,
                                              right: 75,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,

                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Text(
                                                  '${(hotel.data() as Map<String, dynamic>).containsKey('name') ? (hotel.data() as Map<String, dynamic>)['name'] : 'ERROR'}\n${displayedRooms.length}'
                                                      .toString(), // Show the number of rooms
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Placeholder();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
