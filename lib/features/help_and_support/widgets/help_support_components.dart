import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryGreen = Color(0xFF4A7B59);

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: primaryGreen,
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  const IconContainer({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: primaryGreen,
        size: 20.sp,
      ),
    );
  }
}

class QuestionIconContainer extends StatelessWidget {
  const QuestionIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Text(
        "?",
        style: TextStyle(
          color: primaryGreen,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SeparateExpandableCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String content;

  const SeparateExpandableCard({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  State<SeparateExpandableCard> createState() => _SeparateExpandableCardState();
}

class _SeparateExpandableCardState extends State<SeparateExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: _isExpanded ? 16.h : 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: _isExpanded ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.icon,
                color: primaryGreen,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 8.h),
                    Text(
                      widget.content,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupedExpandableTile extends StatefulWidget {
  final String title;
  final String content;

  const GroupedExpandableTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<GroupedExpandableTile> createState() => _GroupedExpandableTileState();
}

class _GroupedExpandableTileState extends State<GroupedExpandableTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: _isExpanded ? 12.h : 8.h),
        child: Row(
          crossAxisAlignment: _isExpanded ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            const QuestionIconContainer(),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: primaryGreen,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 8.h),
                    Text(
                      widget.content,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool showArrow;

  const ContactTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: IconContainer(icon: icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey.shade500,
        ),
      ),
      trailing: showArrow
          ? Icon(
              Icons.arrow_forward_ios,
              color: primaryGreen,
              size: 16.sp,
            )
          : null,
      onTap: () {},
    );
  }
}
