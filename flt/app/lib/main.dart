import 'package:arktech/bloc/pipeline_data_bloc.dart';
import 'package:arktech/tools/pipeline_data_provider.dart';
import 'package:arktech/pages/analisys_page.dart';
import 'package:arktech/pages/assets_page.dart';
import 'package:arktech/pages/inspection_page.dart';
import 'package:arktech/pages/monitoring_page.dart';
import 'package:arktech/pages/reliability_page.dart';
import 'package:arktech/pages/scheduling_page.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';


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
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => PipelineDataBloc()),
        ],
        child: const MyHomePage(title: 'ARCTEX')),
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
  final PageController _pageController = PageController();
  final SideMenuController _sideMenu = SideMenuController();
  List<SideMenuItem> _menuItems = [];

  _MyHomePageState() {
    _menuItems = [
      SideMenuItem(
        title: 'Assets',
        onTap: (index, _) {
          _sideMenu.changePage(index);
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
          _sideMenu.changePage(index);
        },
        icon: const Icon(Icons.auto_graph),
      ),
      SideMenuItem(
        title: 'Inspection',
        onTap: (index, _) {
          _sideMenu.changePage(index);
        },
        icon: const Icon(Icons.insert_chart_outlined_outlined),
      ),      
      SideMenuItem(
        title: 'Reliability',
        onTap: (index, _) {
          _sideMenu.changePage(index);
        },
        icon: const Icon(Icons.pie_chart_outline),
      ),         
      SideMenuItem(
        title: 'Analisys',
        onTap: (index, _) {
          _sideMenu.changePage(index);
        },
        icon: const Icon(Icons.speed),
      ),               
      SideMenuItem(
        title: 'Scheduling',
        onTap: (index, _) {
          _sideMenu.changePage(index);
        },
        icon: const Icon(Icons.calendar_month_outlined),
      ),            
    ];
  }

  @override
  void initState() {
    _sideMenu.addListener((index) {
      _pageController.jumpToPage(index);
    });
    context.read<PipelineDataBloc>().add(PipelineDataReadEvent());
    super.initState();
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
          child: CircleAvatar(
            child: Icon(Icons.portrait),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: SideMenu(
              // Page controller to manage a PageView
              controller: _sideMenu,
              // Will shows on top of all items, it can be a logo or a Title text
              // title: Image.asset('assets/images/easy_sidemenu.png'),
              // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
              // footer: Text('demo'),
              // Notify when display mode changed
              // onDisplayModeChanged: (mode) {
              //   print(mode);
              // },
              // List of SideMenuItem to show them on SideMenu
              items: _menuItems,
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
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
