import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/components/space/spaceHeight.dart';
import 'package:flutter_app_weight_management/model/plan_box/plan_box.dart';
import 'package:flutter_app_weight_management/model/record_box/record_box.dart';
import 'package:flutter_app_weight_management/model/user_box/user_box.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_memo_widget.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_plan_widget.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_weight_widget.dart';
import 'package:flutter_app_weight_management/pages/home/body/widgets/today_wise_saying_widget.dart';
import 'package:flutter_app_weight_management/provider/record_selected_dateTime_provider.dart';
import 'package:flutter_app_weight_management/provider/record_icon_type_provider.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';
import 'package:flutter_app_weight_management/utils/enum.dart';
import 'package:flutter_app_weight_management/utils/function.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';

class RecordBody extends StatefulWidget {
  const RecordBody({super.key});

  @override
  State<RecordBody> createState() => _RecordBodyState();
}

class _RecordBodyState extends State<RecordBody> with WidgetsBindingObserver {
  late Box<RecordBox> recordBox;

  @override
  void initState() {
    super.initState();

    recordBox = Hive.box<RecordBox>('recordBox');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      RecordBox? recordInfo = recordBox.get(getDateTimeToInt(DateTime.now()));

      if (recordInfo == null || recordInfo.weight == null) {
        context
            .read<RecordIconTypeProvider>()
            .setSeletedRecordIconType(RecordIconTypes.addWeight);
      }

      context.read<ImportDateTimeProvider>().setImportDateTime(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    RecordIconTypes seletedRecordIconType =
        context.watch<RecordIconTypeProvider>().getSeletedRecordIconType();
    DateTime importDateTime =
        context.watch<ImportDateTimeProvider>().getImportDateTime();

    onPressed() {
      final userBox = Hive.box<UserBox>('userBox');
      final recordBox = Hive.box<RecordBox>('recordBox');
      final planBox = Hive.box<PlanBox>('planBox');

      userBox.clear();
      recordBox.clear();
      planBox.clear();
    }

    return SingleChildScrollView(
      child: MultiValueListenableBuilder(
        valueListenables: [
          Hive.box<UserBox>('userBox').listenable(),
          Hive.box<RecordBox>('recordBox').listenable(),
          Hive.box<PlanBox>('planBox').listenable(),
        ],
        builder: (context, values, child) {
          return Column(
            children: [
              const TodayWiseSayingWidget(),
              SpaceHeight(height: largeSpace),
              TodayWeightWidget(
                seletedRecordIconType: seletedRecordIconType,
                importDateTime: importDateTime,
              ),
              SpaceHeight(height: largeSpace),
              TodayPlanWidget(
                seletedRecordIconType: seletedRecordIconType,
                importDateTime: importDateTime,
              ),
              SpaceHeight(height: largeSpace),
              TodayMemoWidget(seletedRecordSubType: seletedRecordIconType),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('hive 데이터 초기화'),
              )
            ],
          );
        },
      ),
    );
  }
}
