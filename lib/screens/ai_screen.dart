import 'package:flutter/material.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {

  bool scanned = false;

  String result = '';
  String description = '';

  void simulateScan() {

    setState(() {

      scanned = true;

      result = 'Botella plástica PET';

      description =
          'Este residuo es reciclable. Deposítalo en el contenedor amarillo o en un punto verde VERDEX.';
    });
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

              const SizedBox(height: 30),

              const Text(
                'Clasificador IA',

                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              Center(

                child: Column(

                  children: [

                    AnimatedContainer(

                      duration: const Duration(milliseconds: 400),

                      width: scanned ? 150 : 170,
                      height: scanned ? 150 : 170,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0D7A21),
                            Color(0xFF63D471),
                          ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.25),
                            blurRadius: 35,
                            spreadRadius: 4,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),

                      child: Icon(
                        scanned
                            ? Icons.check_circle
                            : Icons.auto_awesome,

                        color: Colors.white,
                        size: 75,
                      ),
                    ),

                    const SizedBox(height: 35),

                    Text(
                      scanned
                          ? result
                          : 'Clasificador IA',

                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),

                      child: Text(
                        scanned
                            ? description
                            : 'Próximamente podrás fotografiar residuos y la IA te dirá cómo reciclarlos correctamente.',

                        textAlign: TextAlign.center,

                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 45),

                    Container(
                      width: 240,
                      height: 58,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF0B6B1B),
                            Color(0xFF1E8E2F),
                          ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent,
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: ElevatedButton.icon(

                        onPressed: simulateScan,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),

                        icon: const Icon(Icons.camera_alt),

                        label: Text(
                          scanned
                              ? 'Escanear otra vez'
                              : 'Simular escaneo',

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    if (scanned) ...[

                      const SizedBox(height: 35),

                      Container(
                        padding: const EdgeInsets.all(18),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 14,
                            ),
                          ],
                        ),

                        child: Row(
                          children: [

                            Container(
                              width: 52,
                              height: 52,

                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(18),
                              ),

                              child: const Icon(
                                Icons.eco,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(width: 16),

                            const Expanded(
                              child: Text(
                                '+50 puntos ecológicos ganados',

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
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