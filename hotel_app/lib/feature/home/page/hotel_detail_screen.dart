
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/controller/firestore_methods.dart';

class HotelDetailScreen extends StatelessWidget {
  final Map<String, dynamic> hotelDatas;
  HotelDetailScreen({required this.hotelDatas});

  @override
  Widget build(BuildContext context) {
    final FirestoreMethods firestoreMethods =
        Provider.of<FirestoreMethods>(context);
    Future<DocumentSnapshot> hotelsFuture =
        firestoreMethods.getHotelById(hotelDatas['hotelId']!);
    Future<List<DocumentSnapshot>> roomsFuture =
        firestoreMethods.getAllRoomsForHotel(hotelDatas['hotelId']);
    return FutureBuilder<DocumentSnapshot>(
      future: hotelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('No data available'),
          );
        }

        final hotelData = snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          appBar: AppBar(
            title: Text(hotelData['name']),
          ),
          body: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: hotelDatas['hotelId'],
                    child: Image.network(
                      hotelDatas['imageUrl'],
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Address',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          hotelData['address'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          hotelData['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RatingBar(
                          itemSize: 25,
                          initialRating: hotelData['star'].toDouble(),
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          onRatingUpdate: (rating) {},
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            half: const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                            empty: const Icon(
                              Icons.star_border,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Amenities',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          children:
                              hotelData['amenities'].map<Widget>((amenity) {
                            return Chip(
                              label: Text(
                                amenity,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nearby Attractions',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          children: hotelData['nearbyAttractions']
                              .map<Widget>((attraction) {
                            return Chip(
                              label: Text(
                                attraction,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.grey[200],
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Contact',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.mail_outline_outlined,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              hotelData['contactEmail'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              hotelData['contactPhone'],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text('Rooms Available'),
                        const SizedBox(height: 8),
                        FutureBuilder(
                          future: roomsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: Text(
                                  'No data available',
                                ),
                              );
                            }

                            final roomsData = snapshot.data as List;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: roomsData.length,
                              itemBuilder: (context, index) {
                                final roomData = roomsData[index].data()
                                    as Map<String, dynamic>;

                                return Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.hotel,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              roomData['roomNumber'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Room Type : ${roomData['roomType']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          'Bed Size : ${roomData['bedSize']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Capacity: ${roomData['capacity']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              '\$${roomData['price']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          children: roomData['amenities']
                                              .map<Widget>((amenity) {
                                            return Chip(
                                              label: Text(
                                                amenity,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
