import 'package:flutter/material.dart';

import '../../config/assets/assets_path.dart';
import '../../config/routes/local_routes.dart';
import '../../widgets/animations/pulse_animation.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, LocalRoutes.HOME, (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ColoredBox(
        color: theme.colorScheme.secondary,
        child: Center(
          child: PulseAnimation(
            child: Image.asset(
              AssetsPath.LOGO,
              height: MediaQuery.of(context).size.height * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
