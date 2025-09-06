import 'package:finessmobileapp/screens/auth/clients/loging.dart';
import 'package:flutter/material.dart';

class splachScrenn extends StatefulWidget {
  const splachScrenn({super.key});

  @override
  State<splachScrenn> createState() => _splachScrennState();
}

class _splachScrennState extends State<splachScrenn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            /// Background Image
            SizedBox.expand(
              child: Image.asset(
                "images/splashimage.png",
                fit: BoxFit.cover,
              ),
            ),

            /// Gradient overlay (optional for premium feel)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            /// Bottom Glass-like Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Top Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Text Area
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("WELCOME !!",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                              const SizedBox(height: 6),
                              Text("Be a Human with a good mental",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  )),
                              Text("& physical health with us !",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  )),
                              const SizedBox(height: 8),
                              Text("join with us ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  )),
                            ],
                          ),
                        ),

                        /// Logo
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Container(
                        //     width: 80,
                        //     height: 80,
                        //     color: Colors.transparent,
                        //     child: Image.asset(
                        //       "images/logow.png",
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    /// Users Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => logingScrenn()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text("Users", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),

                    const SizedBox(height: 16),

                    /// Coaches Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => logingScrenn()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      child: const Text("Coaches", style: TextStyle(fontSize: 18,color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
