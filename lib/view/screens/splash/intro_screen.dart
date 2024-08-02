import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_with_database/view/screens/home/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 480,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/splash2.png'),
              ),
            ),
          ),
          SizedBox(
            height: 450,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        FadeTransition(
                          opacity: _opacityAnimation,
                          child: Text(
                            'Self Daily Motivation reminders',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 30),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            height: 55,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('How many', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.remove),
                                  ),
                                  Text('1X', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            height: 55,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Starts at', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.remove),
                                  ),
                                  Text('9:00 AM', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            height: 55,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ends at', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.remove),
                                  ),
                                  Text('6:00 PM', style: GoogleFonts.poppins(fontSize: 16)),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffF0F2FF),
                                      border: Border.all(width: 0.5, color: Colors.blue),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    textAlign: TextAlign.center,
                    '1 message will be randomly sent between 9:00 AM and 6:00 PM',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(HomeScreen(selectedCategories: []),transition: Transition.zoom);
                    },
                    child: Container(
                      height: 55,
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color(0xff6E89FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
