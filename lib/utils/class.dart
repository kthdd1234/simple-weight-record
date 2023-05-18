import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/model/user_info/user_info.dart';
import 'package:flutter_app_weight_management/utils/enum.dart';
import 'package:flutter_app_weight_management/utils/function.dart';

class UserInfoList {
  UserInfoList({required this.list});

  List<UserInfoClass> list;
}

class UserInfoClass {
  UserInfoClass({
    required this.recordDateTime,
    required this.tall,
    required this.weight,
    required this.goalWeight,
    required this.startDietDateTime,
    required this.endDietDateTime,
    required this.dietPlanList,
    required this.bodyFat,
    required this.memo,
  });

  DateTime recordDateTime;
  double tall;
  double weight;
  double goalWeight;
  double bodyFat;
  DateTime startDietDateTime;
  DateTime endDietDateTime;
  List<DietPlanClass> dietPlanList;
  String memo;
}

class DietPlanClass {
  DietPlanClass({
    required this.id,
    required this.icon,
    required this.plan,
    required this.isChecked,
    required this.isAction,
  });

  String id;
  IconData icon;
  String plan;
  bool isChecked;
  bool isAction;

  @override
  String toString() {
    return '{ $id, $plan, $isChecked $isAction }';
  }
}

class TextInputClass {
  TextInputClass({
    required this.maxLength,
    required this.prefixIcon,
    required this.suffixText,
    required this.hintText,
    required this.inputTextErr,
  });

  int maxLength;
  IconData prefixIcon;
  String suffixText;
  String hintText;
  InputTextErrorClass inputTextErr;

  getErrorText({
    required String text,
    required double min,
    required double max,
    required String errMsg,
  }) {
    return handleCheckErrorText(text: text, min: min, max: max, errMsg: errMsg);
  }
}

class InputTextErrorClass {
  InputTextErrorClass({
    required this.min,
    required this.max,
    required this.errMsg,
  });

  double min;
  double max;
  String errMsg;
}

class WiseSayingClass {
  WiseSayingClass({
    required this.wiseSaying,
    required this.name,
  });

  String wiseSaying;
  String name;
}

class ProgressStatusItemClass {
  ProgressStatusItemClass({
    required this.id,
    required this.icon,
    required this.title,
    required this.sub,
  });

  int id;
  IconData icon;
  String title;
  String sub;
}

class RecordSubTypeClass {
  RecordSubTypeClass({
    required this.enumId,
    required this.icon,
  });

  RecordSubTypes enumId;
  IconData icon;
}

class MoreSeeItemClass {
  MoreSeeItemClass({
    required this.index,
    required this.id,
    required this.icon,
    required this.title,
    required this.value,
    required this.widgetType,
    this.onTapArrow,
    this.onTapSwitch,
    this.bottomWidget,
    this.dateTimeStr,
  });

  int index;
  MoreSeeItem id;
  IconData icon;
  String title;
  dynamic value;
  MoreSeeWidgetTypes widgetType;
  Function(MoreSeeItem id)? onTapArrow;
  Function(MoreSeeItem id, bool value)? onTapSwitch;
  String? bottomWidget;
  String? dateTimeStr;
}
