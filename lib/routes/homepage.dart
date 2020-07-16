import 'package:flutter/material.dart';
import 'package:toggle_button/components/animated_toggle_button.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color(0xDDFF0080),
      const Color(0xDDFF8C00),
    ],
    backgroundColor: const Color(0xFFFFFFFF),
    textColor: const Color(0xFF000000),
    toggleButtonColor: const Color(0xFFFFFFFF),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF8983F7),
      const Color(0xFFA3DAFB),
    ],
    backgroundColor: const Color(0xFF26242e),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFf34323d),
    toggleBackgroundColor: const Color(0xFF222029),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0x66000000),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  changeThemeMode() {
    if (isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          isDarkMode ? darkMode.backgroundColor : lightMode.backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: width * 0.35,
                    height: width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            isDarkMode ? darkMode.gradient : lightMode.gradient,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 0),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.decelerate),
                        ),
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width * 0.26,
                        height: width * 0.26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? darkMode.backgroundColor
                              : lightMode.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                'Choose a style',
                style: TextStyle(
                  color: isDarkMode ? darkMode.textColor : lightMode.textColor,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.7,
                child: Text(
                  'Pop or subtle. Day or night. Customize your interface',
                  style: TextStyle(
                    color:
                        isDarkMode ? darkMode.textColor : lightMode.textColor,
                    fontSize: width * 0.04,
                    fontFamily: 'Rubik',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              AnimatedToggle(
                values: ['Light', 'Dark'],
                textColor:
                    isDarkMode ? darkMode.textColor : lightMode.textColor,
                backgroundColor: isDarkMode
                    ? darkMode.toggleBackgroundColor
                    : lightMode.toggleBackgroundColor,
                buttonColor: isDarkMode
                    ? darkMode.toggleButtonColor
                    : lightMode.toggleButtonColor,
                shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
                onToggleCallback: (index) {
                  isDarkMode = !isDarkMode;
                  setState(() {});
                  changeThemeMode();
                },
              ),
              SizedBox(
                height: height * 0.05,
                width: width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                  buildDot(
                    width: width * 0.055,
                    height: width * 0.022,
                    color: !isDarkMode
                        ? darkMode.backgroundColor
                        : lightMode.backgroundColor,
                  ),
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: const Color(0xFF7c7b7e),
                          fontFamily: 'Rubik',
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Loved it? Give a star on Github',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: width * 0.045,
                                ),
                              ),
                            ),
                          );
                        },
                        shape: CircleBorder(),
                        color: const Color(0xFFFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot({double width, double height, Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}

class ThemeColor {
  List<Color> gradient;
  Color backgroundColor;
  Color toggleButtonColor;
  Color toggleBackgroundColor;
  Color textColor;
  List<BoxShadow> shadow;

  ThemeColor({
    this.gradient,
    this.backgroundColor,
    this.toggleBackgroundColor,
    this.toggleButtonColor,
    this.textColor,
    this.shadow,
  });
}
