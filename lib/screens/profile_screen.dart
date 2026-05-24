import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget statCard(
    String value,
    String label,
    IconData icon,
  ) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 22,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
            ),
          ],
        ),

        child: Column(
          children: [

            Icon(
              icon,
              color: Colors.green,
              size: 34,
            ),

            const SizedBox(height: 14),

            Text(
              value,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              label,

              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F8F2),

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(22),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              const Text(
                'Mi perfil',

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(26),

                decoration: BoxDecoration(

                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0D7A21),
                      Color(0xFF4CAF50),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(34),
                ),

                child: Column(

                  children: [

                    Container(
                      width: 95,
                      height: 95,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 55,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Fernando',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Eco Warrior Nivel 5',

                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      height: 10,

                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.72,

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      '72% completado para Nivel 6',

                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [

                  statCard(
                    '1,240',
                    'Puntos',
                    Icons.star,
                  ),

                  const SizedBox(width: 18),

                  statCard(
                    '89',
                    'Reciclajes',
                    Icons.recycling,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      'Logros ecológicos',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    achievementTile(
                      'Primer reciclaje',
                      Icons.emoji_events,
                    ),

                    achievementTile(
                      '100 puntos ganados',
                      Icons.workspace_premium,
                    ),

                    achievementTile(
                      'Eco Warrior',
                      Icons.eco,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget achievementTile(
    String title,
    IconData icon,
  ) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [

          Container(
            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 16),

          Text(
            title,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}