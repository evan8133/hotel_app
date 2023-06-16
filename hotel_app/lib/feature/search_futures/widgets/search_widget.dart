import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../core/controller/firestore_methods.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) searchCallback;
  final String searchName;

  const SearchWidget(
      {Key? key, required this.searchCallback, required this.searchName})
      : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  FirestoreMethods firestoreMethods =
      FirestoreMethods(FirebaseFirestore.instance);
  List<DocumentSnapshot> hotels = [];

  @override
  void initState() {
    super.initState();
    fetchHotels();
  }

  void fetchHotels() async {
    List<DocumentSnapshot> hotelList = await firestoreMethods.getAllHotels();
    setState(() {
      hotels = hotelList;
    });
  }

  List<String> getSuggestions(String query) {
    List<String> suggestions = [];
    for (var hotel in hotels) {
      String hotelName = hotel['name'].toString();
      if (hotelName.contains(query)) {
        suggestions.add(hotelName);
      }
    }
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TypeAheadFormField<String>(
        initialValue: widget.searchName,
        textFieldConfiguration: TextFieldConfiguration(
          onSubmitted: (value) {
            widget.searchCallback(value);
          },
          decoration: InputDecoration(
            hintText: 'Search for hotels',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        suggestionsCallback: (pattern) async {
          return getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (suggestion) {
          widget.searchCallback(suggestion);
        },
      ),
    );
  }
}
