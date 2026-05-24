import 'package:flutter/material.dart';
import 'ai_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    String subtitle,
    Widget page,
  ) {
    return GestureDetector(

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),

        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              width: 72,
              height: 72,

              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(22),
              ),

              child: Icon(
                icon,
                color: color,
                size: 34,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F7F4),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      'VERDEX',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),

                    Container(
                      width: 52,
                      height: 52,

                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF4E8),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // BANNER PRINCIPAL
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF39B54A),
                        Color(0xFF2E7D32),
                      ],
                    ),

                    borderRadius: BorderRadius.circular(34),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.28),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: const [

                      Row(
                        children: [

                          Icon(
                            Icons.eco,
                            color: Colors.white,
                            size: 42,
                          ),

                          SizedBox(width: 12),

                          Text(
                            'VERDEX',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 18),

                      Text(
                        'Recicla smarter. Vive mejor.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),

                // TITULO
                const Text(
                  'Explora',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Todo lo que necesitas para reciclar mejor',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 28),

                // TARJETAS
                buildCard(
                  context,
                  Icons.location_on,
                  Colors.green,
                  'Puntos de reciclaje',
                  'Encuentra centros verdes en Chiclayo',
                  const AiScreen(),
                ),

                buildCard(
                  context,
                  Icons.auto_awesome,
                  Colors.teal,
                  'Clasificador IA',
                  'Identifica residuos con inteligencia artificial',
                  const AiScreen(),
                ),

                buildCard(
                  context,
                  Icons.delete_outline,
                  Colors.orange,
                  'Reportar residuos',
                  'Ayuda reportando zonas contaminadas',
                  const AiScreen(),
                ),

                buildCard(
                  context,
                  Icons.card_giftcard,
                  Colors.purple,
                  'Premios ecológicos',
                  'Canjea puntos por recompensas',
                  const AiScreen(),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}