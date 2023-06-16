import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/feature/search_futures/widgets/hotel_card.dart';

import '../../../core/controller/firestore_methods.dart';

class SearchResultsSuggestions extends StatelessWidget {
  final String searchName;

  const SearchResultsSuggestions({
    Key? key,
    required this.searchName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  FirestoreMethods firestoreMethods = FirestoreMethods(FirebaseFirestore.instance);

    return FutureBuilder<List<DocumentSnapshot>>(
      future: firestoreMethods.getHotelsByName(searchName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final hotels = snapshot.data!;
          if (hotels.isEmpty) {
            return Center(child: Text('No results found'));
          } else if (hotels.length == 1) {
            return HotelCard(hotel: hotels.first);
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: min(hotels.length, 4,),
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return HotelCard(hotel: hotel);
              },
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}



