import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wave/resources/app_colors.dart';
import 'package:wave/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/widgets/indicator.dart';
// import 'package:fl_chart_app/presentation/resources/app_resources.dart';

class PostAnalysis extends StatefulWidget {
  const PostAnalysis({Key? key}) : super(key: key);

  @override
  State<PostAnalysis> createState() => _PostAnalysisState();
}

class _PostAnalysisState extends State<PostAnalysis> {
  // 가상의 데이터 -> 안씀
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          backgroundColor: AppColors.contentColorLightBlue,
          title: const Padding(
            padding: EdgeInsets.only(top: 18.0),
            child: Text('나의 분석 리포트'),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: '설정',
              onPressed: () => {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: '마이페이지',
              onPressed: () => {},
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xff1B818F),
                radius: 70,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 55,
                  child: CircleAvatar(
                    radius: 50,
                    // backgroundImage: AssetImage('assets/images/logo.png'),
                    backgroundImage:
                        NetworkImage('https://picsum.photos/id/237/200/300'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                '나의 분석 리포트',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
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
