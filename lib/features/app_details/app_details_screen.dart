import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/feature_list_item.dart';
import 'widgets/system_step_item.dart';
import 'widgets/app_overview_card.dart';

class AppDetailsScreen extends StatelessWidget {
  const AppDetailsScreen({super.key});

  final Color _primaryGreen = const Color(0xFF4A7B59);

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
              
              AppOverviewCard(primaryGreen: _primaryGreen),
              
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

              const FeatureListItem(
                title: "Emission Prediction",
                description: "Predicts emission levels based on the test report and vehicle data.",
                imagePath: "assets/images/appDetailed/emission prediction.png",
                bgColor: Color(0xFFF1F8EE),
              ),

              const FeatureListItem(
                title: "Data Input for Vehicle Details",
                description: "Add and manage your vehicle information easily",
                imagePath: "assets/images/appDetailed/data-input.png",
                bgColor: Color(0xFFE9F2FB),
              ),

              const FeatureListItem(
                title: "Report Generation",
                description: "Get clear insights and manage suggestions based in analysis",
                imagePath: "assets/images/appDetailed/repot_ge.png",
                bgColor: Color(0xFFF3E8FA),
              ),

              const FeatureListItem(
                title: "Dashboard Visualization",
                description: "View trends and history with easy dashboards",
                imagePath: "assets/images/appDetailed/dashboard.png",
                bgColor: Color(0xFFFFF3E6),
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

              SystemStepItem(
                stepNumber: "1",
                title: "User takes photo of emission testing reports",
                description: "Capture the report using the in-app camera.",
                primaryGreen: _primaryGreen,
              ),

              SystemStepItem(
                stepNumber: "2",
                title: "System processes data",
                description: "The system app scans and extracts the required information.",
                primaryGreen: _primaryGreen,
              ),

              SystemStepItem(
                stepNumber: "3",
                title: "Model predicts emission levels",
                description: "Our intelligent model analyzes the data and predicts results.",
                primaryGreen: _primaryGreen,
              ),

              SystemStepItem(
                stepNumber: "4",
                title: "Results are displayed",
                description: "You get results along with reasons and recommendations",
                primaryGreen: _primaryGreen,
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
}
