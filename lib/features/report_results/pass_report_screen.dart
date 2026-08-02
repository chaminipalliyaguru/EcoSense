import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'services/pdf_report_service.dart';
import '../../widgets/app_bottom_nav.dart';
import 'widgets/result_status_indicator.dart';
import 'widgets/result_info_card.dart';
import 'widgets/view_details_button.dart';

import '../../data/user_session.dart';
import '../guestuser/guest_user_home_page.dart';
import '../home/home_screen_signup_login.dart';


class PassReportScreen extends StatefulWidget {

  final Map<String, dynamic> predictionResult;

  const PassReportScreen({
    super.key,
    required this.predictionResult,
  });


  @override
  State<PassReportScreen> createState() =>
      _PassReportScreenState();
}



class _PassReportScreenState extends State<PassReportScreen> {


  int _selectedIndex = 1;

  final Color _primaryGreen =
  const Color(0xFF5A805E);

  bool _isGuest = false;



  // ================= JSON PARSING =================


  Map<String,dynamic> get _layer2 {

    final data =
    widget.predictionResult['layer2_pattern'];

    if(data is Map){
      return Map<String,dynamic>.from(data);
    }

    return {};
  }



  Map<String,dynamic> get _lightgbm {

    final layer1 =
    widget.predictionResult['layer1'];

    if(layer1 is Map){

      final model =
      layer1['lightgbm'];

      if(model is Map){
        return Map<String,dynamic>.from(model);
      }
    }

    return {};
  }



  Map<String,dynamic> get _aiExplanation {

    final data =
    _lightgbm['ai_explanation'];

    if(data is Map){
      return Map<String,dynamic>.from(data);
    }

    return {};
  }




  List<String> get _diagnosticReasons {

    final data =
    _layer2['diagnostic_reasons'];

    if(data is List){

      return data
          .map((e)=>e.toString())
          .where((e)=>
      e.toLowerCase()!='none')
          .map(_prettify)
          .toList();

    }

    return [];
  }








  List<String> get _possibleCauses {

    final data =
    _aiExplanation['possible_causes'];

    if(data is List){

      return data
          .map((e)=>e.toString())
          .toList();

    }

    return [];
  }




  List<String> get _repairSteps {


    final data =
    _aiExplanation['repair_steps'];


    if(data is List){

      return data
          .map((e)=>e.toString())
          .toList();

    }

    return [];

  }





  List<String> get _prevention {


    final data =
    _aiExplanation['prevention'];


    if(data is List){

      return data
          .map((e)=>e.toString())
          .toList();

    }

    return [];

  }





  List<Map<String,dynamic>> get _videos {


    final data =
    _aiExplanation['youtube_videos'];


    if(data is List){

      return data
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .take(3)
          .toList();

    }


    return [];

  }





  bool get _isPass {
    final label = _lightgbm['predicted_label']?.toString().toUpperCase();
    final rule = widget.predictionResult['rule'];
    final rulePass = rule != null && rule['rule_diesel_fail'] == false;
    return label == 'PASS' && rulePass;
  }




  String _prettify(String text){

    return text
        .split('_')
        .map((word)=>
    word.isEmpty
        ? word
        :
    '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');

  }




  // ================= INIT =================


  @override
  void initState(){

    super.initState();

    _checkGuestStatus();

  }




  Future<void> _checkGuestStatus() async {


    final user =
    await UserSession.getUser();


    final username =
        user['username'] ?? '';



    if(mounted){

      setState((){

        _isGuest =
            username.isEmpty ||
                username=='Guest';

      });

    }

  }





  Future<void> _openVideo(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open video: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final summary = _aiExplanation['summary'] as String?;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              children: [
                ResultStatusIndicator(status: _isPass ? 'PASS' : 'FAIL', isPass: _isPass),
                const SizedBox(height: 30),

                if (summary != null && summary.isNotEmpty) ...[
                  ResultInfoCard(title: 'Summary', content: summary),
                  const SizedBox(height: 24),
                ],

                if (_diagnosticReasons.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Reasons',
                    content: _diagnosticReasons.map((r) => '•  $r').join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_possibleCauses.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Notes',
                    content: _possibleCauses.map((r) => '•  $r').join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_repairSteps.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Suggested Next Steps',
                    content: List.generate(
                      _repairSteps.length,
                          (i) => '${i + 1}. ${_repairSteps[i]}',
                    ).join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                /*
                _buildQuickFactsRow(),
                const SizedBox(height: 24),
                */

                /*
                if (_aiExplanation['can_drive'] != null) ...[
                  ResultInfoCard(
                    title: 'Can I Drive It?',
                    content: _aiExplanation['can_drive'].toString(),
                  ),
                  const SizedBox(height: 24),
                ],
                */

                if (_prevention.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Keep It Passing',
                    content: _prevention.map((r) => '•  $r').join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_videos.isNotEmpty) ...[
                  _buildVideosCard(),
                  const SizedBox(height: 24),
                ],

                const SizedBox(height: 16),
                ViewDetailsButton(
                  onPressed: () async {
                    final userData = await UserSession.getUser();
                    final username = userData['username'] ?? '';
                    if (username.isEmpty || username == 'Guest') {
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const GuestUserHomePage()),
                              (route) => false,
                        );
                      }
                    } else {
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreenSignupLogin()),
                              (route) => false,
                        );
                      }
                    }
                  },
                  backgroundColor: _primaryGreen,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        isGuest: _isGuest,
        selectedIndex: _selectedIndex,
        primaryGreen: _primaryGreen,
      ),
    );
  }

  // ---- Quick facts row: difficulty / cost / time ----
  Widget _buildQuickFactsRow() {
    final difficulty = _aiExplanation['repair_difficulty'] as String?;
    final cost = _aiExplanation['repair_cost_estimate'] as String?;
    final time = _aiExplanation['repair_time'] as String?;

    final facts = <Map<String, dynamic>>[
      if (difficulty != null) {'icon': Icons.build_circle_outlined, 'label': 'Difficulty', 'value': difficulty},
      if (cost != null) {'icon': Icons.attach_money_rounded, 'label': 'Est. Cost', 'value': cost},
      if (time != null) {'icon': Icons.schedule_rounded, 'label': 'Est. Time', 'value': time},
    ];

    if (facts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quick Facts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _primaryGreen,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...facts.map(
              (f) => Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _primaryGreen.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(f['icon'] as IconData, color: _primaryGreen, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f['label'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        f['value'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---- Related videos card ----
  Widget _buildVideosCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Helpful Videos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _primaryGreen,
            ),
          ),
          const SizedBox(height: 12),
          ..._videos.map((v) {
            final title = v['title']?.toString() ?? '';
            final channel = v['channel']?.toString() ?? '';
            final url = v['url']?.toString() ?? '';
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: url.isEmpty ? null : () => _openVideo(url),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _primaryGreen.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.play_arrow_rounded, color: _primaryGreen, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            channel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.open_in_new_rounded, size: 16, color: Colors.black38),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: _primaryGreen,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'View Report',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () async {
            final summary = _aiExplanation['summary'] as String? ?? '';
            final canDrive = _aiExplanation['can_drive']?.toString();
            await PdfReportService.generateAndSharePdf(
              predictionResult: widget.predictionResult,
              isPass: _isPass,
              summary: summary,
              diagnosticReasons: _diagnosticReasons,
              possibleCauses: _possibleCauses,
              repairSteps: _repairSteps,
              canDrive: canDrive,
              prevention: _prevention,
            );
          },
        ),
      ],
    );
  }
}