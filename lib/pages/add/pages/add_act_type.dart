import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/components/contents_box/contents_box.dart';
import 'package:flutter_app_weight_management/components/text/bottom_text.dart';
import 'package:flutter_app_weight_management/components/text/contents_title_text.dart';
import 'package:flutter_app_weight_management/provider/diet_Info_provider.dart';
import 'package:flutter_app_weight_management/utils/enum.dart';
import 'package:flutter_app_weight_management/utils/variable.dart';
import 'package:flutter_app_weight_management/widgets/act_type_widget.dart';
import 'package:flutter_app_weight_management/components/simple_stepper/simple_stepper.dart';
import 'package:flutter_app_weight_management/components/space/spaceHeight.dart';
import 'package:flutter_app_weight_management/components/text/headline_text.dart';
import 'package:flutter_app_weight_management/pages/add/add_container.dart';
import 'package:flutter_app_weight_management/utils/class.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';
import 'package:provider/provider.dart';

class AddActType extends StatefulWidget {
  const AddActType({super.key});

  @override
  State<AddActType> createState() => _AddActTypeState();
}

class _AddActTypeState extends State<AddActType> {
  ActTypeEnum selectedType = ActTypeEnum.diet;

  @override
  Widget build(BuildContext context) {
    buttonEnabled() {
      return selectedType != ActTypeEnum.none;
    }

    onPressedBottomNavigationButton() {
      if (buttonEnabled()) {
        context.read<DietInfoProvider>().changeActType(selectedType);
        context
            .read<DietInfoProvider>()
            .changeSubActType(initItemType[selectedType]!);
        Navigator.pushNamed(context, '/add-act-names');
      }

      return null;
    }

    onTap(dynamic type) {
      setState(() => selectedType = type);
    }

    List<ActTypeWidget> itemTypeWidgets = mainItemTypeClassList
        .map((item) => ActTypeWidget(
              id: item.id,
              title: item.title,
              desc: item.desc,
              icon: item.icon,
              isEnabled: selectedType == item.id,
              onTap: onTap,
            ))
        .toList();

    return AddContainer(
      body: Column(
        children: [
          SimpleStepper(currentStep: 2),
          SpaceHeight(height: regularSapce),
          HeadlineText(text: '어떤 방법으로 시작할까요?'),
          SpaceHeight(height: regularSapce),
          ContentsBox(
            contentsWidget: Column(
              children: [
                ContentsTitleText(
                  text: '나의 방법',
                  icon: Icons.domain_verification_rounded,
                ),
                SpaceHeight(height: regularSapce),
                Column(children: itemTypeWidgets)
              ],
            ),
          ),
          SpaceHeight(height: regularSapce),
          BottomText(bottomText: '다이어트, 운동, 생활 습관은 목표 체중에 달성하기 위한 방법입니다.')
        ],
      ),
      buttonEnabled: buttonEnabled(),
      bottomSubmitButtonText: '다음',
      onPressedBottomNavigationButton: onPressedBottomNavigationButton,
    );
  }
}