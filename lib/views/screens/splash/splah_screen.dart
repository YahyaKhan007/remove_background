
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../../screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(IsLoggedInEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Waiting...",
                style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kcPrimaryForgroundColor,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.combine([
                      // TextDecoration.lineThrough,
                      TextDecoration.overline,
                      // TextDecoration.underline
                    ])),
              ),
              30.h.verticalHeight,
              loadingWidgetInkDrop(
                  size: 30.r, color: AppColors.kcPrimaryForgroundColor)
            ],
          )),
    );
  }
}
