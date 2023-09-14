import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wave/resources/app_colors.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:wave/widgets/indicator.dart';

class PostAnalysis extends StatefulWidget {
  const PostAnalysis({Key? key}) : super(key: key);

  @override
  State<PostAnalysis> createState() => _PostAnalysisState();
}

class _PostAnalysisState extends State<PostAnalysis> {
  // 가상의 데이터 -> 아직 안씀
  final List<PieChartSectionData> pieChartSections = [
    PieChartSectionData(
      value: 30,
      title: '유리병',
      color: Colors.blue,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      value: 25,
      title: '종이',
      color: Colors.green,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      value: 20,
      title: '플라스틱',
      color: Colors.orange,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      value: 15,
      title: '금속',
      color: Colors.red,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      value: 10,
      title: '기타',
      color: Colors.purple,
      titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ];

  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터 분석 화면'),
      ),
      body: Row(
        children: [
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        // 이부분 조건이 잘 이해 안됨
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),

                  // ㅊㅈㅍㅌ code
                  // sections: pieChartSections,
                  // borderData: FlBorderData(
                  //   show: false,
                  // ),
                  // sectionsSpace: 0,
                  // centerSpaceRadius: 50,
                  // startDegreeOffset: 90,
                  // pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {}),
                  // // 그래프의 레이블 설정
                  // chartValuesOptions: ChartValuesOptions(
                  //   showChartValuesInPercentage: true,
                  //   showChartValues: true,
                  //   showChartValuesOutside: true,
                  //   chartValueStyle: const TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: AppColors.contentColorBlue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorYellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorPurple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: AppColors.contentColorGreen,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section(영역) 부분 데이터 리스트
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
