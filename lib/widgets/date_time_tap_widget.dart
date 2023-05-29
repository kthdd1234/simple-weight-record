import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/components/space/spaceHeight.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';
import 'package:flutter_app_weight_management/utils/function.dart';

class TimeChipWidget extends StatelessWidget {
  TimeChipWidget({
    super.key,
    required this.id,
    required this.onTap,
    required this.time,
  });

  String id;
  DateTime time;
  Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    setTimeText(DateTime time) {
      String text = timeToString(time);

      if (text.contains('AM')) {
        return text.replaceFirst(RegExp(r'AM'), '오전');
      }

      return text.replaceFirst(RegExp(r'PM'), '오후');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            SpaceHeight(height: smallSpace),
            InkWell(
              onTap: () => onTap(id),
              child: Container(
                decoration: const BoxDecoration(
                  color: dialogBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    setTimeText(time),
                    style: const TextStyle(
                      color: buttonBackgroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}