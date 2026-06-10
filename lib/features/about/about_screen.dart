import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home/widgets/top_app_bar.dart';
import '../../widgets/feature_list_item.dart';
import '../../data/key_features.dart';
import '../../data/system_steps_data.dart';
import '../../widgets/system_step_item.dart';
import '../../data/benefits_ecosense.dart';
import '../../widgets/benefits_list_item.dart';
import '../../widgets/app_bottom_nav.dart';

class AboutScreen extends StatefulWidget {
  final bool isGuest;

  const AboutScreen({super.key, this.isGuest = false});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _selectedIndex = 0;
  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  Widget build(BuildContext context) {
    final bool effectiveIsGuest =
        (ModalRoute.of(context)?.settings.arguments as bool?) ?? widget.isGuest;
    // TODO: implement build
    Widget sectionTitle(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: _primaryGreen,
        ),
      );
    }

    Widget sectionText(String text) {
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: TopAppBar(
        primaryGreen: _primaryGreen,
        showBackButton: true,
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image Banner
            // Image Banner (FULL WIDTH)
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/home/home-your-vehical.png",
                fit: BoxFit.cover, // better than fill
              ),
            ),

            const SizedBox(height: 20),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔻 App Overview
                    sectionTitle("App Overview"),
                    sectionText(
                        "This application is for vehicle owners. After you have done emission testing, you can upload the report through camera. The app scans the report and gives the reason for failure (if failed) and also recommendations on how to fix it."),

                    const SizedBox(height: 16),

                    // 🔻 Purpose
                    sectionTitle("Purpose of the system"),
                    sectionText(
                        "To give users convenience with their vehicle repairs and to have knowledge on their vehicles saving time"),

                    const SizedBox(height: 20),

                    Text(
                      "Key Features",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Column(
                      children: appFeatures.map((feature) {
                        return FeatureListItem(
                          title: feature.title,
                          description: feature.description,
                          imagePath: feature.imagePath,
                          bgColor: feature.bgColor,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 40),

                    // How the System Works Section
                    Text(
                      "How the System Works",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Step 1
                    Column(
                      children: List.generate(systemSteps.length, (index) {
                        final step = systemSteps[index];

                        return SystemStepItem(
                          stepNumber: step.stepNumber,
                          title: step.title,
                          description: step.description,
                          primaryGreen: _primaryGreen,
                          isLast: index == systemSteps.length - 1,
                        );
                      }),
                    ),

                    const SizedBox(height: 30),

                    //Benefits
                    Text(
                      "Benefits of EcoSense",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Column(
                      children: appBenefits.map((benefit){
                        return BenefitsListItem(
                          title: benefit.title,
                          description: benefit.description,
                          imagePath: benefit.imagePath,
                          bgColor: benefit.bgColor,
                        );
                      }).toList(),
                    ),
                  ],
                ),
            )
          ],
        ),
      )),

      // Logic to select guest user or login user to show the footer
      bottomNavigationBar: AppBottomNav(
        isGuest: effectiveIsGuest,
        selectedIndex: _selectedIndex,
        primaryGreen: _primaryGreen,
      ),
    );
  }
}