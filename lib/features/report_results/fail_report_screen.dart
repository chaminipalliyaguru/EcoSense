import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/app_bottom_nav.dart';
import '../Scan_upload_Report/scan_report_screen.dart';
import '../history/history_screen.dart';
import 'widgets/result_status_indicator.dart';
import 'widgets/result_info_card.dart';
import 'widgets/view_details_button.dart';
import '../EditDetails/edit_details_screen.dart';
import '../../data/user_session.dart';
import '../guestuser/guest_user_home_page.dart';
import '../home/home_screen_signup_login.dart';

class FailReportScreen extends StatefulWidget {
  final Map<String, dynamic> predictionResult;

  const FailReportScreen({
    super.key,
    required this.predictionResult,
  });

  @override
  State<FailReportScreen> createState() => _FailReportScreenState();
}

class _FailReportScreenState extends State<FailReportScreen> {
  int _selectedIndex = 1;
  final Color _primaryGreen = const Color(0xFF5A805E);
  bool _isGuest = false;

  // ---- Parsed JSON convenience getters ----
  Map<String, dynamic> get _layer2 =>
      (widget.predictionResult['layer2_pattern'] as Map?)?.cast<String, dynamic>() ?? {};

  Map<String, dynamic> get _lightgbm =>
      ((widget.predictionResult['layer1'] as Map?)?['lightgbm'] as Map?)?.cast<String, dynamic>() ?? {};

  Map<String, dynamic> get _aiExplanation =>
      (_lightgbm['ai_explanation'] as Map?)?.cast<String, dynamic>() ?? {};

  Map<String, dynamic> get _rule =>
      (widget.predictionResult['rule'] as Map?)?.cast<String, dynamic>() ?? {};

  List<String> get _diagnosticReasons =>
      (_layer2['diagnostic_reasons'] as List?)?.map((e) => _prettify(e.toString())).toList() ?? [];

  List<String> get _recommendations =>
      (_layer2['recommendations'] as String? ?? '')
          .split('|')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

  List<String> get _possibleCauses =>
      (_aiExplanation['possible_causes'] as List?)?.map((e) => e.toString()).toList() ?? [];

  List<String> get _repairSteps =>
      (_aiExplanation['repair_steps'] as List?)?.map((e) => e.toString()).toList() ?? [];

  List<String> get _prevention =>
      (_aiExplanation['prevention'] as List?)?.map((e) => e.toString()).toList() ?? [];

  List<Map<String, dynamic>> get _videos =>
      (_aiExplanation['youtube_videos'] as List?)
          ?.map((e) => (e as Map).cast<String, dynamic>())
          .toList() ??
          [];

  String _prettify(String raw) => raw
      .split('_')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  bool get _isPass {
    final label = _lightgbm['predicted_label']?.toString().toUpperCase();
    final rulePass = _rule['rule_diesel_fail'] == false;
    return label == 'PASS' && rulePass;
  }

  @override
  void initState() {
    super.initState();
    _checkGuestStatus();
  }

  Future<void> _checkGuestStatus() async {
    final userData = await UserSession.getUser();
    final username = userData['username'] ?? '';
    if (mounted) {
      setState(() {
        _isGuest = username.isEmpty || username == 'Guest';
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

                if (_recommendations.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Recommendations',
                    content: _recommendations.map((r) => '•  $r').join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_possibleCauses.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Possible Causes',
                    content: _possibleCauses.map((r) => '•  $r').join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_repairSteps.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Repair Steps',
                    content: List.generate(
                      _repairSteps.length,
                          (i) => '${i + 1}. ${_repairSteps[i]}',
                    ).join('\n'),
                  ),
                  const SizedBox(height: 24),
                ],

                _buildQuickFactsRow(),
                const SizedBox(height: 24),

                if (_aiExplanation['can_drive'] != null) ...[
                  ResultInfoCard(
                    title: 'Can I Drive It?',
                    content: _aiExplanation['can_drive'].toString(),
                  ),
                  const SizedBox(height: 24),
                ],

                if (_prevention.isNotEmpty) ...[
                  ResultInfoCard(
                    title: 'Prevention',
                    content: _prevention.map((r) => '•  $r').join('\n'),
                  ),
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
          onPressed: () {},
        ),
      ],
    );
  }
}