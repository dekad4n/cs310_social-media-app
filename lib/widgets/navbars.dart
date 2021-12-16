import 'package:flutter/material.dart';
import 'package:sucial_cs310_project/utils/colors.dart';
import 'package:sucial_cs310_project/utils/styles.dart';

AppBar appBarDefault(){
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        onPressed: (){},
        icon: const Icon(Icons.add),
      ),
    ),
    actions: [
      IconButton(
          onPressed: (){},
          icon: const Icon(Icons.send)
      )
    ],
    title: Text(
      'Sucial',
      style: sucialStylemMed,
    ),
    centerTitle: true,
    backgroundColor: AppColors.moreDarkerBackground,
  );
}


BottomNavigationBar bottomNavBar(BuildContext context)
{
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: IconButton(

                onPressed: (){
                  Navigator.pushNamed(context, '/feed');
                },
                icon: const Icon(Icons.home),
            ),
          label: '',

        ),
        BottomNavigationBarItem(
          icon: IconButton(

            onPressed: (){
              Navigator.pushNamed(context, '/search_page');
            },
            icon: const Icon(Icons.search),
          ),
          label: '',

        ),

        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/feed');
            },
            icon: const Icon(Icons.tag),
          ),
          label: '',

        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: (){
              Navigator.pushNamed(context, '/feed');
            },
            icon: const Icon(Icons.notifications),
          ),
          label: '',

        ),


        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
            ),
          label: '',
        ),
    ]
  );
}