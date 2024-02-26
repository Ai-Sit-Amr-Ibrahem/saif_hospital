import 'package:flutter/material.dart';

abstract class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double _safeBlockHorizontal;
  static late double _safeBlockVertical;
  static late double _textscale;


  static MediaQueryData? get mediaQueryData => _mediaQueryData;

  static void _init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    // if(_mediaQueryData != null){
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;
    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;


    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
    _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;

    // _textscale = _safeBlockHorizontal / 5;
    _textscale = _screenWidth * 0.003;

    // if (_textscale < 1.0) {
    //   _textscale += (1.0 - _textscale) * (1.0 - _textscale);
    // }

    // }

  }

  static void init(BuildContext context) {
    _init(context);
  }

  static double height(double hight, BuildContext context) {
    _init(context);
    return (_mediaQueryData!.size.height) * (hight / 700);
  }

  static double width(double width, BuildContext context) {
    _init(context);
    return _mediaQueryData!.size.width * (width / 375);
  }

  static double  screenWidth (context){
    _init(context);
    return _screenWidth;
  }

  static double  screenHeight (context){
    _init(context);
    return _screenHeight;
  }

  static double  blockSizeHorizontal (context){
    _init(context);
    return _blockSizeHorizontal;
  }

  static double  blockSizeVertical (context){
    _init(context);
    return _blockSizeVertical;
  }

  static double  safeBlockHorizontal (context){
    _init(context);
    return _safeBlockHorizontal;
  }

  static double  safeBlockVertical (context){
    _init(context);
    return _safeBlockVertical;
  }

  // static double textscale (context){
  //   _init(context);
  //   return _textscale;
  // }

  static double textScale(BuildContext context) {
    _init(context);

    // Define a base text scaling factor, based on a reference screen width (e.g., an iPhone SE width)
    double baseScreenWidth = 375;
    double baseTextScaleFactor = 1.0;

    // Calculate the current text scaling factor based on the device's screen width
    double currentTextScaleFactor = baseTextScaleFactor * (_screenWidth / baseScreenWidth);

    // You can set some limits to ensure text doesn't become too small or too large
    double minTextScaleFactor = 0.8;
    double maxTextScaleFactor = 1.2;

    // Clamp the calculated text scaling factor within the defined limits
    return currentTextScaleFactor.clamp(minTextScaleFactor, maxTextScaleFactor);
  }
}