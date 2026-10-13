import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ralga/language.dart';
import 'package:ralga/utils/colors.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RALGA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appColor,
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Max width of the splash content. Keeps the layout phone-sized on
  // iPad / tablets instead of stretching across the whole screen.
  static const double _maxContentWidth = 480;

  late final AnimationController _controller;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _titleOpacity;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleOpacity;
  late final Animation<double> _progressOpacity;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.9, curve: Curves.easeOut),
      ),
    );

    _progressOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _startTimer();
  }

  void _startTimer() {
    _navigationTimer = Timer(const Duration(milliseconds: 2200), _goToNext);
  }

  void _goToNext() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Language(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Width used for all proportional sizing. On phones this equals the
    // screen width; on iPad it is capped so nothing balloons.
    final baseWidth =
        size.width > _maxContentWidth ? _maxContentWidth : size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    appColor.withOpacity(0.06),
                    whiteColor,
                    whiteColor,
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: -baseWidth * 0.35,
            right: -baseWidth * 0.35,
            child: Container(
              width: baseWidth * 0.9,
              height: baseWidth * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColor.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -baseWidth * 0.4,
            left: -baseWidth * 0.3,
            child: Container(
              width: baseWidth * 0.8,
              height: baseWidth * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appDarkColor.withOpacity(0.04),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 3),

                        // Logo
                        Opacity(
                          opacity: _logoOpacity.value,
                          child: Transform.scale(
                            scale: _logoScale.value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: appColor.withOpacity(0.15),
                                    blurRadius: 30,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/logo.png",
                                width: baseWidth * 0.28,
                                height: baseWidth * 0.28,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 36),

                        // Title
                        Opacity(
                          opacity: _titleOpacity.value,
                          child: Transform.translate(
                            offset: Offset(0, _titleSlide.value.dy * 20),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 36),
                              child: Text(
                                "Rwanda Association of Local Government Authorities",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: appColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle
                        Opacity(
                          opacity: _subtitleOpacity.value,
                          child: Text(
                            "RALGA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appDarkColor.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.5,
                            ),
                          ),
                        ),

                        const Spacer(flex: 2),

                        // Progress indicator
                        Opacity(
                          opacity: _progressOpacity.value,
                          child: const _PulsingProgressBar(),
                        ),

                        const SizedBox(height: 48),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Slim animated progress indicator: a track with a highlight that
/// sweeps back and forth.
class _PulsingProgressBar extends StatefulWidget {
  const _PulsingProgressBar();

  @override
  State<_PulsingProgressBar> createState() => _PulsingProgressBarState();
}

class _PulsingProgressBarState extends State<_PulsingProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      height: 4,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(color: appColor.withOpacity(0.12)),
                Align(
                  alignment: Alignment(
                    (_controller.value * 3.2) - 1.6,
                    0,
                  ),
                  child: Container(
                    width: 28,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: LinearGradient(
                        colors: [
                          appColor.withOpacity(0.0),
                          appColor,
                          appColor.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}