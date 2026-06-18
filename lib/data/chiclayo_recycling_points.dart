import '../models/recycling_point.dart';

/// Puntos de acopio autorizados en Chiclayo - Lambayeque.
const List<RecyclingPoint> chiclayoRecyclingPoints = [
  RecyclingPoint(
    name: 'Parque Principal de Chiclayo',
    address: 'Plaza de Armas, Cercado',
    recyclingType: 'Punto de referencia y acopio temporal',
    latitude: -6.77137,
    longitude: -79.84088,
  ),
  RecyclingPoint(
    name: 'Ecotiendas Chiclayo',
    address: 'Av. Balta 123, Chiclayo',
    recyclingType: 'Plásticos PET, papel y cartón',
    latitude: -6.7718,
    longitude: -79.8415,
  ),
  RecyclingPoint(
    name: 'Centro de reciclaje de orgánicos',
    address: 'Av. Francisco Cabrera 789, Chiclayo',
    recyclingType: 'Orgánicos y compostables',
    latitude: -6.7782,
    longitude: -79.8521,
  ),
  RecyclingPoint(
    name: 'Punto Verde Lambayeque',
    address: 'Calle Torres Paz 450, La Victoria',
    recyclingType: 'Vidrio, metal y electrónicos pequeños',
    latitude: -6.8012,
    longitude: -79.9054,
  ),
  RecyclingPoint(
    name: 'Recicla Perú — Chiclayo',
    address: 'Av. Augusto B. Leguía 2100, José Leonardo Ortiz',
    recyclingType: 'Plásticos rígidos y envases',
    latitude: -6.7456,
    longitude: -79.8367,
  ),
  RecyclingPoint(
    name: 'Centro Municipal de Residuos',
    address: 'Carretera a Pimentel Km 4.5',
    recyclingType: 'Residuos voluminosos y reciclables mixtos',
    latitude: -6.7891,
    longitude: -79.8892,
  ),
];

const double chiclayoCenterLat = -6.7714;
const double chiclayoCenterLng = -79.8410;
