import 'package:finessmobileapp/screens/auth/clients/loging.dart';
import 'package:finessmobileapp/screens/clients/addDetails.dart';
import 'package:finessmobileapp/screens/clients/dashboard.dart';
import 'package:finessmobileapp/screens/clients/exerciseSchedule.dart';
import 'package:finessmobileapp/screens/clients/feedbacckScreen.dart';
import 'package:finessmobileapp/screens/clients/gymDetails.dart';
import 'package:finessmobileapp/screens/clients/selectCoaches.dart';
import 'package:flutter/material.dart';

class appbat extends StatefulWidget {
  const appbat({super.key});

  @override
  State<appbat> createState() => _appbatState();
}

class _appbatState extends State<appbat> {
  int index=0;
  final screen=[
    dashboardScreen(),
    addDetails(),
    selectCoaches(),
    gymmDetails(),
    exerciseSChedule()
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
