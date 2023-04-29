import 'package:hotel_app/feature/login/page/login_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginScreen, initial: true),
  ],
)
class $AppRouter {}