import 'package:flutter/material.dart';

class RecyclingScreen extends StatelessWidget {
  const RecyclingScreen({super.key});

  Widget recyclingCard(
    String title,
    String address,
    String distance,
    IconData icon,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(20),

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

      child: Row(
        children: [

          Container(
            width: 65,
            height: 65,

            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(22),
            ),

            child: Icon(
              icon,
              color: Colors.green,
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
                  address,

                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F8E9),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    distance,

                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.black26,
          ),
        ],
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
                'Puntos ecológicos',

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Encuentra centros de reciclaje cercanos',

                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView(

                  children: [

                    recyclingCard(
                      'Punto Verde Real Plaza',
                      'Av. José Balta 950, Chiclayo',
                      '1.2 km',
                      Icons.recycling,
                    ),

                    recyclingCard(
                      'Eco Centro Chiclayo',
                      'Calle San José 210',
                      '2.4 km',
                      Icons.eco,
                    ),

                    recyclingCard(
                      'Reciclaje Norte',
                      'Av. Grau 1450',
                      '3.1 km',
                      Icons.delete_outline,
                    ),

                    recyclingCard(
                      'VERDEX Green Point',
                      'Urbanización Santa Victoria',
                      '4.7 km',
                      Icons.energy_savings_leaf,
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
}