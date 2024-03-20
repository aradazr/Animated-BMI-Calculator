import 'dart:math';

import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

//------------------------------------------------------------------------------
int _selectedGender = 0, _weight = 65;
double bmi = 0;
int _height = 170;
String bmiStatus = '';
Color textColor = Colors.black;




Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.elasticOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 133, 255),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 300,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child: Text(
                'BMI\nCalculator',
                style: GoogleFonts.alatsi(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  top: 10,
                ),
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 35,
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child:

                //Main column
                Stack(children: [
              Column(
                children: [
                  //gender text
                  Text(
                    'Gender?',
                    style: GoogleFonts.alatsi(
                        decoration: TextDecoration.underline,
                        fontSize: 35,
                        color: Colors.white,
                        decorationColor: Colors.white),
                  ),

                  Gap(20),
                  //male and female bttn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Male Bttn
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.white),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedGender = 0;
                            });
                          },
                          child: Text('Male',
                              style: GoogleFonts.alatsi(
                                fontSize: 30,
                                color: _selectedGender == 0
                                    ? Color.fromARGB(255, 0, 133, 255)
                                    : Colors.black,
                              )),
                        ),
                      ),

                      Gap(10),
                      //Female Bttn
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.white),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedGender = 1;
                            });
                          },
                          child: Text('Female',
                              style: GoogleFonts.alatsi(
                                fontSize: 30,
                                color: _selectedGender == 1
                                    ? Color.fromARGB(255, 0, 133, 255)
                                    : Colors.black,
                              )),
                        ),
                      )
                    ],
                  ),
                  Gap(30)

                  //height and slider

                  //Height Text
                  ,
                  Text('Height',
                      style: GoogleFonts.alatsi(
                          fontSize: 35, color: Colors.white)),
                  //slider
                  SfSlider(
                    value: _height.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _height = value.toInt();
                      });
                    },
                    activeColor: Colors.white,
                    inactiveColor: Color.fromARGB(150, 0, 0, 0),
                    min: 0,
                    max: 300,
                    stepSize: 1.0,
                  ),
                  Text('$_height CM',
                      style: GoogleFonts.alatsi(
                          fontSize: 25, color: Colors.white)),
                  //------------------------------------------------------------------------------------------
                  Gap(30),

                  Text('Weight',
                      style: GoogleFonts.alatsi(
                          fontSize: 35, color: Colors.white)),
                  //slider
                  SfSlider(
                    value: _weight.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _weight = value.toInt();
                      });
                    },
                    activeColor: Colors.white,
                    inactiveColor: Color.fromARGB(150, 0, 0, 0),
                    min: 35,
                    max: 170,
                    stepSize: 1.0,
                  ),
                  Text('$_weight kg',
                      style: GoogleFonts.alatsi(
                          fontSize: 25, color: Colors.white)),
                ],
              ),
              //3 layer in the bottom of the screen
              Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                      bottom: -5,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 2.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      bottom: 15,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 3.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      bottom: -20,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 1.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),

              //next page bttn
              Positioned(
                bottom: 130,
                right: 40,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200)),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          bmi = _weight / pow(_height / 100, 2);

                          bmi <= 18.5 ? bmiStatus=' UnderNormal'
                                        : bmi <= 24.5? 
                                        bmiStatus=' Normal'
                                            : bmi <= 29.9 ? 
                                            bmiStatus='nt good'

                                                : bmiStatus=' Obesity';



                                             textColor =  bmiStatus == ' UnderNormal' ? Colors.yellow :
                                             
                                              bmiStatus == ' Normal'? Color.fromARGB(255, 94, 219, 18): 

                                              bmiStatus == 'nt good'? Color.fromARGB(255, 219, 90, 18):
                                              
                                               Colors.red;
                                                
                                                
                          Navigator.of(context).push(_createRoute());
                        });
                      },
                      icon: Image.asset('assets/images/arrowRight.png',
                      fit: BoxFit.cover,
                      width: 35,
                      )
                      
                      ),
                ),
              ),

              //bottom text
              Positioned(
                bottom: 1,
                left: 20,
                child: SizedBox(
                  height: 170,
                  child: Text(
                    '''Lorem ipsum is
placeholder text 
commonly used in the graphic, print,
and publishing industries for 
previewing layouts and visual mockups.''',
                    style: GoogleFonts.alatsi(fontSize: 22),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
  
}

//--------------------------------------------------------------------------------------------

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
//Animatin builder

  late final AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2700),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInExpo));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 133, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 300,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Text(
              'BMI\nCalculator',
              style:
                  GoogleFonts.alatsi(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                top: 10,
              ),
              child: Icon(
                Icons.home,
                color: Colors.black,
                size: 35,
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Box BMI

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(70, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                            blurStyle: BlurStyle.outer,
                            blurRadius: 14.6,
                            color: Colors.black,
                            offset: Offset(0, 2),
                            spreadRadius: 0)
                      ],
                    ),
                    height: 320,
                    width: 320,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            'Your BMI Is',
                            style: GoogleFonts.alatsi(
                                color: Colors.white, fontSize: 28),
                          ),

                          Gap(20),

                          //BMI number BOX

                          Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Text(
                              '${(bmi * _animation.value).toStringAsFixed(1)}',
                              style: GoogleFonts.alatsi(
                                  color: Color.fromARGB(255, 0, 133, 255),
                                  fontSize: 60),
                            ),
                          ),

                          Gap(40)

                          // hole Slider
                          ,
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              //ColorFul slider
                              SizedBox(
                                height: 30,
                                width: 500,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(200),
                                              bottomLeft: Radius.circular(200)),
                                          color: Colors.yellow),
                                    ),
                                    Container(
                                      height: 10,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 94, 219, 18)),
                                    ),
                                    Container(
                                      height: 10,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 219, 90, 18)),
                                    ),
                                    Container(
                                      height: 10,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(200),
                                              bottomRight:
                                                  Radius.circular(200)),
                                          color:
                                              Color.fromARGB(255, 219, 18, 18)),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                // bmi calculating and position of thr container
                                left: (bmi <= 18.5
                                        ? 50
                                        : bmi <= 24.5
                                            ? 120
                                            : bmi <= 29.9
                                                ? 190
                                                : 260) *
                                    _controller.value,
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: Duration(milliseconds: 5000),
                                  height: 20,
                                  width: 10,
                                  color: Color.fromARGB(150, 255, 255, 255),
                                ),
                              )
                            ],
                          ),
                         
                         Gap(17),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Your Weight IS",
                              style: GoogleFonts.alatsi(
                                      color:Colors.white,
                                      fontSize: 25),
                              ),
                              Text(bmiStatus,style: GoogleFonts.alatsi(
                                      color:textColor,
                                      fontSize: 25),)
                            ],
                          )
                          
                        ],
                      ),
                    ),
                  ),
                ),
              Gap(30),
                 Text('Keep doing what You doing\nMaybe a little Exercise Can\nMake you Happier.',
                 
                 style: GoogleFonts.alatsi(
                                      color:Colors.white,
                                      fontSize: 25),
                 ),
                      

                      

              
              ],
            )
          
                           ,Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                      bottom: -10,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 2.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      bottom: 10,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 3.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Positioned(
                      bottom: -25,
                      child: SizedBox(
                        width: 412,
                        child: Image.asset(
                          'assets/images/Vector 1.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                      Positioned(

                bottom: 130,
                right: 40,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 5,
                            offset: Offset(0, 4))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200)),
                  child: IconButton(
                    alignment: Alignment.center,
                      onPressed: () {
                        setState(() {
                          
                                                
                                                
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        });
                      },
                      icon: Image.asset('assets/images/arrowBack.png',
                      fit: BoxFit.cover,
                      width: 35,
                      )
                      
                      ),
                ),
              ),
                
                Positioned(
                bottom: -2,
                left: 24,
                child: SizedBox(
                  height: 170,
                  child: Text(
                    '''Lorem ipsum is
placeholder text 
commonly used in the graphic, print,
and publishing industries for 
previewing layouts and visual mockups.''',
                    style: GoogleFonts.alatsi(fontSize: 22),
                  ),
                ),
              )
                
                ],
              ),
          
          
          ],
        ),
      ),
    ));
  }
}
