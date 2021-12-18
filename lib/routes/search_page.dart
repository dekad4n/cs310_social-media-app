import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:sucial_cs310_project/model/user_profile.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';


class SearchPage2 extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  const SearchPage2({Key? key, required this.analytics, required this.observer}) : super(key: key);

  @override
  _SearchPageState2 createState() => _SearchPageState2();
}

class _SearchPageState2 extends State<SearchPage2> {

  TextEditingController searchController =  TextEditingController();
  late Future<QuerySnapshot>  searchResultsFuture;

  CollectionReference _firebasefirestore = FirebaseFirestore.instance.collection("users");

  buildresults(String query,BuildContext context ) async {

    return StreamBuilder<QuerySnapshot>(
        stream: _firebasefirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            return ListView(
              children: [
                ...snapshot.data!.docs.where(
                        (QueryDocumentSnapshot<Object?> element ) => element['usernameLower']
                        .toString()
                        .contains(searchController.text.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {
                  final String title = data['username'];
                  final String name = data.get('fullName');
                  return ListTile(
                    onTap: (){
                      //Profile gitme
                    },
                    title: Text(title),
                    leading: Text(name),
                  );
                })

              ],
            );

          }

        });
  }


  Widget BuildResults(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream: _firebasefirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          else{

            return ListView(
              children: [
                ...snapshot.data!.docs.where(
                (QueryDocumentSnapshot<Object?> element ) => element['usernameLower']
                .toString()
                .contains(searchController.text.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {
                  final String title = data['username'];
                  final String name = data.get('fullName');
                  return ListTile(
                    onTap: (){
                      //Profile gitme
                    },
                    title: Text(title),
                    leading: Text(name),
                  );
                })

              ],
            );

          }

        });

  }

  @override
  void initState(){
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose(){
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  _onSearchChanged( ){

  }

  OnSubmitShowResults(String query) async {
    buildresults(query, context);
  }

  handleSearch(String Query){
      Future<QuerySnapshot> users = FirebaseFirestore.instance
          .collection("users")
          .where("usernameLower",isGreaterThanOrEqualTo:Query )
          .get();
        setState(() {
          searchResultsFuture = users;
        });
    }

  @override
  Widget build(BuildContext context) {

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search Something.....",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: clearSearch,
                    ),
                  ),
                  onFieldSubmitted: (query){
                    OnSubmitShowResults(query);
                  },


                ),
              ),
              const SizedBox(height: 40,),






            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),

    );
  }

  void clearSearch() {
    searchController.clear();
  }
}






/**
class _SearchPageState2 extends State<SearchPage2> {

  late String SearchTerm;
  final controller = FloatingSearchBarController();// conrtoller is to control Search Bar

  get firestoreProvider => null;

  Query<Map<String, dynamic>> getSuggestion(String suggestion) {

    return FirebaseFirestore.instance.collection('users').where("usernameLower", isEqualTo: suggestion);
  }

/**
  searchByName(String searchterm) async {
    List<DocumentSnapshot> documentList;
    documentList = (await Firestore.instance.collection("users").document(firestoreProvider).where("usernameLower", isEqualTo: searchterm).documents);
    return documentList;
  }
*/
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
              getSuggestion(query);


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
*/