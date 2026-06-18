import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/ai_screen.dart';
import '../screens/recycling_screen.dart';
import '../screens/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {

  int currentIndex = 0;

  final List<Widget> screens = [

    const HomeScreen(),

    const RecyclingScreen(),

    const AiScreen(),

    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: Container(

        margin: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
            ),
          ],
        ),

        child: ClipRRect(

          borderRadius: BorderRadius.circular(30),

          child: BottomNavigationBar(

            currentIndex: currentIndex,

            onTap: (index) {

              setState(() {

                currentIndex = index;
              });
            },

            backgroundColor: Colors.white,

            type: BottomNavigationBarType.fixed,

            selectedItemColor: Colors.green,

            unselectedItemColor: Colors.grey,

            elevation: 0,

            items: const [

              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.recycling),
                label: 'Reciclar',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome),
                label: 'IA',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}