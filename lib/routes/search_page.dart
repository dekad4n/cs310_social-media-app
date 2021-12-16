import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class SearchPage2 extends StatefulWidget {
  const SearchPage2({Key? key}) : super(key: key);
  @override
  _SearchPageState2 createState() => _SearchPageState2();
}
class _SearchPageState2 extends State<SearchPage2> {

  late String SearchTerm;
  final controller = FloatingSearchBarController();// conrtoller is to control Search Bar

  @override
  void initState() { // bu dingil ne demek
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait; // bu dingil ne demek
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          FloatingSearchBar(
            controller: controller,
            body: FloatingSearchBarScrollNotifier( // is to list the result of a search
              child: Text(
                'results',
                style: TextStyle(
                  fontSize: 18,
                  backgroundColor: Colors.white,
                ),
              )
            ),
            hint: 'Search...',
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(), // // Bouncing physics for the search history
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            width: isPortrait ? 600 : 500,
            debounceDelay: const Duration(milliseconds: 500),

            transition: ExpandingFloatingSearchBarTransition(), // transition sekli
            actions: [
              FloatingSearchBarAction(  // Floating search bar ustundeki iconu ayarlıyor basmadan once nasıl gozukuyor
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),

              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],

            onQueryChanged: (query){
              // Invoked when user types in characters, We would like to see history of the user!!!
              //A callback that gets invoked when the input of the query inside the TextField changed.


            },

            onSubmitted: (query){  //A callback that gets invoked when the user submitted their query (e.g. hit the search button).


            },
            builder: (context, transition) {
              return ClipRRect( // arama yerine basınca asagıdako beyaz bos alanı gösteriyor
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0, // bu dingil ne demek????
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }
}
