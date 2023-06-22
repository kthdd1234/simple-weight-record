import 'package:flutter/material.dart';
import 'package:flutter_app_weight_management/components/framework/app_framework.dart';
import 'package:flutter_app_weight_management/model/user_box/user_box.dart';
import 'package:flutter_app_weight_management/pages/home/body/calendar_body.dart';
import 'package:flutter_app_weight_management/pages/home/body/analyze_body.dart';
import 'package:flutter_app_weight_management/pages/home/body/more_see_body.dart';
import 'package:flutter_app_weight_management/pages/home/body/record_body.dart';
import 'package:flutter_app_weight_management/provider/record_selected_dateTime_provider.dart';
import 'package:flutter_app_weight_management/utils/constants.dart';
import 'package:flutter_app_weight_management/utils/enum.dart';
import 'package:flutter_app_weight_management/widgets/home_app_bar_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer>
    with WidgetsBindingObserver {
  late Box<UserBox> userBox;
  eBottomNavigationBarItem selectedId = eBottomNavigationBarItem.record;

  @override
  void initState() {
    userBox = Hive.box('userBox');
    selectedId = eBottomNavigationBarItem.record;
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    UserBox? userProfile = userBox.get('userProfile');

    if (userProfile != null) {
      if (state == AppLifecycleState.resumed) {
        if (userProfile.screenLockPasswords != null) {
          Navigator.pushNamed(context, '/enter-screen-lock');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<eBottomNavigationBarItem> bottomIdList = [
      eBottomNavigationBarItem.record,
      eBottomNavigationBarItem.calendar,
      eBottomNavigationBarItem.analyze,
      eBottomNavigationBarItem.setting
    ];

    onBottomNavigation(int index) {
      setState(() => selectedId = bottomIdList[index]);
    }

    onTapGestureDetector() {
      FocusScope.of(context).unfocus();
    }

    List<BottomNavigationBarItem> items = const [
      BottomNavigationBarItem(icon: Icon(Icons.edit), label: '기록'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '달력'),
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Icon(FontAwesomeIcons.chartLine, size: 17),
        ),
        label: '분석',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
    ];

    List<Widget> bodyList = [
      const RecordBody(),
      CalendarBody(onBottomNavigation: onBottomNavigation),
      const AnalyzeBody(),
      const MoreSeeBody()
    ];

    return GestureDetector(
        onTap: onTapGestureDetector,
        child: AppFramework(
          widget: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: HomeAppBarWidget(appBar: AppBar(), id: selectedId),
            body: Padding(
              padding: pagePadding,
              child: SafeArea(child: bodyList[selectedId.index]),
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                items: items,
                elevation: 0,
                currentIndex: selectedId.index,
                selectedItemColor: buttonBackgroundColor,
                unselectedItemColor: const Color(0xFF151515),
                backgroundColor: Colors.red,
                onTap: onBottomNavigation,
              ),
            ),
          ),
        ));
  }
}
