import 'package:flutter/material.dart';
import 'package:flutter_iconpicker_plus/flutter_iconpicker.dart';
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.address,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: List.generate(
                    widget.star,
                    (_) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Amenities:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.amenities.map((amenity) {
                    IconData iconData =
                        MdiIcons.fromString(amenity) ?? Icons.question_mark;
                    return Chip(
                      label: Icon(iconData),
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  'Nearby Attractions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.nearbyAttractions.map((attraction) {
                   //IconData iconData =
                        //MdiIcons.fromString(attraction) ?? Icons.question_mark;
                    return Chip(
                      label: Text(attraction),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
