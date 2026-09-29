import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // ตัวแปรเก็บค่าข้อมูล
  String temperature = "--";
  String humidity = "--";
  String appleCount = "0";
  String mangoCount = "0";
  String orangeCount = "0";
  bool isLoading = true;

  // URL ของ API ดึงข้อมูลล่าสุด (เปลี่ยนเป็น IP เครื่องคุณ)
  final String apiUrl = "http://10.194.51.189:8080/smart_farm/backend/api/get_latest.php";

  @override
  void initState() {
    super.initState();
    fetchData(); // ดึงข้อมูลตอนเปิดแอป
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          // ดึงค่าอุณหภูมิและความชื้น (ถ้าไม่มีให้แสดง --)
          temperature = data['temperature']?.toString() ?? "--";
          humidity = data['humidity']?.toString() ?? "--";
          
          // ดึงค่านับจำนวนผลผลิต (รองรับทั้งชื่อคีย์แบบย่อและเต็ม)
          appleCount = data['apple_count']?.toString() ?? data['apple']?.toString() ?? "0";
          mangoCount = data['mango_count']?.toString() ?? data['mango']?.toString() ?? "0";
          orangeCount = data['orange_count']?.toString() ?? data['orange']?.toString() ?? "0";
        });
      } else {
        debugPrint("Error: Failed to load data");
      }
    } catch (e) {
      debugPrint("Error connection: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌾 Smart Farm Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchData, // ปุ่มรีเฟรชข้อมูล
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("สภาพแวดล้อม", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildDataCard("อุณหภูมิ", "$temperature °C", Icons.thermostat, Colors.redAccent)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildDataCard("ความชื้น", "$humidity %", Icons.water_drop, Colors.blueAccent)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text("สต็อกผลผลิต (AI Detection)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildInventoryCard("🍎 แอปเปิล", appleCount, Colors.red[100]!),
                        _buildInventoryCard("🥭 มะม่วง", mangoCount, Colors.yellow[100]!),
                        _buildInventoryCard("🍊 ส้ม", orangeCount, Colors.orange[100]!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.sync, color: Colors.white),
      ),
    );
  }

  // Widget สำหรับสร้างการ์ดอุณหภูมิและความชื้น
  Widget _buildDataCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างการ์ดจำนวนผลไม้
  Widget _buildInventoryCard(String title, String count, Color bgColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(count, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87)),
            const Text("ชิ้น", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}