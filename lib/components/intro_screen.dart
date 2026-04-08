import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/thy_header.dart';
import '../../core/theme.dart';

class IntroScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onNext;
  final VoidCallback? onBack;

  const IntroScreen({
    super.key,
    required this.title,
    required this.children,
    required this.onNext,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ThyHeader(title: 'Introduction'),
          Expanded(
            child: SafeArea(
              top: false, // Header handles top safe area
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: children,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (onBack != null)
                            ElevatedButton.icon(
                              onPressed: onBack,
                              icon: Image.asset('assets/images/back.png', width: 24.w),
                              label: Text('Back', style: TextStyle(fontSize: 14.sp)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          ElevatedButton.icon(
                            onPressed: onNext,
                            icon: Image.asset('assets/images/next.png', width: 24.w),
                            label: Text('Next', style: TextStyle(fontSize: 14.sp)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
