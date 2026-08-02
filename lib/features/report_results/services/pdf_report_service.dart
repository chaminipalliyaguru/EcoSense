import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfReportService {
  static Future<void> generateAndSharePdf({
    required Map<String, dynamic> predictionResult,
    required bool isPass,
    required String summary,
    required List<String> diagnosticReasons,
    List<String> recommendations = const [],
    required List<String> possibleCauses,
    required List<String> repairSteps,
    String? canDrive,
    required List<String> prevention,
  }) async {
    final pdf = pw.Document();

    // 1. Load EcoSense Logo from assets
    pw.MemoryImage? logoImage;
    try {
      final ByteData logoByteData = await rootBundle.load('assets/logo.png');
      final Uint8List logoBytes = logoByteData.buffer.asUint8List();
      logoImage = pw.MemoryImage(logoBytes);
    } catch (_) {
      // Fallback if logo loading fails
    }

    final statusColor = isPass ? PdfColors.green700 : PdfColors.red700;
    final statusBg = isPass ? PdfColors.green50 : PdfColors.red50;
    final statusText = isPass ? 'PASS' : 'FAIL';

    final nowStr = DateTime.now().toString().split('.')[0];

    // 2. Build PDF Document Layout
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // --- HEADER ---
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                if (logoImage != null)
                  pw.Image(logoImage, width: 70, height: 70)
                else
                  pw.Text(
                    'EcoSense',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.green800,
                    ),
                  ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Diagnostic Report',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blueGrey900,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Date: $nowStr',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Divider(thickness: 1.5, color: PdfColors.grey300),
            pw.SizedBox(height: 16),

            // --- STATUS BANNER ---
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: pw.BoxDecoration(
                color: statusBg,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: statusColor, width: 1.5),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'STATUS: ',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey800,
                    ),
                  ),
                  pw.Text(
                    statusText,
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // --- SUMMARY SECTION ---
            if (summary.isNotEmpty) ...[
              _buildPdfSectionTitle('Summary'),
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  summary,
                  style: const pw.TextStyle(fontSize: 10, lineSpacing: 3),
                ),
              ),
              pw.SizedBox(height: 16),
            ],

            // --- DIAGNOSTIC REASONS ---
            if (diagnosticReasons.isNotEmpty) ...[
              _buildPdfSectionTitle('Diagnostic Reasons'),
              ...diagnosticReasons.map(
                (r) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Bullet(
                    text: r,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.SizedBox(height: 14),
            ],

            // --- RECOMMENDATIONS ---
            if (recommendations.isNotEmpty) ...[
              _buildPdfSectionTitle('Recommendations'),
              ...recommendations.map(
                (r) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Bullet(
                    text: r,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.SizedBox(height: 14),
            ],

            // --- POSSIBLE CAUSES / NOTES ---
            if (possibleCauses.isNotEmpty) ...[
              _buildPdfSectionTitle('Possible Causes / Notes'),
              ...possibleCauses.map(
                (c) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Bullet(
                    text: c,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.SizedBox(height: 14),
            ],

            // --- SUGGESTED REPAIR STEPS ---
            if (repairSteps.isNotEmpty) ...[
              _buildPdfSectionTitle('Suggested Next Steps'),
              ...repairSteps.asMap().entries.map(
                (entry) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Text(
                    '${entry.key + 1}. ${entry.value}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.SizedBox(height: 14),
            ],

            // --- CAN I DRIVE IT? ---
            if (canDrive != null && canDrive.isNotEmpty) ...[
              _buildPdfSectionTitle('Can I Drive It?'),
              pw.Text(
                canDrive,
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 14),
            ],

            // --- KEEP IT PASSING / PREVENTION ---
            if (prevention.isNotEmpty) ...[
              _buildPdfSectionTitle('Prevention & Maintenance Tips'),
              ...prevention.map(
                (p) => pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 4),
                  child: pw.Bullet(
                    text: p,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.SizedBox(height: 14),
            ],
          ];
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(thickness: 0.5, color: PdfColors.grey400),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Generated by EcoSense Vehicle Diagnostics',
                    style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    // 3. Trigger native share modal
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'EcoSense_Diagnostic_Report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  static pw.Widget _buildPdfSectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6, top: 4),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blueGrey800,
        ),
      ),
    );
  }
}
