import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/services/topic_service.dart';
import 'package:sucial_cs310_project/ui/topic_card.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/widgets/navbars.dart';

class SearchTopics extends StatefulWidget {
  const SearchTopics({Key? key}) : super(key: key);

  @override
  _SearchTopicsState createState() => _SearchTopicsState();
}

class _SearchTopicsState extends State<SearchTopics> {
  TextEditingController topicController =  TextEditingController();
  @override
  void initState(){
    super.initState();
    topicController.addListener(_onSearchChanged);
  }
  @override
  void dispose(){
    topicController.dispose();
    super.dispose();
  }
  _onSearchChanged( )
  {
    setState(() {
    });
  }
  buildSearchResults(){}
  void clearSearch() =>
      topicController.clear();

  TopicService topicService = TopicService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: topicService.topics.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot){
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: topicController,
                      decoration: InputDecoration(
                        hintText: "Search Topics.....",
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
                  if(topicController.text != "")
                    Column(
                      children: snapshot.data!.docs.where(
                              (QueryDocumentSnapshot<Object?> element) =>
                              element['topicName']
                                  .toString().contains(
                                  topicController.text) /*&& !element["isDisabled"]*/)
                          .map((QueryDocumentSnapshot<Object?> data) =>
                          TopicCard(topicName: data['topicName'])).toList(),
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
