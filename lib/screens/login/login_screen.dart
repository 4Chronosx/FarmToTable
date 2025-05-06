// ignore_for_file: sized_box_for_whitespace

import 'package:farm2you/commons.dart';
import 'package:farm2you/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomPaint(
            painter: CustomBackground(),
            child: Container(
              height: screenHeight,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: screenWidth,
                      height: screenHeight * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth,
                            height: 50,
                          ),
                          Text("Let's get this started!",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF),
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(0, 2.0),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: screenWidth,
                            height: 30,
                          ),
                          ToggleSwitch(
                            minWidth: 90.0,
                            cornerRadius: 20.0,
                            activeBgColors: [
                              [Color(0xFFF0D003)],
                              [Color(0xFFF0D003)]
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Color(0xFF77905B),
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: selectedIndex,
                            totalSwitches: 2,
                            labels: ['Customer', 'Farmer'],
                            customTextStyles: [
                              TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: selectedIndex == 1
                                    ? Color(0xFFF0D003)
                                    : Color(0xFF77905B),
                              ),
                              TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                color: selectedIndex == 0
                                    ? Color(0xFFF0D003)
                                    : Color(0xFF77905B),
                              ),
                            ],
                            radiusStyle: true,
                            onToggle: (index) {
                              setState(() {
                                selectedIndex = index!;
                              });
                              print('switched to: $index');
                            },
                          ),
                          SizedBox(
                            width: screenWidth,
                            height: 30,
                          ),
                          detailsInputField(
                              screenWidth,
                              screenHeight,
                              _emailController,
                              Icon(FontAwesomeIcons.envelope, size: 20), 'Email'),
                          SizedBox(
                            width: screenWidth,
                            height: 20,
                          ),
                          detailsInputField(
                              screenWidth,
                              screenHeight,
                              _passwordController,
                              Icon(FontAwesomeIcons.lock, size: 20), 'Password'),
                          SizedBox(
                            width: screenWidth,
                            height: 40,
                          ),
                          SizedBox(
                            width: screenWidth * 0.7,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context.go('/mainhomescreen');
                              },
                              style: ButtonStyle(
                                  backgroundColor: WidgetStateColor.fromMap({
                                    WidgetState.pressed:
                                        const Color.fromARGB(255, 180, 157, 2),
                                    WidgetState.any: const Color(0xFFF0D003),
                                  }),
                                  foregroundColor: WidgetStateColor.fromMap({
                                    WidgetState.pressed:
                                        const Color.fromARGB(255, 180, 157, 2),
                                    WidgetState.any: const Color(0xFFF0D003),
                                  }),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        50), // Rounded corners
                                  ))),
                              child: Text('Login',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF394E2C),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Forgot you password?',
                              style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)
                            ),
                          )
                        ],
                      )),
                  Container(
                      width: screenWidth,
                      height: screenHeight * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 1,
                                width: screenWidth * 0.2,
                                color: Colors.grey,
                              ),
                              Text('or connect with',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey)),
                              Container(
                                height: 1,
                                width: screenWidth * 0.2,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth, height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.24),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                        offset: Offset(
                                          0,
                                          3,
                                        ),
                                      ),
                                    ]),
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 50, height: 0),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.24),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                        offset: Offset(
                                          0,
                                          3,
                                        ),
                                      ),
                                    ]),
                                child: Icon(
                                  FontAwesomeIcons.facebookF,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: screenWidth, height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account yet?",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    color: Colors.grey),
                              ),
                              GestureDetector(
                                onTap: (){
                                  context.go('/signup');
                                },
                                child: Text(
                                  " Sign up",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    color: Color(0xFFF0D003),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            )));
  }
}

class CustomBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0xFFE6C700),
          Color(0xFFFFEE84),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.95, size.height * 0.6),
        radius: 90.0,
      ));
    final path = Path();
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;
    paint.color = Colors.yellow;
    path.moveTo(0, size.height * 0.55);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.65,
        size.width * 0.6, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.83, size.height * 0.60, size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.55);
    path.close();
    canvas.drawShadow(path, Color.fromRGBO(0, 0, 0, 0.5), 5.0, false);
    canvas.drawPath(path, paint);

    final paint1 = Paint();
    final path1 = Path();
    paint1.style = PaintingStyle.fill;
    paint1.strokeWidth = 5;
    paint1.color = Color(0xFF647A4C);
    path1.moveTo(0, size.height * 0.6);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.65,
        size.width * 0.5, size.height * 0.6);
    path1.quadraticBezierTo(
        size.width * 0.75, size.height * 0.55, size.width, size.height * 0.6);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.lineTo(0, size.height * 0.6);
    path1.close();
    canvas.drawShadow(path1, Color.fromRGBO(0, 0, 0, 0.20), 20.0, false);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
