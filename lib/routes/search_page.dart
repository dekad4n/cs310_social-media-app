import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/search_card.dart';
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
  UsersService userService = UsersService();

  @override
  void initState(){
    super.initState();
    searchController.addListener(_onSearchChanged);
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

                    ),
                  ),
                  const SizedBox(height: 40,),
                  if(searchController.text != "")
                    Column(
                      children: snapshot.data!.docs.where(
                              (QueryDocumentSnapshot<Object?> element) =>
                              element['usernameLower']
                                  .toString().contains(
                                  searchController.text.toLowerCase()))
                          .map((QueryDocumentSnapshot<Object?> data) =>
                          SearchCard(username: data['username'],
                              profilePic: data['profilepicture'])).toList(),
                    )
                ],
              ),
            ),
          );
        }

        ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }
}
