import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.only(left: 50 ,right: 50, top: 20),
                child: Container(
                  height: 150,
                 // width: 450,
                    decoration: BoxDecoration(

                    color: Color(0xfff0e7da),
                    borderRadius:BorderRadius.vertical(bottom: Radius.circular(15)) ,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black,
                    //     offset: Offset(0, 2),
                    //     blurRadius: 6,
                    //   )
                    // ],
                  ),
                ),
              ),
              baseColor: Color(0xfff0e7da).withOpacity(0.3),
              highlightColor: Color(0xfff0e7da).withOpacity(0.6),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  //width: 500,
                  height: 350,
                  decoration: BoxDecoration(
                    color: Color(0xfff0e7da),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      )
                    ],
                  ),
                ),
              ),
              baseColor: Color(0xfff0e7da),
              highlightColor: Color(0xfff0e7da).withOpacity(0.6),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
                child: Container(
                  //width: 450,
                  height: 150,
                             decoration: BoxDecoration(
                    color: Color(0xfff0e7da),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black,
                    //     offset: Offset(0, 2),
                    //     blurRadius: 6,
                    //   )
                    // ],
                  ),
                ),
              ),
              baseColor: Color(0xfff0e7da).withOpacity(0.3),
              highlightColor: Color(0xfff0e7da).withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }
}
