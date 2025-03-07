// home_page.dart
import 'package:flutter/material.dart';
import 'animation.dart'; // This file contains the CorruptionCards widget
import 'reportPage.dart';
import 'previous_reports_page.dart';
import 'view_forms_page.dart';
import 'tenders_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBodyContent() {
    if (_selectedIndex == 0) {
      // Home content
      return SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                // Scrolling carousel of corruption awareness cards
                const CorruptionCards(),
                const SizedBox(height: 30),
                // Row with buttons to file a report and view previous reports
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReportPage()),
                        );
                      },
                      child: Text(
                        'File a Report',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PreviousReportsPage()),
                        );
                      },
                      child: Text(
                        'Previous Reports',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Row with buttons to view forms and tenders
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewFormsPage()),
                        );
                      },
                      child: Text(
                        'View Forms',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TendersPage()),
                        );
                      },
                      child: Text(
                        'Tenders',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // For Profile tab, do nothing (or display an empty container)
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: const Icon(Icons.home_filled),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: _getBodyContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.lightBlueAccent,
        selectedIconTheme: const IconThemeData(
          color: Colors.blue,
          size: 30,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.lightBlueAccent,
          size: 24,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
