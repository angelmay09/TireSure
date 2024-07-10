import 'dart:math';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tire_Sure/sign.dart';

void main() {
  runApp(const TireSure());
}

class TireSure extends StatelessWidget {
  const TireSure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tire Sure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF203863),
      ),
      home: const LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 350,
                color: Colors.transparent,
                child: Image.asset(
                  'assets/loading.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TireSureHome extends StatefulWidget {
  final String selectedVehicleIcon;
  final int normalPressureMin;
  final int normalPressureMax;
  const TireSureHome({
    Key? key,
    required this.selectedVehicleIcon,
    required this.normalPressureMin,
    required this.normalPressureMax,
  }) : super(key: key);

  @override
  State<TireSureHome> createState() => _TireSureHomeState();
}

class _TireSureHomeState extends State<TireSureHome> {
  Timer? timer;
  int pressure = 0;
  int temperature = 0;
  int pressure1 = 0;
  int temperature1 = 0;
  int pressure2 = 0;
  int temperature2 = 0;
  int pressure3 = 0;
  int temperature3 = 0;
  int _elapsedTimeInSeconds = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => updateTireData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = widget.selectedVehicleIcon;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIconButtonWithLabel(Icons.settings, 'Options'),
                  const SizedBox(width: 250),
                  _buildIconButtonWithLabel(Icons.speed, 'Dashboard'),
                  _buildIconButtonWithLabel(Icons.directions_car, 'Vehicles'),
                ],
              ),
              Expanded(
                child: Center(
                  child: Image.asset(
                    _getImagePath(imagePath),
                    width: 280,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          // Counter images
          if (_getNumberOfWheels(imagePath) == 2)
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 85,
              child: _buildCounterImage(1, pressure, temperature),
            ),
          if (_getNumberOfWheels(imagePath) == 2)
            Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width / 2 - 85,
              child: _buildCounterImage(2, pressure1, temperature1),
            ),
          if (_getNumberOfWheels(imagePath) == 3)
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 85,
              child: _buildCounterImage(1, pressure, temperature),
            ),
          if (_getNumberOfWheels(imagePath) == 3)
            Positioned(
              bottom: 50,
              left: 20,
              child: _buildCounterImage(2, pressure1, temperature1),
            ),
          if (_getNumberOfWheels(imagePath) == 3)
            Positioned(
              bottom: 50,
              right: 20,
              child: _buildCounterImage(3, pressure2, temperature2),
            ),
          if (_getNumberOfWheels(imagePath) == 4)
            Positioned(
              top: 100,
              left: 20,
              child: _buildCounterImage(1, pressure, temperature),
            ),
          if (_getNumberOfWheels(imagePath) == 4)
            Positioned(
              top: 100,
              right: 20,
              child: _buildCounterImage(2, pressure1, temperature1),
            ),
          if (_getNumberOfWheels(imagePath) == 4)
            Positioned(
              bottom: 50,
              left: 20,
              child: _buildCounterImage(3, pressure2, temperature2),
            ),
          if (_getNumberOfWheels(imagePath) == 4)
            Positioned(
              bottom: 50,
              right: 20,
              child: _buildCounterImage(4, pressure3, temperature3),
            ),
        ],
      ),
    );
  }

  void updateTireData() {
    print('Updating tire data...');

    setState(() {
      if (_elapsedTimeInSeconds < 30) {
        // Within the first 30 seconds, keep the pressure and temperature within the normal range
        int numberOfWheels = _getNumberOfWheels(widget.selectedVehicleIcon);
        if (numberOfWheels == 2) {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature1 = 80 + Random().nextInt(11);
        } else if (numberOfWheels == 3) {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature1 = 80 + Random().nextInt(11);
          pressure2 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature2 = 80 + Random().nextInt(11);
        } else {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature1 = 80 + Random().nextInt(11);
          pressure2 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature2 = 80 + Random().nextInt(11);
          pressure3 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 1);
          temperature3 = 80 + Random().nextInt(11);
        }
      } else {
        int numberOfWheels = _getNumberOfWheels(widget.selectedVehicleIcon);
        if (numberOfWheels == 2) {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature1 = 80 + Random().nextInt(11);
        } else if (numberOfWheels == 3) {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature1 = 80 + Random().nextInt(11);
          pressure2 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature2 = 80 + Random().nextInt(11);
        } else {
          pressure = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature = 80 + Random().nextInt(11);
          pressure1 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature1 = 80 + Random().nextInt(11);
          pressure2 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature2 = 80 + Random().nextInt(11);
          pressure3 = widget.normalPressureMin + Random().nextInt((widget.normalPressureMax - widget.normalPressureMin) + 3);
          temperature3 = 80 + Random().nextInt(11);
        }
      }
    });

    if (!isNormal(pressure, temperature) ||
        !isNormal(pressure1, temperature1) ||
        (_getNumberOfWheels(widget.selectedVehicleIcon) > 2 && !isNormal(pressure2, temperature2)) ||
        (_getNumberOfWheels(widget.selectedVehicleIcon) > 3 && !isNormal(pressure3, temperature3))) {
      final player = AudioCache();
      player.load('alert.mp3');
      final playerreal = AudioPlayer();
      playerreal.play((AssetSource('alert.mp3')));
    }

    _elapsedTimeInSeconds += 3; // Increment the elapsed time
  }


  bool isNormal(int pressure, int temperature) {
    return (pressure >= widget.normalPressureMin && pressure <= widget.normalPressureMax) && (temperature >= 80 && temperature <= 90);
  }

  Widget _buildCounterImage(int number, int pressure, int temperature) {
    String imagePath = 'assets/counter.png';
    bool isNormal = (pressure >= widget.normalPressureMin && pressure <= widget.normalPressureMax) && (temperature >= 80 && temperature <= 90);

    return Stack(
      children: [
        Image.asset(
          imagePath,
          width: 180,
          fit: BoxFit.contain,
        ),
        Positioned(
          top: 18,
          left: 45,
          child: Text(
            '${temperature.toStringAsFixed(0)}°C\n${pressure.toStringAsFixed(0)}PSI\n${isNormal ? 'Normal' : 'Warning'}',
            style: TextStyle(
              color: isNormal ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButtonWithLabel(IconData icon, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: Colors.white, size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VehiclePage(),
                ));
          },
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white,fontSize: 10, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  String _getImagePath(String icon) {
    // Map each vehicle icon to its corresponding image path
    switch (icon) {
      case "assets/bikeIcon.png":
        return 'assets/bike.png'; // Replace with actual image path
      case "assets/motorIcon.png":
        return 'assets/motor.png'; // Replace with actual image path
      case "assets/trikeIcon.png":
        return 'assets/trike.png'; // Replace with actual image path
      case "assets/jeepIcon.png":
        return 'assets/jeep.png'; // Replace with actual image path
      case "assets/sedanIcon.png":
        return 'assets/car.png'; // Replace with actual image path
      case "assets/truckIcon.png":
        return 'assets/truck.png'; // Replace with actual image path
      default:
        return '';
    }
  }

  int _getNumberOfWheels(String icon) {
    switch (icon) {
      case "assets/bikeIcon.png":
      case "assets/motorIcon.png":
        return 2;
      case "assets/trikeIcon.png":
        return 3;
      default:
        return 4;
    }
  }
}

class VehiclePage extends StatelessWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          const Padding(
            padding: EdgeInsets.all(40.0),
            child: Text(
              'Select Your Vehicle',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: const [
                VehicleCard(icon: 'assets/bikeIcon.png', normalPressureMin: 15, normalPressureMax: 25),
                VehicleCard(icon: 'assets/motorIcon.png', normalPressureMin: 28, normalPressureMax: 40),
                VehicleCard(icon: 'assets/trikeIcon.png', normalPressureMin: 30, normalPressureMax: 36),
                VehicleCard(icon: "assets/jeepIcon.png", normalPressureMin: 40, normalPressureMax: 41),
                VehicleCard(icon: "assets/sedanIcon.png", normalPressureMin: 38, normalPressureMax: 51),
                VehicleCard(icon: "assets/truckIcon.png", normalPressureMin: 50, normalPressureMax: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final String icon;
  final int normalPressureMin;
  final int normalPressureMax;

  const VehicleCard({
    Key? key,
    required this.icon,
    required this.normalPressureMin,
    required this.normalPressureMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TireSureHome(
                  selectedVehicleIcon: icon,
                  normalPressureMin: normalPressureMin,
                  normalPressureMax: normalPressureMax,
                ),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromRGBO(174, 170, 170, 1),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.all(7),
            child: Image.asset(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}
