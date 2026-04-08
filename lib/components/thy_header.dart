import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme.dart';

class ThyHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const ThyHeader({super.key, this.title = '', this.trailing});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Container(
            color: ThyTheme.bannerBackground,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (title.isNotEmpty)
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      if (trailing != null)
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: trailing!,
                        ),
                      _buildExitButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 4.h,
          color: ThyTheme.accentRed,
        ),
      ],
    );
  }

  Widget _buildExitButton(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: ElevatedButton(
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            SystemNavigator.pop();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9D9D9),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: const BorderSide(color: Color(0xFF0078D7), width: 1),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Exit',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.arrow_forward, size: 16.sp, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

