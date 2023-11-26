import 'package:arktech/database/database_connector.dart';
import 'package:arktech/pages/analisys_page.dart';
import 'package:arktech/pages/assets_page.dart';
import 'package:arktech/pages/inspection_page.dart';
import 'package:arktech/pages/monitoring_page.dart';
import 'package:arktech/pages/reliability_page.dart';
import 'package:arktech/pages/scheduling_page.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


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
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  final SideMenuController sideMenu = SideMenuController();
  
  final DatabaseConnector dbConnector = DatabaseConnector();
  String _currentDb = "gazprom";

  List<SideMenuItem> items = [];

  _MyHomePageState() {
    items = [
      SideMenuItem(
        title: 'Assets',
        onTap: (index, _) {
          sideMenu.changePage(index);
        },
        icon: const Icon(Icons.diamond_outlined),
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

    _connectToDatabase();
  }

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  void _connectToDatabase() async {
    await dbConnector.connect(_currentDb);
  }

  void _switchDatabase(String newDatabase) {
    setState(() {
      _currentDb = newDatabase;
    });
    _connectToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 1.0,
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(child: Icon(Icons.portrait)),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.settings),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: SubmenuButton(
                  menuChildren: [
                    PopupMenuItem(
                      onTap: () => _switchDatabase("gazprom"),
                      child: const Text("Gazprom")
                    ),
                    PopupMenuItem(
                      onTap: () => _switchDatabase("rosneft"),
                      child: const Text("Rosneft")
                    ),
                  ], 
                  child: const Text("Databases")
              ),
              )
            ]
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: SideMenu(
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
          ),

          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                AssetsPage(dbConnector),
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
