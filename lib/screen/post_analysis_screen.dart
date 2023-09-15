import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wave/resources/app_colors.dart';
import 'package:wave/widget/myAppBar.dart';
import 'package:wave/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';

class PostAnalysis extends StatefulWidget {
  const PostAnalysis({Key? key}) : super(key: key);

  @override
  State<PostAnalysis> createState() => _PostAnalysisState();
}

class _PostAnalysisState extends State<PostAnalysis> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: MyAppBar(
            titleText: '나의 분석 리포트',
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
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
                        centerSpaceRadius: 50,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Indicator(
                      color: AppColors.contentColorBlue,
                      text: '플라스틱',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.contentColorOrange,
                      text: '스티로폼',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.contentColorPurple,
                      text: '기타',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: AppColors.contentColorGreen,
                      text: '의류',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ],
            ),
            DataTable(
              columnSpacing: 160.0, // 열 사이의 간격 조절
              columns: const [
                DataColumn(
                    label: Text(
                  '종류',
                  style: TextStyle(fontSize: 18.0),
                )),
                DataColumn(
                    label: Text(
                  '개수',
                  style: TextStyle(fontSize: 18.0),
                )),
              ],
              rows: garbageData.map((data) {
                return DataRow(cells: [
                  DataCell(Text(
                    data['type'],
                    style: const TextStyle(fontSize: 22.0),
                  )),
                  DataCell(Text(
                    '${data['count']}건',
                    style: const TextStyle(fontSize: 22.0),
                  )),
                ]);
              }).toList(),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  // Section(영역) 부분 데이터 리스트
  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
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
              color: AppColors.contentColorOrange,
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
              value: 18,
              title: '18%',
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
              value: 12,
              title: '12%',
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
      },
    );
  }
}

final List<Map<String, dynamic>> garbageData = [
  {'type': '플라스틱', 'count': 25},
  {'type': '스티로폼', 'count': 18},
  {'type': '기타', 'count': 11},
  {'type': '의류', 'count': 7},
  // {'type': '일반 쓰레기', 'count': 30},
];
