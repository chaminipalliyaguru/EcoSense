import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../report_results/pass_report_screen.dart';
import '../report_results/fail_report_screen.dart';
import 'widgets/certificate_info_card.dart';
import 'widgets/snap_data_table.dart';
import 'widgets/smoke_opacity_chart.dart';
import 'widgets/rpm_variations_chart.dart';

class EditDetailsScreen extends StatefulWidget {
  final bool isPass;
  final bool isFromResults;

  const EditDetailsScreen({
    super.key,
    this.isPass = true,
    this.isFromResults = false,
  });

  @override
  State<EditDetailsScreen> createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final Color _primaryGreen = const Color(0xFF3A7D44);
  final Color _backgroundColor = const Color(0xFFF1F5F9);
  
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Data state
  final String _certificateNo = "CL24-1319765";
  final String _dateOfIssue = "27-05-2025";
  
  final List<double> _smokeDensities = [0.41, 0.44, 0.45];
  final List<int> _rpms = [3200, 3418, 3315];
  final List<double> _accelerationTimes = [0.84, 0.72, 0.78];

  // Controllers for editing
  late List<TextEditingController> _smokeControllers;
  late List<TextEditingController> _rpmControllers;
  late List<TextEditingController> _accControllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _smokeControllers = List.generate(
      3, (i) => TextEditingController(text: _smokeDensities[i].toStringAsFixed(2))
    );
    _rpmControllers = List.generate(
      3, (i) => TextEditingController(text: _rpms[i].toString())
    );
    _accControllers = List.generate(
      3, (i) => TextEditingController(text: _accelerationTimes[i].toStringAsFixed(2))
    );
  }

  @override
  void dispose() {
    for (var c in _smokeControllers) {
      c.dispose();
    }
    for (var c in _rpmControllers) {
      c.dispose();
    }
    for (var c in _accControllers) {
      c.dispose();
    }
    super.dispose();
  }

  double get _avgSmokeDensity {
    return _smokeDensities.reduce((a, b) => a + b) / _smokeDensities.length;
  }

  double get _avgRpm {
    return _rpms.reduce((a, b) => a + b) / _rpms.length;
  }

  double get _avgAccelerationTime {
    return _accelerationTimes.reduce((a, b) => a + b) / _accelerationTimes.length;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        for (int i = 0; i < 3; i++) {
          _smokeDensities[i] = double.tryParse(_smokeControllers[i].text) ?? _smokeDensities[i];
          _rpms[i] = int.tryParse(_rpmControllers[i].text) ?? _rpms[i];
          _accelerationTimes[i] = double.tryParse(_accControllers[i].text) ?? _accelerationTimes[i];
        }
        _isEditing = false;
      });
    }
  }

  void _cancelChanges() {
    setState(() {
      _initControllers();
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Emission Report Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Certificate Card
                CertificateInfoCard(
                  certificateNo: _certificateNo,
                  dateOfIssue: _dateOfIssue,
                ),
                
                SizedBox(height: 20.h),
                
                // Snap Data Header
                _buildSectionHeader(
                  title: 'Snap Data',
                  leading: _buildSnapDataIcon(),
                ),
                
                SizedBox(height: 10.h),
                
                // Snap Data Table
                SnapDataTable(
                  isEditing: _isEditing,
                  smokeControllers: _smokeControllers,
                  rpmControllers: _rpmControllers,
                  accControllers: _accControllers,
                  smokeDensities: _smokeDensities,
                  rpms: _rpms,
                  accelerationTimes: _accelerationTimes,
                  avgSmokeDensity: _avgSmokeDensity,
                  avgRpm: _avgRpm,
                  avgAccelerationTime: _avgAccelerationTime,
                  onEditToggle: () {
                    setState(() {
                      if (_isEditing) {
                        _cancelChanges();
                      } else {
                        _isEditing = true;
                      }
                    });
                  },
                  primaryGreen: _primaryGreen,
                ),
                
                SizedBox(height: 20.h),
                
                // Emission Analysis Header
                _buildSectionHeader(title: 'Emission Analysis'),
                
                SizedBox(height: 10.h),
                
                // Smoke Opacity Chart
                SmokeOpacityChart(
                  smokeDensities: _smokeDensities,
                  avgSmokeDensity: _avgSmokeDensity,
                  primaryGreen: _primaryGreen,
                ),
                
                SizedBox(height: 14.h),
                
                // RPM Variations Chart
                RpmVariationsChart(
                  rpms: _rpms,
                ),
                
                SizedBox(height: 24.h),
                
                // Confirm & Continue Button / Edit actions
                _buildBottomButtons(),
                
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, Widget? leading}) {
    return Row(
      children: [
        if (leading != null) ...[
          leading,
          SizedBox(width: 8.w),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildSnapDataIcon() {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.w),
        borderRadius: BorderRadius.circular(4.r),
        color: Colors.white,
      ),
      child: CustomPaint(
        painter: TinyChartIconPainter(),
      ),
    );
  }

  Widget _buildBottomButtons() {
    if (_isEditing) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: OutlinedButton(
                onPressed: _cancelChanges,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                ),
                child: Text(
                  'Save Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: () {
          if (widget.isFromResults) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => widget.isPass 
                    ? const PassReportScreen() 
                    : const FailReportScreen(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryGreen,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.r),
          ),
        ),
        child: Text(
          'Confirm & Continue',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
