import 'package:flutter/material.dart';
import 'package:whatsapp_clon/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_clon/feature/home/pages/call_home_page.dart';
import 'package:whatsapp_clon/feature/home/pages/chat_home_page.dart';
import 'package:whatsapp_clon/feature/home/pages/status_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Longitud 3 para tus tres pestañas
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WhatsApp',
          style: TextStyle(letterSpacing: 1),
        ),
        elevation: 1,
        actions: [
          CustomIconButton(onTap: () {}, icon: Icons.search),
          CustomIconButton(onTap: () {}, icon: Icons.more_vert),
        ],
        bottom: TabBar(
          controller: _tabController, // Asignar el TabController al TabBar
          indicatorWeight: 3,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Asignar el TabController al TabBarView
        children: const [
          ChatHomePage(),
          StatusHomePage(),
          CallHomePage(),
        ],
      ),
    );
  }
}
