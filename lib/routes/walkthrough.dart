import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sucial_cs310_project/utils/dimensions.dart';
import 'package:sucial_cs310_project/utils/styles.dart';
import 'package:sucial_cs310_project/widgets/pageview_dots.dart';
import 'package:sucial_cs310_project/utils/colors.dart';


class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  PageController pc = PageController(initialPage: 0);
  bool? isDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPage();
  }
  _loadPage() async{
    return checkSeen();
  }
  Future checkSeen() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _isDone = (prefs.getBool('tutorial_seen') ?? false);
    if(_isDone)
      {
        Navigator.pushNamed(context, '/welcome');
      }
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pc,
          children: [
            firstPage(),
            secondPage(),
            thirdPage(),
            fourthPage(),
            fifthPage(context, pc),
          ],
        ),
      ),
    );
  }

}
List<Widget> dotWidgetFunction(int currentPage)
{
  return <Widget> [
    for(int i = 0 ; i < 5 ; i++)
      if(i == currentPage -1 )
        PageViewDots(bigSmall: dotSize.Big,)
      else
        PageViewDots(bigSmall: dotSize.Small,)
  ];
}


Widget firstPage()
{
  return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Column(
          children: [
            Center(
              child: Text(
                "Welcome to",
                style: gettingStartedStyleBold,
              ),
            ),
            Center(
              child: Text(
                "Sucial",
                style: sucialStyleBig,
              ),
            ),
          ],
        ),
        Text(
          "An app for Sabanci University Students",
          style: gettingStartedExplanation,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotWidgetFunction(1),
        ),
        const SizedBox(height: 40,)

      ]
  );
}

Widget secondPage()
{
  return Padding(
    padding: Dimen.onStartingMarginInsets,
    child: Column(
      children: [
        const Spacer(),
        RichText(
            text: TextSpan(
                text: "In ",
                style: gettingStartedStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: "Sucial ",
                    style: sucialStylemMed,
                  ),
                  TextSpan(
                    text: " you can",
                    style: gettingStartedStyle,
                  )
                ]
            )
        ),
        const Spacer(),
        Row(
          children: [
            const Icon(Icons.add_box_outlined),
            Text(
              "Share posts",
              style: gettingStartedExplanation,
            )
          ],
        ),
        const Divider(thickness: 2,),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 7, 0),
              child: Text(
                "#",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.indigo,
                ),

              ),
            ),
            Text(
              "Join to topics"
                  ""
                  "",
              style: gettingStartedExplanation,
            )
          ],
        ),
        const Divider(thickness: 2,),
        Row(
          children: [
            const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "Like posts of others",
                style: gettingStartedExplanation,
              ),
            )


          ],
        ),
        const Divider(thickness: 2,),
        Row(
          children: [
            const Icon(
              Icons.comment,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Text(
                "Leave comments",
                style: gettingStartedExplanation,
              ),
            )


          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotWidgetFunction(2),
        ),
        const SizedBox(height: 135),
      ],
    ),
  );
}

Widget thirdPage()
{
  return Column(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: Dimen.onStartingMarginInsets,
          child: Text(
            "Also, student clubs are waiting for you!",
            style: gettingStartedStyle,
          ),
        ),
        Center(
          child: Column(
            children: [
              const Icon(
                Icons.attribution_outlined,
                size: 150,
                color: Colors.deepPurple,
              ),
              Text(
                "Create your club page",
                style: gettingStartedExplanation,
              ),
              Text(
                "or",
                style: gettingStartedExplanation,
              ),
              Text(
                "join to an existing one",
                style: gettingStartedExplanation,
              )
            ],
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotWidgetFunction(3),
        ),
        const SizedBox(height: 160),

      ]
  );
}

Widget fourthPage()
{
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 90),
        Center(
          child: Padding(
            padding: Dimen.onStartingMarginInsets,
            child: const Icon(
              Icons.report_outlined,
              size: 150,
              color: AppColors.warningColor,
            ),
          ),
        ),
        Center(
          child: Text(
              "Avoid",
              style: gettingStartedStyle
          ),
        ),
        Padding(
          padding: Dimen.onStartingMarginInsets,
          child: Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.indigo,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Racism",
                              style: warningStyle
                          ),
                          Text(
                              "Homophobia",
                              style: warningStyle

                          ),
                          Text(
                              "Any kind of insults, scam",
                              style: warningStyle
                          ),
                          Text(
                              "Violation of right of privacy",
                              style: warningStyle
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotWidgetFunction(4),
        ),
        const SizedBox(height: 160,)
      ],
    )
  );
}
makeSeen() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('tutorial_seen', true);

  }

Widget fifthPage(BuildContext context, PageController pc)
{
  return Column(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: Dimen.onStartingMarginInsets,
          child: Text(
            "Sucial",
            style: sucialStyleBig,
          ),
        ),
        Text(
            "You are ready.",
            style: gettingStartedStyle
        ),

        Padding(
            padding: Dimen.onStartingMarginInsets,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                      ),

                      onPressed: ()
                      {
                        makeSeen();
                        Navigator.pushNamed(context, '/welcome');
                      },
                      icon: const Icon(Icons.emoji_flags),
                      label: const Text("Finish tutorial")
                  ),
                ),
                const SizedBox(width: 8.0,),
                Expanded(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                      ),

                      onPressed: ()
                      {
                        pc.previousPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      label: const Text("Previous page")
                  ),
                )
              ],
            )
        ),
        Center(
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              ),

                onPressed: ()
                {
                  pc.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              icon: const Icon(Icons.restart_alt),
              label: const Text("Restart tutorial")
            ),
          ),

        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dotWidgetFunction(5),
        ),
        const SizedBox(height: 160)
      ]
  );
}
