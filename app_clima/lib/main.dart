import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final Color primaryColor = const Color(0xFF9EDCFF);

  final TextEditingController cityController = TextEditingController();

  double temperatura = 0;
  String descricao = '';
  String cidade = 'City/Country';
  double tempMax = 0;
  double tempMin = 0;
  int umidade = 0;
  double vento = 0;

  final String apiKey = '9c7f99473471595e7a90a4b31c2c09ca'; 

  @override
  void initState() {
    super.initState();
    fetchWeather('São Paulo');
  }

  Future<void> fetchWeather(String city) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=pt_br');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          temperatura = data['main']['temp'];
          descricao = data['weather'][0]['description'];
          cidade = data['name'];
          tempMax = data['main']['temp_max'];
          tempMin = data['main']['temp_min'];
          umidade = data['main']['humidity'];
          vento = data['wind']['speed'].toDouble();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cidade não encontrada')),
        );
      }
    } catch (e) {
      print('Erro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao buscar dados')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              searchBar(),
              const SizedBox(height: 10),
              header(),
              const SizedBox(height: 20),
              currentTemperature(),
              const SizedBox(height: 20),
              infoDetails(),
            ],
          ),
        ),
      ),
    );
  }

  // Search bar
  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: 'Digite a cidade',
              hintStyle: const TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            String city = cityController.text.trim();
            if (city.isNotEmpty) {
              fetchWeather(city);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('Buscar'),
        ),
      ],
    );
  }

  // Header com cidade, data
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agora',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              cidade,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Icon(Icons.menu, color: Colors.white, size: 30),
      ],
    );
  }

  // Temperatura Atual
  Widget currentTemperature() {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.wb_sunny, color: Colors.yellow, size: 80),
          Text(
            '${temperatura.toStringAsFixed(0)}°C',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            descricao.toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          Text(
            'Máx ${tempMax.toStringAsFixed(0)}° / Mín ${tempMin.toStringAsFixed(0)}°',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Informações adicionais: Umidade, Vento
  Widget infoDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          infoTile(Icons.water_drop, '$umidade%', 'Umidade'),
          infoTile(Icons.air, '${vento.toStringAsFixed(1)} m/s', 'Vento'),
        ],
      ),
    );
  }

  Widget infoTile(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
              color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
