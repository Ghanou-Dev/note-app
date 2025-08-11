import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes/const.dart';
import 'package:notes/l10n/app_localizations.dart';
import 'package:notes/pages/cubits/delete_cubit/delete_cubit.dart';
import 'package:notes/pages/cubits/favoriet_cubit/favoriet_cubit.dart';
import 'package:notes/pages/cubits/home_cubit/home_cubit.dart';
import 'package:notes/pages/home_page.dart';

void main() {
  // testing appBar Widget
  testWidgets('testing AppBar in HomePage', (WidgetTester tester) async {
    late AppLocalizations local;
    // تهيئة بيئة اختبار لتشغيل الصفحة
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (context) => FavorietCubit()),
          BlocProvider(create: (context) => DeleteCubit()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(392, 834),
          builder: (context, child) => MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            home: Builder(
              builder: (context) {
                local = AppLocalizations.of(context)!;
                return const HomePage();
              },
            ),
          ),
        ),
      ),
    );
    // اختبار التحقق من العناصر
    Finder homeBodyFinder = find.byKey(const Key(homeBodyKey));
    expect(homeBodyFinder, findsOneWidget);

    Finder appBarFinder = find.descendant(
      of: homeBodyFinder,
      matching: find.byKey(const Key(homeAppBarKey)),
    );
    expect(appBarFinder, findsOneWidget);

    Finder titleAppBarFinder = find.text(local.keep_note);
    expect(titleAppBarFinder, findsOneWidget);

    Finder buttonThemeFinder = find.descendant(
      of: appBarFinder,
      matching: find.byKey(const Key(buttonThemeKey)),
    );
    expect(buttonThemeFinder, findsOneWidget);

    Finder iconButtonThemeFinder = find.descendant(
      of: buttonThemeFinder,
      matching: find.byIcon(Icons.light_mode),
    );
    expect(iconButtonThemeFinder, findsOneWidget);

    // اختبار الضغط على الزر
    await tester.tap(buttonThemeFinder);
    await tester.pumpAndSettle();
    expect(buttonThemeFinder, findsOneWidget);

    // find the body
    Finder customBodyFinder = find.byKey(const Key(customBodyKey));
    expect(customBodyFinder, findsOneWidget);

    // find customSearchbar
    Finder customSearchBarFinder = find.byKey(const Key(customSearchBarKey));
    expect(customSearchBarFinder, findsOneWidget);

    Finder focusScopeFinder = find.byKey(const Key(focusScopeKey));
    expect(focusScopeFinder, findsOneWidget);

    // التحقق من وجود حقل البحث داخل FocusNode
    Finder searchBarFinder = find.descendant(
      of: focusScopeFinder,
      matching: find.byType(SearchBar),
    );
    expect(searchBarFinder, findsOneWidget);

    // الان ايجاد حقل الادخال داخل حقل البحث
    Finder textFieldFinder = find.descendant(
      of: searchBarFinder,
      matching: find.byType(TextField),
    );
    expect(textFieldFinder, findsOneWidget);
    // الان الضغط على حقل البحث
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // ادخال نص البحث
    await tester.enterText(textFieldFinder, '');
    await tester.pumpAndSettle();
    // التحقق من وجود نص No Notes
    expect(find.byKey(const Key(listTileResultSearchFailureKey)), findsOneWidget);
  });
}
