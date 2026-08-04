import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:login_ldm/login_app.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    // الانتظار لمدة 3 ثوانٍ (الوقت الإجمالي للأنيميشن)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // الانتقال لصفحة تسجيل الدخول واستبدال الصفحة الحالية لعدم العودة لها عند الضغط على زر الخلفية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(body: Center(
      child: Image.asset("yousif_one/logo.png" , width: size.width * 0.9)
     .animate()
     .fadeIn(duration: Duration(milliseconds: 500))
     .fadeOut(
       delay: Duration(seconds: 1),
       duration: Duration(milliseconds: 500), //  child: Text('Splash Screen'),
       ),
    ),  
    );
  }
}