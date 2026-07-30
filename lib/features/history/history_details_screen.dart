import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const HistoryDetailsScreen({super.key, required this.item});

  final Color _primaryGreen = const Color(0xFF4A7B59);

  String _formatDate(String isoString) {
    try {
      // Backend usually sends UTC without 'Z'. Append 'Z' to treat as UTC, 
      // then add 5:30 hours for Sri Lanka standard time.
      final utcString = isoString.endsWith('Z') ? isoString : '${isoString}Z';
      final utcDate = DateTime.parse(utcString);
      final slDate = utcDate.add(const Duration(hours: 5, minutes: 30));
      return DateFormat('dd MMMM yyyy, hh:mm a').format(slDate);
    } catch (e) {
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehRegNos = item["veh_reg_nos"] as List<dynamic>? ?? [];
    final plate = vehRegNos.isNotEmpty ? vehRegNos.first.toString() : "Unknown";
    final createdAt = item["created_at"]?.toString() ?? "";
    final dateStr = _formatDate(createdAt);

    final results = item["results"] as List<dynamic>? ?? [];
    Map<String, dynamic>? firstResult;
    if (results.isNotEmpty) {
      firstResult = results.first as Map<String, dynamic>;
    }

    final layer1 = firstResult?["layer1"]?["lightgbm"] as Map<String, dynamic>?;
    final predictedLabel = layer1?["predicted_label"]?.toString() ?? "UNKNOWN";
    final aiExplanation = layer1?["ai_explanation"] as Map<String, dynamic>?;
    final summary = aiExplanation?["summary"]?.toString();
    final possibleCauses = aiExplanation?["possible_causes"] as List<dynamic>? ?? [];
    final repairSteps = aiExplanation?["repair_steps"] as List<dynamic>? ?? [];

    final layer2 = firstResult?["layer2_pattern"] as Map<String, dynamic>?;
    final recommendations = layer2?["recommendations"]?.toString();

    final records = item["records"] as List<dynamic>? ?? [];
    Map<String, dynamic>? firstRecord;
    if (records.isNotEmpty) {
      firstRecord = records.first as Map<String, dynamic>;
    }

    final vehMake = firstRecord?["VehMake"]?.toString() ?? "N/A";
    final vehClass = firstRecord?["VehClass"]?.toString() ?? "N/A";
    final vehFuelType = firstRecord?["VehFuelType"]?.toString() ?? "N/A";
    final vehManuYear = firstRecord?["VehManuYear"]?.toString() ?? "N/A";

    final isPass = predictedLabel.toUpperCase() != "FAIL";
    final statusColor = isPass ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text("History Details", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and Date Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plate,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(dateStr, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      predictedLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Vehicle Details
            const Text(
              "Vehicle Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildDetailRow("Make", vehMake),
                  const Divider(),
                  _buildDetailRow("Class", vehClass),
                  const Divider(),
                  _buildDetailRow("Fuel Type", vehFuelType),
                  const Divider(),
                  _buildDetailRow("Manufacture Year", vehManuYear),
                ],
              ),
            ),

            const SizedBox(height: 24),

            if (summary != null) ...[
              const Text(
                "Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _primaryGreen.withOpacity(0.3)),
                ),
                child: Text(
                  summary,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
              const SizedBox(height: 24),
            ],

            if (possibleCauses.isNotEmpty) ...[
              const Text(
                "Possible Causes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildListContainer(possibleCauses),
              const SizedBox(height: 24),
            ],

            if (repairSteps.isNotEmpty) ...[
              const Text(
                "Repair Steps",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildListContainer(repairSteps),
              const SizedBox(height: 24),
            ],

            if (recommendations != null && recommendations.isNotEmpty) ...[
              const Text(
                "Recommendations",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  recommendations.replaceAll(" | ", "\n\n"),
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildListContainer(List<dynamic> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("• ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    item.toString(),
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
