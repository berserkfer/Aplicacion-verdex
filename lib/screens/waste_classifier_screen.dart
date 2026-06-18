import 'package:flutter/material.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F2),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),

          child: Column(
            children: [

              const SizedBox(height: 40),

              // TITULO
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Clasificador IA',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const Spacer(),

              // ICONO
              Container(
                width: 150,
                height: 150,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF148A1A),
                      Color(0xFF63D76A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(100),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),

                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 70,
                ),
              ),

              const SizedBox(height: 35),

              // TEXTO
              const Text(
                'Clasificador IA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Próximamente podrás fotografiar residuos y la IA te dirá cómo reciclarlos correctamente.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              // BOTON
              SizedBox(
                width: 220,
                height: 54,

                child: ElevatedButton.icon(
                  onPressed: () {},

                  icon: const Icon(Icons.camera_alt),

                  label: const Text(
                    'Próximamente',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F6E18),
                    foregroundColor: Colors.white,

                    elevation: 3,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}