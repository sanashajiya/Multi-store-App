import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  const InnerHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/searchBanner.jpeg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
                left: 16,
                top: 68,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ))),
            Positioned(
              left: 60,
              top: 68,
              child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Text",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7F7F7F),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      prefixIcon: Image.asset('assets/icons/searc1.png'),
                      suffixIcon: Image.asset('assets/icons/cam.png'),
                      fillColor: Colors.grey.shade200,
                      focusColor: Colors.black,
                      filled: true,
                    ),
                  )),
            ),
            Positioned(
                left: 311,
                top: 78,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    // overlayColor: WidgetStateProperty.all(Color(0x0c7f79af)),
                    child: Ink(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/bell.png'))),
                    ),
                  ),
                )),
            Positioned(
                left: 354,
                top: 78,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    // overlayColor: WidgetStateProperty.all(Color(0x0c7f79af)),
                    child: Ink(
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/icons/message.png'),
                      )),
                    ),
                  ),
                )),
          ],
        ),
      );
  }
}