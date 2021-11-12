import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hlokomela/src/edit_note/edit_note_data.dart';
import 'package:hlokomela/src/welcome/welcome_view.dart';

import 'edit_note/edit_note_view.dart';
import 'list_note/list_note_view.dart';
import 'login/login_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                Object? args = routeSettings.arguments;
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case WelcomeView.routeName:
                    return const WelcomeView();
                  case LoginRegisterView.routeNameLogin:
                    return const LoginRegisterView(type: "Login",);
                  case LoginRegisterView.routeNameRegister:
                    return const LoginRegisterView(type: "Register",);
                  case ListNoteView.routeName:
                    return const ListNoteView();
                  case EditNoteView.routeName:
                    if (args is EditNoteData) {
                      return EditNoteView(noteName: (args).noteName, isNew: (args).isNew,);
                    }
                    return const ListNoteView();
                  default:
                    return const WelcomeView();
                }
              },
            );
          },
        );
      },
    );
  }
}

class EditNoteViewData {

}
