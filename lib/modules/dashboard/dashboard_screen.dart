import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../components/thy_header.dart';
import '../../components/module_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ThyHeader(),
          Expanded(
            child: SafeArea(
              top: false, // Header handles top safe area
              child: Column(
                children: [
                   Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Center(
                        child: Wrap(
                          spacing: 20.w,
                          runSpacing: 20.h,
                          alignment: WrapAlignment.center,
                          children: [
                            ModuleCard(
                              title: 'Audio Visual Memory',
                              iconPath: 'assets/images/menu/firstQuestion.png',
                              onTap: () => context.push('/audio-visual-memory'),
                            ),
                            ModuleCard(
                              title: 'Digit Span',
                              iconPath: 'assets/images/menu/fourthQuestion.png',
                              onTap: () => context.push('/digit-span'),
                            ),
                            ModuleCard(
                              title: 'Agility',
                              iconPath: 'assets/images/menu/fifthQuestion.png',
                              onTap: () => context.push('/agility'),
                            ),
                            ModuleCard(
                              title: 'Sustained Attention',
                              iconPath: 'assets/images/menu/sixthQuestion.png',
                              onTap: () => context.push('/sustained-attention'),
                            ),
                            ModuleCard(
                              title: 'Spatial Orientation',
                              iconPath: 'assets/images/menu/seventhQuestion.png',
                              onTap: () => context.push('/spatial-orientation'),
                            ),
                            ModuleCard(
                              title: '3 Dimensional Spatial Perception',
                              iconPath: 'assets/images/menu/eighthQuestion.png',
                              onTap: () => context.push('/3d-perception'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Text(
                      'Please choose a test to start...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
