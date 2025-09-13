import 'package:finessmobileapp/screens/coaches/addcoachdetails.dart';
import 'package:finessmobileapp/screens/coaches/addgym.dart';
import 'package:flutter/material.dart';

class caochappbar extends StatefulWidget {
  const caochappbar({super.key});

  @override
  State<caochappbar> createState() => _caochappbarState();
}

class _caochappbarState extends State<caochappbar> {
  int index=0;
  final screen=[
    coachDetail(),
    addGym(),
    addGym(),
    addGym(),
    addGym()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 3,
        child: SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: Container(
                color: Colors.black,
                child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings,color: Colors.white70,),
                        title: Text("Setting",style: TextStyle(color: Colors.white),),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback,color: Colors.white70,),
                        title: Text("Feedback",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        leading: Icon(Icons.info,color: Colors.white70,),
                        title: Text("About US",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      ),
                      ListTile(
                        title: Text("#####",style: TextStyle(color: Colors.white),),
                      )
                    ]
                ),
              ),
            ),

            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Home",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),

            ),
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor: Colors.black,
                indicatorColor: Colors.white70,
                labelTextStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14);
                  }
                  return TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14);
                }),
              ),
              child: NavigationBar(
                height: 55,
                selectedIndex: index,
                onDestinationSelected: (index) =>
                    setState(() => this.index=index),


                destinations: [
                  NavigationDestination(icon: Icon(Icons.home,color: Colors.white,), label: "Home"),
                  NavigationDestination(icon: Icon(Icons.add,color: Colors.white,), label: "Add Details"),
                  NavigationDestination(icon: Icon(Icons.chat, color: Colors.white), label: "Chat"),
                  NavigationDestination(icon: Icon(Icons.fitness_center,color: Colors.white), label: "Gyms"),
                  NavigationDestination(icon: Icon(Icons.person,color: Colors.white), label: "Account"),

                ],
              ),

            ),
            body: screen[index],
          ),
        )

    );

  }
}