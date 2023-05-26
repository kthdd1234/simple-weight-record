import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/utils/class.dart';
import 'package:intl/intl.dart';

/// 5.0
const double tinySpace = 5.0;

/// 10.0
const double smallSpace = 10.0;

/// 20.0
const double regularSapce = 20.0;

/// 40.0
const double largeSpace = 40.0;

/// submitButtonHeight
const double submitButtonHeight = 48.0;

/// pagePadding
const EdgeInsetsGeometry pagePadding = EdgeInsets.all(20.0);

/// submitButtonBoxPadding
const EdgeInsetsGeometry submitButtonBoxPadding =
    EdgeInsets.symmetric(horizontal: 20, vertical: 10);

// primaryColor
const primaryColor = Color(0xFF40465E);

/// buttonBackgroundColor
const buttonBackgroundColor = Color(0xFF404763);

/// buttonTextColor
const buttonTextColor = Color(0xFFFFFFFF);

/// disabledButtonBackgroundColor
const disabledButtonBackgroundColor = Color(0xFFEFF0F2);

/// disabledButtonTextColor
const disabledButtonTextColor = Color(0xFF9A9EAA);

/// typeBackgroundColor
const typeBackgroundColor = Color(0xffF9FAFB);

///

/// enabledTypeColor
const enabledTypeColor = Color(0xff6C7B97);

/// disEnabledTypeColor
const disEnabledTypeColor = Color(0xff9A9EAA);

/// tallMin
const tallMin = 120.0;

/// tallMax
const tallMax = 220.0;

/// weightMin
const weightMin = 20.0;

/// weightMax
const weightMax = 200.0;

/// bodyFatMin
const bodyFatMin = 0.0;

/// bodyFatMax
const bodyFatMax = 100.0;

/// tallErrMsg
const tallErrMsg = '120 에서 220 사이의 값을 입력해주세요.';

/// weightErrMsg
const weightErrMsg = '20 에서 200 사이의 값을 입력해주세요.';

/// bodyFatErrMsg
const bodyFatErrMsg = '0 에서 100 사이의 값을 입력해주세요.';

/// tallHintText
const tallHintText = '키를 입력해주세요.';

/// weightHintText
const weightHintText = '체중을 입력해주세요.';

/// weightHintText
const goalWeightHintText = '목표 체중을 입력해주세요.';

/// bodyFatHintText
const bodyFatHintText = '체지방률을 입력해주세요.';

/// tallPrefixIcon
const tallPrefixIcon = Icons.accessibility_new;

/// weightPrefixIcon
const weightPrefixIcon = Icons.monitor_weight;

/// goalWeightPrefixIcon
const goalWeightPrefixIcon = Icons.flag;

/// bodyFatPrefixIcon
const bodyFatPrefixIcon = Icons.align_vertical_bottom;

/// tallMaxLength
const tallMaxLength = 5;

/// weightMaxLength
const weightMaxLength = 4;

/// bodyFatMaxLength
const bodyFatMaxLength = 4;

// tallSuffixText
const tallSuffixText = 'cm';

// weightSuffixText
const weightSuffixText = 'kg';

// tallSuffixText
const bodyFatSuffixText = '%';

/// containerBorderRadious
final containerBorderRadious =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

/// inputContentPadding
const inputContentPadding = EdgeInsets.only(top: 15);

/// inputKeyboardType
const inputKeyboardType = TextInputType.numberWithOptions(decimal: true);

/// dialogBackgroundColor
const dialogBackgroundColor = Color(0xffF3F4F9);

/// weightDotColor
const weightDotColor = Colors.green;

/// actionDotColor
const actionDotColor = Colors.blue;

/// memoDotColor
const memoDotColor = Colors.orange;
