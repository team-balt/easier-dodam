import 'package:flutter/material.dart';

class OutSleepingPresetItem extends StatelessWidget {
  final String title;
  final String reason;
  final int duration;
  final Function() onTrashClick;

  const OutSleepingPresetItem({
    super.key,
    required this.title,
    required this.reason,
    required this.duration,
    required this.onTrashClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "사유: $reason",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "오늘부터 $duration일 동안",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 삭제 버튼
          InkWell(
            onTap: onTrashClick,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
