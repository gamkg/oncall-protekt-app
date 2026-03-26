import 'package:flutter/material.dart';

class IPhoneFrame extends StatelessWidget {
  final Widget child;

  const IPhoneFrame({super.key, required this.child});

  // iPhone 15 Pro dimensions ratio: 393 x 852
  static const double _phoneWidth = 393;
  static const double _phoneHeight = 852;
  static const double _bezelRadius = 50;
  static const double _screenRadius = 44;
  static const double _bezelWidth = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: _phoneWidth + _bezelWidth * 2,
            height: _phoneHeight + _bezelWidth * 2,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(_bezelRadius),
              border: Border.all(color: const Color(0xFF3A3A3C), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: const Color(0xFFFACC15).withValues(alpha: 0.05),
                  blurRadius: 60,
                  spreadRadius: -10,
                ),
              ],
            ),
            padding: const EdgeInsets.all(_bezelWidth),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_screenRadius),
              child: Stack(
                children: [
                  // The app content
                  SizedBox(
                    width: _phoneWidth,
                    height: _phoneHeight,
                    child: MediaQuery(
                      data: const MediaQueryData(
                        size: Size(_phoneWidth, _phoneHeight),
                        padding: EdgeInsets.only(top: 59, bottom: 34),
                        viewPadding: EdgeInsets.only(top: 59, bottom: 34),
                      ),
                      child: child,
                    ),
                  ),
                  // Dynamic Island
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 126,
                        height: 37,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  // Bottom home indicator
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
