import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app/quotes_view_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Scaffold(
        body: Container(
          color: Color(0xfff0e7da),
          child: Center(
              child: Padding(
            padding:  EdgeInsets.only(
                left:MediaQuery.of(context).size.width *0.32,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'QUOTES',
                  style: GoogleFonts.bagelFatOne(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color(0xff895159),)
                      .copyWith(),
                ),
                Text(
                  'Quotes are brief excerpts or passages from a source that are repeated or cited by someone else.They provide evidence, support arguments, convey messages, or highlight significant statements or ideas. Quotes can be sourced from various materials and are commonly used in writing, speeches, and conversations to add credibility, depth, and memorable expressions.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  maxLines: 10,
                  
                )
              ],
            ),
          )),
        ),
      ),
      child: QuotesViewPage(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _yRotationAnimationForChild;
  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForChild =
        Tween<double>(begin: 0, end: -pi / 2).animate(_xControllerForChild);
    _xControllerForDrawer =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yRotationAnimationForDrawer =
        Tween<double>(begin: -pi / 2.7, end: 0).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.7;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xControllerForChild.value += details.delta.dx / maxDrag;
        _xControllerForDrawer.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _xControllerForChild,
            _xControllerForDrawer,
          ],
        ),
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 113, 68, 75),
              ),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_xControllerForChild.value * maxDrag)
                  ..rotateY(_yRotationAnimationForChild.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                      -screenWidth + _xControllerForDrawer.value * maxDrag)
                  ..rotateY(_yRotationAnimationForDrawer.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
