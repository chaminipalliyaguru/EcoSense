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

    // Color Palette
    final primaryBrand = PdfColor.fromHex('#1B4D3E');
    final accentBrand = PdfColor.fromHex('#2D6A4F');
    final cardBg = PdfColor.fromHex('#F8FAFC');
    final cardBorder = PdfColor.fromHex('#E2E8F0');
    final textDark = PdfColor.fromHex('#0F172A');
    final textMuted = PdfColor.fromHex('#475569');

    final statusColor = isPass ? PdfColor.fromHex('#15803D') : PdfColor.fromHex('#B91C1C');
    final statusBg = isPass ? PdfColor.fromHex('#F0FDF4') : PdfColor.fromHex('#FEF2F2');
    final statusBorder = isPass ? PdfColor.fromHex('#BBF7D0') : PdfColor.fromHex('#FECACA');
    final statusText = isPass ? 'PASS' : 'FAIL';

    final now = DateTime.now();
    final dateStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final reportRef = 'ES-${now.millisecondsSinceEpoch.toString().substring(5)}';

    // 2. Build PDF Document Layout
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) {
          return [
            // --- BRAND HEADER BAR ---
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 12),
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.grey300, width: 1),
                ),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      if (logoImage != null)
                        pw.Container(
                          margin: const pw.EdgeInsets.only(right: 12),
                          child: pw.Image(logoImage, width: 45, height: 45),
                        ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'EcoSense',
                            style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: primaryBrand,
                            ),
                          ),
                          pw.Text(
                            'Smart Vehicle Diagnostics',
                            style: pw.TextStyle(
                              fontSize: 9,
                              color: textMuted,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'EMISSION DIAGNOSTIC REPORT',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: textDark,
                          letterSpacing: 0.5,
                        ),
                      ),
                      pw.SizedBox(height: 3),
                      pw.Text(
                        'Ref: #$reportRef',
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: accentBrand,
                        ),
                      ),
                      pw.SizedBox(height: 2),
                      pw.Text(
                        'Date: $dateStr',
                        style: pw.TextStyle(
                          fontSize: 8,
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // --- HERO STATUS BANNER ---
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                color: statusBg,
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: statusBorder, width: 1.5),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'EMISSION TEST RESULT',
                        style: pw.TextStyle(
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                          color: textMuted,
                          letterSpacing: 0.8,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        isPass
                            ? 'Vehicle complies with emission safety standards.'
                            : 'Vehicle failed emission check. Inspection required.',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: textDark,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: pw.BoxDecoration(
                      color: statusColor,
                      borderRadius: pw.BorderRadius.circular(20),
                    ),
                    child: pw.Text(
                      statusText,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 16),

            // --- SUMMARY SECTION ---
            if (summary.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Executive Summary',
                accentColor: primaryBrand,
                child: pw.Text(
                  summary,
                  style: pw.TextStyle(
                    fontSize: 9.5,
                    color: textDark,
                    lineSpacing: 3,
                  ),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- DIAGNOSTIC REASONS ---
            if (diagnosticReasons.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Diagnostic Observations',
                accentColor: isPass ? statusColor : PdfColor.fromHex('#D97706'),
                child: pw.Column(
                  children: diagnosticReasons.map((reason) {
                    return _buildBulletItem(reason, textDark, accentColor: isPass ? statusColor : PdfColor.fromHex('#D97706'));
                  }).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- RECOMMENDATIONS ---
            if (recommendations.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Recommendations',
                accentColor: primaryBrand,
                child: pw.Column(
                  children: recommendations.map((rec) {
                    return _buildBulletItem(rec, textDark, accentColor: primaryBrand);
                  }).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- POSSIBLE CAUSES / NOTES ---
            if (possibleCauses.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Possible Causes & Insights',
                accentColor: PdfColor.fromHex('#2563EB'),
                child: pw.Column(
                  children: possibleCauses.map((cause) {
                    return _buildBulletItem(cause, textDark, accentColor: PdfColor.fromHex('#2563EB'));
                  }).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- SUGGESTED REPAIR STEPS ---
            if (repairSteps.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Suggested Repair Steps',
                accentColor: primaryBrand,
                child: pw.Column(
                  children: repairSteps.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final step = entry.value;
                    return pw.Padding(
                      padding: const pw.EdgeInsets.only(bottom: 6),
                      child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 16,
                            height: 16,
                            margin: const pw.EdgeInsets.only(right: 8, top: 1),
                            decoration: pw.BoxDecoration(
                              color: accentBrand,
                              shape: pw.BoxShape.circle,
                            ),
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              '$index',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                          ),
                          pw.Expanded(
                            child: pw.Text(
                              step,
                              style: pw.TextStyle(
                                fontSize: 9.5,
                                color: textDark,
                                lineSpacing: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- CAN I DRIVE IT? ---
            if (canDrive != null && canDrive.isNotEmpty) ...[
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: isPass ? PdfColor.fromHex('#F0FDF4') : PdfColor.fromHex('#FFFBEB'),
                  borderRadius: pw.BorderRadius.circular(6),
                  border: pw.Border.all(
                    color: isPass ? PdfColor.fromHex('#86EFAC') : PdfColor.fromHex('#FDE68A'),
                    width: 1,
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 8,
                          height: 8,
                          margin: const pw.EdgeInsets.only(right: 6),
                          decoration: pw.BoxDecoration(
                            color: isPass ? PdfColor.fromHex('#16A34A') : PdfColor.fromHex('#D97706'),
                            shape: pw.BoxShape.circle,
                          ),
                        ),
                        pw.Text(
                          'DRIVING ADVISORY: CAN I DRIVE IT?',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: isPass ? PdfColor.fromHex('#15803D') : PdfColor.fromHex('#B45309'),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      canDrive,
                      style: pw.TextStyle(
                        fontSize: 9.5,
                        color: textDark,
                        lineSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 12),
            ],

            // --- PREVENTION & MAINTENANCE TIPS ---
            if (prevention.isNotEmpty) ...[
              _buildSectionCard(
                title: 'Prevention & Maintenance Tips',
                accentColor: PdfColor.fromHex('#0D9488'),
                child: pw.Column(
                  children: prevention.map((tip) {
                    return _buildBulletItem(tip, textDark, accentColor: PdfColor.fromHex('#0D9488'));
                  }).toList(),
                ),
              ),
              pw.SizedBox(height: 12),
            ],
          ];
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(thickness: 0.5, color: PdfColors.grey300),
              pw.SizedBox(height: 4),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Generated by EcoSense Vehicle Emission Diagnostics',
                    style: pw.TextStyle(
                      fontSize: 8,
                      color: textMuted,
                    ),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                      color: textMuted,
                    ),
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

  static pw.Widget _buildSectionCard({
    required String title,
    required pw.Widget child,
    required PdfColor accentColor,
  }) {
    final cardBg = PdfColor.fromHex('#F8FAFC');
    final cardBorder = PdfColor.fromHex('#E2E8F0');
    final textDark = PdfColor.fromHex('#0F172A');

    return pw.Container(
      width: double.infinity,
      decoration: pw.BoxDecoration(
        color: cardBg,
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: cardBorder, width: 1),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(color: accentColor, width: 4),
                bottom: pw.BorderSide(color: cardBorder, width: 0.5),
              ),
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 10.5,
                fontWeight: pw.FontWeight.bold,
                color: textDark,
                letterSpacing: 0.3,
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(12),
            child: child,
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildBulletItem(String text, PdfColor textColor, {required PdfColor accentColor}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 4,
            height: 4,
            margin: const pw.EdgeInsets.only(right: 8, top: 4),
            decoration: pw.BoxDecoration(
              color: accentColor,
              shape: pw.BoxShape.circle,
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              text,
              style: pw.TextStyle(
                fontSize: 9.5,
                color: textColor,
                lineSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
