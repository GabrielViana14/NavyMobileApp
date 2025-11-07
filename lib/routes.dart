import 'package:flutter/material.dart';
import 'package:flutter_application_test/about_us_page.dart';
import 'package:flutter_application_test/editPage.dart';
import 'package:flutter_application_test/faq_page.dart';
import 'package:flutter_application_test/feedback_page.dart';
import 'package:flutter_application_test/loginPage.dart';
import 'package:flutter_application_test/mainPage.dart';


class AppRoutes {
  // Prevenir instanciação
  AppRoutes._();

  static const main = '/main';
  static const login = '/login';
  static const edit = '/edit';
  static const about = '/about';
  static const faq = '/faq';
  static const feedback = '/feedback';

}

class AppRouter {
  // Prevenir instanciação
  AppRouter._();

  /// Retorna o mapa de rotas para ser usado no MaterialApp
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.main: (context) => MainPage(),
      AppRoutes.login: (context) => LoginPage(),
      AppRoutes.edit: (context) => EditPage(),
      AppRoutes.about: (context) => AboutUsPage(),
      AppRoutes.faq: (context) => FaqPage(),
      AppRoutes.feedback: (context) => FeedbackPage(),

    };
  }
}