import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_with_database/view/screens/splash/intro_screen.dart';

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<IntroScreen1> with SingleTickerProviderStateMixin {
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

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(
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
            height: 510,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/splash1.png'),
              ),
            ),
          ),
          SizedBox(
            height: 423,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        height: 270,
                        width: 390,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.done, color: Color(0xff3B4AB1), size: 25),
                                  Text('  100% Free', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(Icons.done, color: Color(0xff3B4AB1), size: 25),
                                  Text('  No ads', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(Icons.done, color: Color(0xff3B4AB1), size: 25),
                                  Text('  By a non-profit research\n  organization', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Icon(Icons.done, color: Color(0xff3B4AB1), size: 25),
                                  Text('  67% report the free course \n  content as "life-changing"', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(const IntroScreen(),transition: Transition.zoom);
                    },
                    child: Container(
                      height: 55,
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xff6E89FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text('Get Started', style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
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
