import '../models/recycling_point.dart';

/// Datos de ejemplo para centros de acopio / reciclaje en Chiclayo.
/// Puedes sustituirlos por una API o base local cuando la tengas.
const List<RecyclingPoint> chiclayoRecyclingPoints = [
  RecyclingPoint(
    name: 'Ecotiendas Chiclayo',
    address: 'Av. Balta 1230, Cercado',
    recyclingType: 'Plásticos PET, papel y cartón',
  ),
  RecyclingPoint(
    name: 'Punto Verde Lambayeque',
    address: 'Calle Torres Paz 450, La Victoria',
    recyclingType: 'Vidrio, metal y electrónicos pequeños',
  ),
  RecyclingPoint(
    name: 'Recicla Perú — Chiclayo',
    address: 'Av. Augusto B. Leguía 2100, José Leonardo Ortiz',
    recyclingType: 'Plásticos rígidos y envases',
  ),
  RecyclingPoint(
    name: 'Acopio Comunal Santa Rosa',
    address: 'Jr. Gálvez 318, Santa Rosa',
    recyclingType: 'Orgánicos compostables y restos vegetales',
  ),
  RecyclingPoint(
    name: 'Centro Municipal de Residuos',
    address: 'Carretera a Pimentel Km 4.5',
    recyclingType: 'Residuos voluminosos y reciclables mixtos',
  ),
];
