import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/components/area/empty_text_area.dart';
import 'package:flutter_app_weight_management/components/contents_box/contents_box.dart';
import 'package:flutter_app_weight_management/components/dialog/confirm_dialog.dart';
import 'package:flutter_app_weight_management/components/space/spaceHeight.dart';
import 'package:flutter_app_weight_management/components/text/contents_title_text.dart';
import 'package:flutter_app_weight_management/model/record_box/record_box.dart';
import 'package:flutter_app_weight_management/model/user_box/user_box.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/record_contents_title_icon.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_weight_edit_widget.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_weight_infos_widget.dart';
import 'package:flutter_app_weight_management/provider/record_icon_type_provider.dart';
import 'package:flutter_app_weight_management/provider/record_selected_dateTime_provider.dart';
import 'package:flutter_app_weight_management/utils/class.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';
import 'package:flutter_app_weight_management/utils/enum.dart';
import 'package:flutter_app_weight_management/utils/function.dart';
import 'package:flutter_app_weight_management/utils/variable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class TodayWeightWidget extends StatefulWidget {
  TodayWeightWidget({
    super.key,
    required this.seletedRecordIconType,
    required this.importDateTime,
  });

  RecordIconTypes seletedRecordIconType;
  DateTime importDateTime;

  @override
  State<TodayWeightWidget> createState() => _TodayWeightWidgetState();
}

class _TodayWeightWidgetState extends State<TodayWeightWidget> {
  late Box<UserBox> userBox;
  late Box<RecordBox> recordBox;

  List<RecordIconClass> recordIconClassList = [
    RecordIconClass(
      enumId: RecordIconTypes.editWeight,
      icon: Icons.edit,
    ),
    RecordIconClass(
      enumId: RecordIconTypes.alarmWeight,
      icon: Icons.notifications,
    ),
    RecordIconClass(
      enumId: RecordIconTypes.removeWeight,
      icon: Icons.delete,
    ),
  ];

  @override
  void initState() {
    userBox = Hive.box<UserBox>('userBox');
    recordBox = Hive.box<RecordBox>('recordBox');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RecordBox? recordInfo =
        recordBox.get(getDateTimeToInt(widget.importDateTime));

    setIconType(enumId) {
      context.read<RecordIconTypeProvider>().setSeletedRecordIconType(enumId);
    }

    onTapIcon(enumId) {
      if (recordInfo?.weight == null) {
        return showSnackBar(
          context: context,
          text: '오늘의 체중을 입력해주세요.',
          width: 270,
        );
      }

      if (enumId == RecordIconTypes.alarmWeight) {
        Navigator.pushNamed(context, '/common-alarm');
      }

      setIconType(enumId);
    }

    setIconWidgets() {
      return recordIconClassList
          .map(
            (element) => RecordContentsTitleIcon(
              id: element.enumId,
              icon: element.icon,
              onTap: onTapIcon,
            ),
          )
          .toList();
    }

    onTapEmptyRecordArea() {
      setIconType(RecordIconTypes.addWeight);
    }

    onPressedWeightDelete() {
      if (recordInfo == null) return null;

      recordInfo.weight = null;
      recordBox.put(getDateTimeToInt(widget.importDateTime), recordInfo);
    }

    contentsWidgets({
      double? weight,
      double? tall,
      double? goalWeight,
      double? beforeWeight,
    }) {
      List<RecordIconTypes> editEnumIds = [
        RecordIconTypes.addWeight,
        RecordIconTypes.editWeight,
        RecordIconTypes.editGoalWeight
      ];

      if (editEnumIds.contains(widget.seletedRecordIconType)) {
        final isAddWeight =
            widget.seletedRecordIconType == RecordIconTypes.addWeight;

        return TodayWeightEditWidget(
          importDateTime: widget.importDateTime,
          seletedRecordIconType: widget.seletedRecordIconType,
          weightText: isAddWeight ? '' : weight.toString(),
          goalWeightText: goalWeight.toString(),
        );
      } else if (widget.seletedRecordIconType == RecordIconTypes.removeWeight) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                width: 230,
                titleText: '데이터 삭제',
                contentIcon: Icons.delete_forever,
                contentText1: '오늘의 체중 데이터를',
                contentText2: '삭제하시겠습니까?',
                onPressedOk: onPressedWeightDelete,
              ),
            );
            setIconType(RecordIconTypes.none);
          },
        );
      }

      if (weight == null) {
        return EmptyTextArea(
          text: '오늘의 체중을 입력해보세요.',
          icon: Icons.add,
          topHeight: regularSapce,
          downHeight: regularSapce,
          onTap: onTapEmptyRecordArea,
        );
      }

      return TodayWeightInfosWidget(
        weight: weight,
        goalWeight: goalWeight,
        tall: tall,
        beforeWeight: beforeWeight,
      );
    }

    setTall() {
      UserBox? userInfo = userBox.get('userBox');

      if (userInfo == null) return null;
      return userInfo.tall;
    }

    setWeight() {
      RecordBox? recordInfo =
          recordBox.get(getDateTimeToInt(widget.importDateTime));
      return recordInfo?.weight;
    }

    setGoalWeight() {
      UserBox? userInfo = userBox.get('userBox');
      return userInfo?.goalWeight;
    }

    double? setBeforeWeight() {
      RecordBox? recordInfo =
          recordBox.get(getDateTimeToInt(widget.importDateTime));

      if (recordInfo == null) return null;

      List<RecordBox> recordBoxValues = recordBox.values.toList();

      int index = recordBoxValues.indexWhere(
        (element) =>
            getDateTimeToInt(element.recordDateTime) ==
            getDateTimeToInt(widget.importDateTime),
      );

      if (index <= 0) return 0.0;

      List<RecordBox> sublist = recordBoxValues.sublist(0, index).toList();
      List<RecordBox> reverseList = List.from(sublist.reversed);
      RecordBox result =
          reverseList.firstWhere((element) => element.weight != null);

      return result.weight;
    }

    setContetnsTitle() {
      Map<String, dynamic>? contentsTitleInfo =
          weightContentsTitles[widget.seletedRecordIconType];

      if (contentsTitleInfo == null) return '오늘의 체중';
      return contentsTitleInfo['title'];
    }

    setContetnsIcon() {
      Map<String, dynamic>? contentsTitleInfo =
          weightContentsTitles[widget.seletedRecordIconType];

      if (contentsTitleInfo == null) return Icons.bar_chart;
      return contentsTitleInfo['icon'];
    }

    return ContentsBox(
      contentsWidget: Column(
        children: [
          ContentsTitleText(
            text: setContetnsTitle(),
            sub: setIconWidgets(),
            icon: setContetnsIcon(),
          ),
          SpaceHeight(height: smallSpace),
          contentsWidgets(
            tall: setTall(),
            weight: setWeight(),
            goalWeight: setGoalWeight(),
            beforeWeight: setBeforeWeight(),
          ),
        ],
      ),
    );
  }
}
