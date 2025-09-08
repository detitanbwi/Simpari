import 'package:flutter/material.dart';
import 'package:Simpari/database/database_helper.dart';
import 'main_dashboard_screen.dart';
import 'guest_screen.dart'; // Import kembali ke halaman Guest Mode

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  // Controller untuk mengambil nilai dari TextField
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menangani login (sementara di-bypass)
  Future<void> _handleLogin() async {
    // DEV MODE: Inisialisasi dan prepopulate database
    await DatabaseHelper.instance.prepopulateDatabase();

    // Navigasi langsung ke MainDashboardScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainDashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mendapatkan tinggi dan lebar layar
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        // Padding responsif, misalnya 5% dari lebar layar
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          // Tambahkan SingleChildScrollView agar tidak error jika keyboard muncul
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer untuk menyesuaikan posisi vertikal
              SizedBox(height: screenHeight * 0.05),

              // Bagian Logo (Sama seperti sebelumnya, tapi bisa diatur ukurannya juga)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_universitas_jember.png',
                    height: screenHeight * 0.06,
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Image.asset(
                    'assets/images/logo_pemerintah_kabupaten_bondowoso.png',
                    height: screenHeight * 0.06,
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Bagian Ilustrasi
              Image.asset(
                'assets/images/tax-illustration.png',
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.02),

              // Bagian Teks "Selamat datang!"
              const Text(
                'Selamat datang!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),

              // Input NIK
              TextField(
                controller: _nikController,
                decoration: InputDecoration(
                  hintText: 'NIK',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Input Kata sandi
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kata sandi',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Checkbox "Ingat saya"
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _rememberMe = newValue!;
                      });
                    },
                  ),
                  const Text('Ingat saya'),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),

              // Tombol "Masuk"
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07, // Ukuran tombol responsif
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Teks "Anda bukan petugas pemungut?"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Anda bukan petugas pemungut? ',
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Guest Mode
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GuestScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'klik disini',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nikController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
