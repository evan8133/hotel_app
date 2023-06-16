import 'package:flutter/material.dart';

import '../widgets/map_view.dart';
import '../widgets/search_result.dart';
import '../widgets/search_widget.dart';
import '../widgets/suggestion.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchName = '';
  String imageUrl = '';
  void updateSearchName(String newName) {
    setState(() {
      searchName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchWidget(
              searchCallback: updateSearchName,
              searchName: searchName,
            ),
            SearchResultsSuggestions(
              searchName: searchName,
            ),
            const SuggestionsWidget(),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const MapViewHotels(),
          ],
        ),
      ),
    );
  }
}
