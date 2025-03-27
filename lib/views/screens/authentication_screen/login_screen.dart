import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login Your Account",
              style: GoogleFonts.getFont(
                "Lato",
                color: Color(0xFF0d120E),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2, 
                fontSize: 23,
                ),
              ),
              Text(
                "To Explore the world exclusives",style: GoogleFonts.getFont(
                  'Lato',
                  color: Color(0xFF0d120E),
                  letterSpacing: 0.2, 
                  fontSize: 14,
                  ),
              ),
              Image.asset('assets/images/illustration.png',width: 200,height: 200,)
          ],
        ),
      ),
    );
  }
}
