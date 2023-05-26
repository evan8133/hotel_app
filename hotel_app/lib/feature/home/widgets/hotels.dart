import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HotelCard extends StatefulWidget {
  final String url;
  final String name;
  final String address;
  final String description;
  final int star;
  final List<String> amenities;
  final List<String> nearbyAttractions;

  const HotelCard({
    required this.url,
    required this.name,
    required this.address,
    required this.description,
    required this.star,
    required this.amenities,
    required this.nearbyAttractions,
  });

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tab');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                widget.url, // Replace with the actual image URL
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.address,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RatingBar(
                    initialRating: widget.star.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 10),
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
                    widget.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Amenities:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.amenities.map((amenity) {
                      IconData iconData =
                          MdiIcons.fromString(amenity) ?? Icons.question_mark;
                      return Chip(
                        label: Icon(iconData),
                        backgroundColor: Colors.blue,
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nearby Attractions:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.nearbyAttractions.map((attraction) {
                      //IconData iconData =
                      //MdiIcons.fromString(attraction) ?? Icons.question_mark;
                      return Chip(
                        label: Text(attraction),
                        backgroundColor: Colors.green,
                        labelStyle: const TextStyle(color: Colors.white),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
