import 'package:flutter/material.dart';
import 'guest_screen.dart'; // Import halaman Guest Mode

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bagian Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ganti dengan path logo Anda
                Image.asset(
                  'assets/images/logo_universitas_jember.png',
                  height: 50,
                ),
                const SizedBox(width: 20),
                // Ganti dengan path logo Anda
                Image.asset(
                  'assets/images/logo_pemerintah_kabupaten_bondowoso.png',
                  height: 50,
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Bagian Ilustrasi
            Image.asset(
              'assets/images/tax-illustration.png', // Ganti dengan path ilustrasi Anda
              height: 250,
            ),
            const SizedBox(height: 50),

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
            const SizedBox(height: 10),
            const Text(
              'Sistem Pemungutan Pajak PBB yang cepat, akurat, dan transparan.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),

            // Tombol "Ayo mulai!"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman Guest Mode
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuestScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol sesuai desain
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Ayo mulai!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}