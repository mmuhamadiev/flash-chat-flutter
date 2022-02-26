import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/not_found_page.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnGenerateRoutes {
  static Route<dynamic> generatedRout(RouteSettings settings){
    switch(settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (BuildContext context) {
          return LoginScreen();
        });
      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (BuildContext context) {
          return RegistrationScreen();
        });
      case WelcomeScreen.routeName:
        return MaterialPageRoute(builder: (BuildContext context) {
          return WelcomeScreen();
        });
      case ChatScreen.routeName:
        return MaterialPageRoute(builder: (BuildContext context) {
          return ChatScreen();
        });
      default:
        return MaterialPageRoute(builder: (BuildContext context) {return NotFoundPage();});
    }
  }
}