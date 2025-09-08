import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login

class GuestScreen extends StatelessWidget {
  const GuestScreen({Key? key}) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Spacer untuk menyesuaikan posisi vertikal
              SizedBox(height: screenHeight * 0.05),

              // Bagian Logo
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
              SizedBox(height: screenHeight * 0.05),

              // Bagian Ilustrasi
              Image.asset(
                'assets/images/tax-illustration.png',
                height: screenHeight * 0.3,
              ),
              SizedBox(height: screenHeight * 0.05),

              // Bagian Teks
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
              const Text(
                'Sistem Pemungutan Pajak PBB yang cepat, akurat, dan transparan.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.03),

              // Input NOP
              TextField(
                decoration: InputDecoration(
                  hintText: 'Ketik NOP disini',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Tombol "Cek Pajak"
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implementasi logika cek pajak di sini
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Cek Pajak',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Teks "Anda petugas pemungut?"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Anda petugas pemungut? ',
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Login
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
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
}