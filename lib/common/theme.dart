import 'package:flutter/material.dart';

const defaultSpacing = 16.0;

const _primary = Color(0xffAE2C6A);
const primaryContainer = Color(0xffebe7ee);

final appTheme = ThemeData(
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: _primary,
    primary: _primary,
    primaryContainer: primaryContainer,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Color(0xff81738c),
  ),
  useMaterial3: true,
  chipTheme: const ChipThemeData(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: 4,
  ),
  scaffoldBackgroundColor: Colors.white,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  ),
  sliderTheme: const SliderThemeData(
    disabledThumbColor: Colors.grey,
    disabledActiveTrackColor: Colors.grey,
  ),
);

const shimmerGradient = LinearGradient(
  colors: [Color(0xAA767676), Color(0xAAF4F4F4), Color(0xAA767676)],
  stops: [0.1, 0.3, 0.4],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
