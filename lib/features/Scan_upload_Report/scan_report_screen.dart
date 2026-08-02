import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/report_validator.dart';

// Extracted Widgets
import 'widgets/scan_app_bar.dart';
import 'widgets/scan_frame.dart';
import 'widgets/scan_bottom_bar.dart';
import 'widgets/scan_overlay.dart';
import 'widgets/image_preview_overlay.dart';
import '../Report_Analyzing/report_analyzing_screen.dart';
import '../../main.dart';

class ScanReportScreen extends StatefulWidget {
  const ScanReportScreen({super.key});

  @override
  State<ScanReportScreen> createState() => _ScanReportScreenState();
}

class _ScanReportScreenState extends State<ScanReportScreen>
    with SingleTickerProviderStateMixin, RouteAware, WidgetsBindingObserver {
  final Color _primaryGreen = const Color(0xFF3A7D44);
  final ImagePicker _imagePicker = ImagePicker();

  // Camera State
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraReady = false;
  bool _permissionDenied = false;
  int _currentCameraIndex = 0;

  // Selection State
  File? _selectedImage;

  // Animation State
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _setupSystemUI();
    _initAnimations();
    _initCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _cameraController?.dispose();
      if (mounted) {
        setState(() {
          _isCameraReady = false;
        });
      }
    } else if (state == AppLifecycleState.resumed && _cameras.isNotEmpty) {
      _startCamera(_cameras[_currentCameraIndex]);
    }
  }

  void _setupSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void _initAnimations() {
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      if (mounted) setState(() => _permissionDenied = true);
      return;
    }

    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        if (mounted) setState(() => _permissionDenied = true);
        return;
      }

      int backCameraIndex = _cameras
          .indexWhere((cam) => cam.lensDirection == CameraLensDirection.back);
      _currentCameraIndex = backCameraIndex != -1 ? backCameraIndex : 0;

      await _startCamera(_cameras[_currentCameraIndex]);
    } catch (e) {
      debugPrint('Camera initialization error: $e');
      if (mounted) setState(() => _permissionDenied = true);
    }
  }

  Future<void> _startCamera(CameraDescription camera) async {
    await _cameraController?.dispose();

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      await controller.setFlashMode(FlashMode.off);
      if (!mounted) return;

      setState(() {
        _cameraController = controller;
        _isCameraReady = true;
      });
    } catch (e) {
      debugPrint('Camera start error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting camera: $e')),
        );
      }
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No other camera available')),
      );
      return;
    }

    final currentDir = _cameras[_currentCameraIndex].lensDirection;
    final targetDir = currentDir == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    int targetIndex =
        _cameras.indexWhere((cam) => cam.lensDirection == targetDir);

    if (targetIndex == -1) {
      targetIndex = (_currentCameraIndex + 1) % _cameras.length;
    }

    _currentCameraIndex = targetIndex;
    _selectedImage = null;

    if (mounted) setState(() => _isCameraReady = false);
    await _startCamera(_cameras[_currentCameraIndex]);
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    try {
      final XFile photo = await _cameraController!.takePicture();
      if (!mounted) return;

      setState(() {
        _selectedImage = File(photo.path);
      });
    } catch (e) {
      debugPrint('Capture error: $e');
    }
  }

  Future<void> _pickPhotoFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
      );

      if (image == null) return;

      if (mounted) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Gallery picker error: $e');
    }
  }

  Future<void> _validateAndContinue() async {
    if (_selectedImage == null) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Validate using your backend logic
    final result = await ReportValidator.validate(_selectedImage!);

    if (!mounted) return;

    Navigator.pop(context); // close loading dialog

    // If NOT valid → show error dialog
    if (!result.isValid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Invalid Report",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "The image you captured does not appear to be a valid emission report. "
                      "Please retake the photo clearly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: const Text(
                      "Retake Photo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      return; // IMPORTANT: stop here
    }

    // If valid → go to analyzing screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportAnalyzingScreen(
          imageFile: _selectedImage!,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _scanLineController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ScanAppBar(
            backgroundColor: _primaryGreen,
            title: 'Scan Report',
            onBack: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: _permissionDenied
                ? _buildPermissionDeniedUI()
                : _buildViewfinderStack(),
          ),
          if (_selectedImage == null)
            ScanBottomBar(
              primaryGreen: _primaryGreen,
              onGalleryTap: _pickPhotoFromGallery,
              onCaptureTap: _capturePhoto,
              onFlipTap: _flipCamera,
            ),
        ],
      ),
    );
  }

  Widget _buildViewfinderStack() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final frameW = constraints.maxWidth * 0.95;
        final frameH = constraints.maxHeight * 0.94;

        return Stack(
          children: [
            _buildContentLayer(),
            ScanOverlay(frameWidth: frameW, frameHeight: frameH),
            _buildInstructionBadge(),
            Center(
              child: ScanFrame(
                width: frameW,
                height: frameH,
                scanAnimation: _scanLineAnimation,
                cornerColor: _primaryGreen,
                hintText: 'Align the report within the frame',
                showScanLine: false,
              ),
            ),
            if (_selectedImage != null)
              ImagePreviewOverlay(
                imageFile: _selectedImage!,
                scanAnimation: _scanLineAnimation,
                primaryColor: _primaryGreen,
                onRetake: () {
                  if (!mounted) return;
                  setState(() {
                    _selectedImage = null;
                  });
                },
                onConfirm: () async {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);

                  await _validateAndContinue();
                },
              ),
          ],
        );
      },
    );
  }

  Widget _buildContentLayer() {
    if (_isCameraReady &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      return LayoutBuilder(
        builder: (context, constraints) {
          var cameraAspectRatio = _cameraController!.value.aspectRatio;
          if (constraints.maxHeight > constraints.maxWidth &&
              cameraAspectRatio > 1) {
            cameraAspectRatio = 1 / cameraAspectRatio;
          }
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth / cameraAspectRatio,
                  child: CameraPreview(_cameraController!),
                ),
              ),
            ),
          );
        },
      );
    }

    return Container(
      color: const Color(0xFF1A1A1A),
      child:
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  Widget _buildInstructionBadge() {
    return Positioned(
      top: 20.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Text(
            _selectedImage != null
                ? 'Image selected for analysis'
                : 'Align the report within the frame',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined,
              size: 64.sp, color: Colors.white.withValues(alpha: 0.4)),
          SizedBox(height: 16.h),
          Text('Camera permission required',
              style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => openAppSettings(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: Text('Open Settings',
                style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
