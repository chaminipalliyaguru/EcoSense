import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnapDataTable extends StatelessWidget {
  final bool isEditing;
  final List<TextEditingController> smokeControllers;
  final List<TextEditingController> rpmControllers;
  final List<TextEditingController> accControllers;
  final List<double> smokeDensities;
  final List<int> rpms;
  final List<double> accelerationTimes;
  final double avgSmokeDensity;
  final double avgRpm;
  final double avgAccelerationTime;
  final VoidCallback onEditToggle;
  final Color primaryGreen;

  const SnapDataTable({
    super.key,
    required this.isEditing,
    required this.smokeControllers,
    required this.rpmControllers,
    required this.accControllers,
    required this.smokeDensities,
    required this.rpms,
    required this.accelerationTimes,
    required this.avgSmokeDensity,
    required this.avgRpm,
    required this.avgAccelerationTime,
    required this.onEditToggle,
    required this.primaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Snap no.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Smoke\nDensity(K-1/m)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'RPM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Acceleration\nTime',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit button
                SizedBox(
                  width: 36.w,
                  child: GestureDetector(
                    onTap: onEditToggle,
                    child: Center(
                      child: Icon(
                        isEditing ? Icons.close : Icons.edit,
                        size: 24.sp,
                        color: isEditing ? Colors.red : primaryGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Divider(height: 1.h, color: Colors.grey.shade200),

          // Snap Rows
          ...List.generate(3, (index) => _buildTableRow(index)),

          Divider(height: 1.h, color: Colors.grey.shade200),

          // Average Row
          _buildAverageRow(),
        ],
      ),
    );
  }

  Widget _buildTableRow(int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: isEditing ? 8.h : 14.h),
          child: Row(
            children: [
              // Snap no
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              
              // Smoke Density
              Expanded(
                flex: 3,
                child: Center(
                  child: isEditing
                      ? _buildTableCellField(
                          controller: smokeControllers[index],
                          isDouble: true,
                          hint: '0.00',
                        )
                      : Text(
                          smokeDensities[index].toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ),

              // RPM
              Expanded(
                flex: 2,
                child: Center(
                  child: isEditing
                      ? _buildTableCellField(
                          controller: rpmControllers[index],
                          isDouble: false,
                          hint: '0',
                        )
                      : Text(
                          rpms[index].toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ),

              // Acceleration Time
              Expanded(
                flex: 3,
                child: Center(
                  child: isEditing
                      ? _buildTableCellField(
                          controller: accControllers[index],
                          isDouble: true,
                          hint: '0.00',
                        )
                      : Text(
                          accelerationTimes[index].toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ),
              // Dummy space for alignment matching header Edit icon width
              SizedBox(width: 36.w),
            ],
          ),
        ),
        if (index < 2) Divider(height: 1.h, color: Colors.grey.shade100),
      ],
    );
  }

  Widget _buildTableCellField({
    required TextEditingController controller,
    required bool isDouble,
    required String hint,
  }) {
    return Container(
      height: 34.h.clamp(30.0, 50.0),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: isDouble),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade50,
          errorStyle: const TextStyle(fontSize: 0, height: 0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryGreen, width: 1.w),
            borderRadius: BorderRadius.circular(6.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.w),
            borderRadius: BorderRadius.circular(6.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300, width: 1.w),
            borderRadius: BorderRadius.circular(6.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.w),
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return '';
          if (isDouble) {
            final val = double.tryParse(value);
            if (val == null || val < 0) return '';
          } else {
            final val = int.tryParse(value);
            if (val == null || val < 0) return '';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildAverageRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      child: Row(
        children: [
          // Average Label
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Average',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          
          // Average Smoke Density
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                avgSmokeDensity.toStringAsFixed(3),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Average RPM
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                avgRpm.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // Average Acceleration Time
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                avgAccelerationTime.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          
          // Spacer matching the edit icon size
          SizedBox(width: 36.w),
        ],
      ),
    );
  }
}

class TinyChartIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1.0;
    
    // Draw tiny grid lines
    canvas.drawLine(Offset(0, size.height / 3), Offset(size.width, size.height / 3), gridPaint);
    canvas.drawLine(Offset(0, 2 * size.height / 3), Offset(size.width, 2 * size.height / 3), gridPaint);
    canvas.drawLine(Offset(size.width / 3, 0), Offset(size.width / 3, size.height), gridPaint);
    canvas.drawLine(Offset(2 * size.width / 3, 0), Offset(2 * size.width / 3, size.height), gridPaint);

    final linePaint = Paint()
      ..color = const Color(0xFF3A7D44)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(2.w, size.height - 4.h)
      ..lineTo(size.width * 0.4, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.6)
      ..lineTo(size.width - 2.w, size.height * 0.2);

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
