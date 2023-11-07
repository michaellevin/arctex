import 'package:arktech/pages/analisys_page.dart';
import 'package:arktech/pages/assets_page.dart';
import 'package:arktech/pages/inspection_page.dart';
import 'package:arktech/pages/monitoring_page.dart';
import 'package:arktech/pages/reliability_page.dart';
import 'package:arktech/pages/scheduling_page.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARCTEX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'APKTEX'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  List<SideMenuItem> items = [];

  _MyHomePageState() {
    items = [
      SideMenuItem(
        title: 'Assets',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.diamond_outlined),
        // badgeContent: Text(
        //   '3',
        //   style: TextStyle(color: Colors.white),
        // ),
      ),
      SideMenuItem(
        title: 'Monitoring',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.auto_graph),
      ),
      SideMenuItem(
        title: 'Inspection',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.insert_chart_outlined_outlined),
      ),      
      SideMenuItem(
        title: 'Reliability',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.pie_chart_outline),
      ),         
      SideMenuItem(
        title: 'Analisys',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.speed),
      ),               
      SideMenuItem(
        title: 'Scheduling',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.calendar_month_outlined),
      ),            
    ];
  }

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            // Page controller to manage a PageView
            controller: sideMenu,
            // Will shows on top of all items, it can be a logo or a Title text
            // title: Image.asset('assets/images/easy_sidemenu.png'),
            // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
            // footer: Text('demo'),
            // Notify when display mode changed
            // onDisplayModeChanged: (mode) {
            //   print(mode);
            // },
            // List of SideMenuItem to show them on SideMenu
            items: items,
          ),

          Expanded(
            child: PageView(
              controller: pageController,
              children: const [
                AssetsPage(),
                MonitoringPage(),
                InspectionPage(),
                ReliabilityPage(),
                AnalisysPage(),
                SchedulingPage()
              ],
            ),
          ),          
        ],
      ),
    );
  }
}
