import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_cart/controllers/auth_controller.dart';
import 'package:smart_cart/views/screens/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;
  late String username;
  late String password;
  bool isLoading = false;
  registerUser() async {
    setState(() {
      isLoading = true;
    });
    await _authController
        .signUpUsers(
            context: context,
            username: username,
            email: email,
            password: password)
        .whenComplete(() {
        // _formKey.currentState!.reset();
      setState(() {
        
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(240),
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register Your Account",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: Colors.black87,
                        letterSpacing: 0.2,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "To Explore the world exclusives",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: Colors.black45,
                        letterSpacing: 0.2,
                        fontSize: 14,
                      ),
                    ),
                    Image.asset(
                      'assets/images/Illustration.png',
                      width: 250,
                      height: 250,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Full Name',
                        style: GoogleFonts.getFont('Nunito Sans',
                            fontWeight: FontWeight.w600, letterSpacing: 0.2),
                      ),
                    ),
                    // const SizedBox(height: 20,),
                    TextFormField(
                      onChanged: (value) {
                        username = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your full name',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/user.jpeg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.getFont('Nunito Sans',
                            fontWeight: FontWeight.w600, letterSpacing: 0.2),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'enter your email',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontSize: 14,
                          letterSpacing: 0.1,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/email.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          labelText: 'enter your password',
                          labelStyle: GoogleFonts.getFont(
                            'Nunito Sans',
                            fontSize: 14,
                            letterSpacing: 0.1,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/icons/password.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          suffixIcon: Icon(Icons.visibility)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          registerUser();
                        } else {
                          // print("incorrect");
                        }
                      },
                      child: Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFE102DE1),
                              Color(
                                0xCC0D6EFF,
                              ),
                            ],
                          ),
                          // color: Colors.blue,
                        ),
                        child: Center(
                            child: Stack(
                          children: [
                            Positioned(
                                left: 278,
                                top: 19,
                                child: Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 12,
                                            color: Color(0xFF103DE5)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                )),
                            Positioned(
                              left: 260,
                              top: 29,
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                    ),
                                    color: Color(0xFF2141E5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 311,
                                top: 36,
                                child: Opacity(
                                  opacity: 0.3,
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2.5),
                                    ),
                                  ),
                                )),
                            Positioned(
                                left: 281,
                                top: -10,
                                child: Opacity(
                                  opacity: 0.3,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )),
                            Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Sign Up',
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: Colors.white,
                                          letterSpacing: 0.2,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account? ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.roboto(
                              color: Color(0xFF103DE5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
