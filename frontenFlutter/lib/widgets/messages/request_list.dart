import 'package:flutter/material.dart';
import '../../models/user_summary.dart';
import 'request_avatar.dart';

class RequestList extends StatelessWidget {
  final List<UserSummary> requests;
  final void Function(UserSummary user)? onTap;
  const RequestList({super.key, required this.requests, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (c, i) => RequestAvatar(
          user: requests[i],
          onTap: onTap != null ? () => onTap!(requests[i]) : null,
        ),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: requests.length,
      ),
    );
  }
}
