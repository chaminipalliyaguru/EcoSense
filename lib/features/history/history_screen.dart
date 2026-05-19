import 'package:flutter/material.dart';
import '../home/widgets/top_app_bar.dart';
import '../../widgets/app_bottom_nav.dart';

class HistoryScreen extends StatefulWidget {
  final bool isGuest;
  const HistoryScreen({super.key, this.isGuest = false});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedTab = 0;

  // ADD THESE
  int _selectedIndex = 1;

  bool get effectiveIsGuest => widget.isGuest;

  final Color _primaryGreen = const Color(0xFF4A7B59);

  final List<Map<String, dynamic>> scans = [
    {
      "plate": "CAO 3478",
      "date": "15 February 2026",
      "time": "10.30 AM",
      "status": "Passed",
      "color": Colors.green,
    },
    {
      "plate": "CAX 4748",
      "date": "25 December 2025",
      "time": "11.30 AM",
      "status": "Failed",
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        primaryGreen: _primaryGreen,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    const Text(
                      "History",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Filter Tabs
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          buildTab("All", 0),
                          buildTab("Passed", 1),
                          buildTab("Failed", 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Recent Scans",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        itemCount: scans.length,
                        itemBuilder: (context, index) {
                          final item = scans[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ScanCard(
                              plate: item["plate"],
                              date: item["date"],
                              time: item["time"],
                              status: item["status"],
                              color: item["color"],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: AppBottomNav(
        isGuest: effectiveIsGuest,
        selectedIndex: _selectedIndex,
        primaryGreen: _primaryGreen,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          }
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }

  Widget buildTab(String title, int index) {
    bool isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class ScanCard extends StatelessWidget {
  final String plate;
  final String date;
  final String time;
  final String status;
  final Color color;

  const ScanCard({
    super.key,
    required this.plate,
    required this.date,
    required this.time,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Car Icon
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(
              Icons.directions_car_outlined,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          // Make text section flexible
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plate,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),

                    Expanded(
                      child: Text(
                        date,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Arrow
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}