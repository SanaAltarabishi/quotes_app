import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes_app/3dDrawer.dart';
import 'package:quotes_app/quotes_view_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xff895159),
        body: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: DrawerPage(),
                //QuotesViewPage(),
                 type: PageTransitionType.fade));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.6, 0.01],
            colors: [
                Color(0xfff0e7da),
              Color(0xff895159),
            
            ],
          ),
        ),
        child: Center(
          child: AnimatedTextKit(animatedTexts: [
            TyperAnimatedText(
              "Quotes",
              textStyle: GoogleFonts.bagelFatOne(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.black)
                  .copyWith(
                decoration: TextDecoration.underline,
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
