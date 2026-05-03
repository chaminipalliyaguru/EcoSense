import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home/home_screen_signup_login.dart';

class AppDetailsScreen extends StatelessWidget {
  const AppDetailsScreen({super.key});

  final Color _primaryGreen = const Color(0xFF4A7B59);

  Widget _buildFeatureListItem({
    required String title,
    required String description,
    required String imagePath,
    required Color bgColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Box
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello ! Username",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "App Overview",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(16.0.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFA1BBA4),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "This application is for vehicle owners. After you have done emission testing, you can upload the report through camera. The app scans the report and gives the reason for failure (if failed) and also recommendations on how to fix it. It also provides recommendations to repair vehicle even for pass reports",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    height: 1.4,
                  ),
                ),
              ),
              SizedBox(height: 30.h),

              Text(
                "Key Features",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              SizedBox(height: 24.h),

              _buildFeatureListItem(
                title: "Emission Prediction",
                description: "Predicts emission levels based on the test report and vehicle data.",
                imagePath: "assets/images/appDetailed/emission prediction.png",
                bgColor: const Color(0xFFF1F8EE),
              ),

              _buildFeatureListItem(
                title: "Data Input for Vehicle Details",
                description: "Add and manage your vehicle information easily",
                imagePath: "assets/images/appDetailed/data-input.png",
                bgColor: const Color(0xFFE9F2FB),
              ),

              _buildFeatureListItem(
                title: "Report Generation",
                description: "Get clear insights and manage suggestions based in analysis",
                imagePath: "assets/images/appDetailed/repot_ge.png",
                bgColor: const Color(0xFFF3E8FA),
              ),

              _buildFeatureListItem(
                title: "Dashboard Visualization",
                description: "View trends and history with easy dashboards",
                imagePath: "assets/images/appDetailed/dashboard.png",
                bgColor: const Color(0xFFFFF3E6),
              ),

              SizedBox(height: 40.h),

              Text(
                "How the System Works",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              SizedBox(height: 30.h),

              _buildSystemStepItem(
                stepNumber: "1",
                title: "User takes photo of emission testing reports",
                description: "Capture the report using the in-app camera.",
              ),

              _buildSystemStepItem(
                stepNumber: "2",
                title: "System processes data",
                description: "The system app scans and extracts the required information.",
              ),

              _buildSystemStepItem(
                stepNumber: "3",
                title: "Model predicts emission levels",
                description: "Our intelligent model analyzes the data and predicts results.",
              ),

              _buildSystemStepItem(
                stepNumber: "4",
                title: "Results are displayed",
                description: "You get results along with reasons and recommendations",
                isLast: true,
              ),

              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text(
                    "Explore App",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSystemStepItem({
    required String stepNumber,
    required String title,
    required String description,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: _primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 60.h,
                  color: _primaryGreen.withOpacity(0.3),
                ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
