import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/user_service.dart';
import 'package:sucial_cs310_project/ui/search_card.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  TextEditingController messController =  TextEditingController();
  late Future<QuerySnapshot>  messResults;

  UsersService userService = UsersService();
  @override
  void initState(){
    super.initState();
    messController.addListener(_onSearchChanged);
  }
  @override
  void dispose(){
    messController.dispose();
    super.dispose();
  }
  _onSearchChanged( )
  {
    setState(() {
    });
  }
  buildSearchResults(){}
  void clearSearch() =>
      messController.clear();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBack(context, "Choose User"),
      backgroundColor: AppColors.backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
          stream: userService.users.snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: messController,
                        decoration: InputDecoration(
                          hintText: "Search Something.....",
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: clearSearch,
                          ),
                        ),

                      ),
                    ),

                    const SizedBox(height: 40,),
                    if(messController.text != "")
                      Column(
                        children: snapshot.data!.docs.where(
                                (QueryDocumentSnapshot<Object?> element) =>
                                element['usernameLower']
                                    .toString().contains(
                                    messController.text.toLowerCase()) /*&& !element["isDisabled"]*/)
                            .map((QueryDocumentSnapshot<Object?> data) =>
                            SearchCard(
                              analytics: FirebaseAnalytics(),
                              observer: FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                              username: data['username'],
                              profilePic: data['profilepicture'],
                              userId: data['userId'],
                              isMessage: true,
                            )).toList(),
                      )
                  ],
                ),
              ),
            );
          }

      ),
    );
  }
}

