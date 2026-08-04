import 'package:flutter/material.dart';
import 'package:login_ldm/screen/splash.dart';

void main() {                                 
  runApp (const MyApp());
}
   //             *******************************************
   //             *                                         *
   //             *          NAME : YOUSIF NAER             *
   //             *       PROJECT : DIGITAL LIBRARY         *
   //             *             DATA : 2 0 2 6              *
   //             *                                         *
   //             *                                         *
   //             *                                         *
   //             *                                         *
   //             *******************************************
    
  class MyApp extends StatelessWidget {
    const MyApp ({super.key});

    // This widget is the root of your application.
    @override
  Widget build (BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,   // الغاء البنر
       title : 'login',            //  عنـوان ثـنوي
      
       home : Splash()
    );
  }
}
