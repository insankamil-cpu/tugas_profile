// flutter_layout_main.dart
// Contoh desain layout bebas menggunakan Column dan Row
// Siap di-upload ke GitHub. Salin file ini ke /lib/main.dart dalam project Flutter.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Column & Row Layout',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final isWide = mq.size.width > 800; // breakpoint sederhana

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desain Layout - Column & Row'),
        centerTitle: true,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          // Parent Column yang menjadi tulang utama layout
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header: Row sederhana (avatar + title + button)
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Nama Proyek',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Deskripsi singkat proyek atau tagline')
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload'),
                  )
                ],
              ),

              const SizedBox(height: 12),

              // Seksi cards fitur: menggunakan Row di web/lebar, Wrap di sempit
              if (isWide) ...[
                Row(
                  children: const [
                    Expanded(child: FeatureCard(title: 'Design', icon: Icons.brush)),
                    SizedBox(width: 12),
                    Expanded(child: FeatureCard(title: 'Code', icon: Icons.code)),
                    SizedBox(width: 12),
                    Expanded(child: FeatureCard(title: 'Deploy', icon: Icons.cloud_upload)),
                  ],
                ),
              ] else ...[
                // pada layar sempit, tampilkan dalam 2 kolom menggunakan Wrap
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    SizedBox(width: 160, child: FeatureCard(title: 'Design', icon: Icons.brush)),
                    SizedBox(width: 160, child: FeatureCard(title: 'Code', icon: Icons.code)),
                    SizedBox(width: 160, child: FeatureCard(title: 'Deploy', icon: Icons.cloud_upload)),
                  ],
                ),
              ],

              const SizedBox(height: 12),

              // Konten utama: Row yang berisi area konten besar dan kolom samping
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Left: konten utama (menggunakan Column di dalamnya)
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Konten Utama',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Expanded(
                              // Grid sederhana: gunakan GridView.count di dalam Expanded
                              child: GridView.count(
                                crossAxisCount: isWide ? 2 : 1,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 3,
                                children: List.generate(
                                  4,
                                  (index) => Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('Item ${index + 1}',
                                                  style: const TextStyle(fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              const Text('Deskripsi singkat item ini.'),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_forward_ios, size: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right: sidebar dengan dua kotak vertikal
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Aktivitas Terbaru', style: TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: 6,
                                      itemBuilder: (context, i) => ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        leading: const Icon(Icons.check_circle_outline, size: 20),
                                        title: Text('Aktivitas ${i + 1}'),
                                        subtitle: const Text('Waktu • detail singkat'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 120,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Statistik Singkat', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Text('Pengunjung: 1.234\nUpload: 12'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Footer: Row dengan teks kecil dan beberapa tombol
              Row(
                children: [
                  const Expanded(child: Text('© 2025 - Nama Anda')),
                  TextButton(onPressed: () {}, child: const Text('Tentang')),
                  const SizedBox(width: 6),
                  TextButton(onPressed: () {}, child: const Text('Bantuan')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Komponen FeatureCard kecil
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const FeatureCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.indigo.shade100,
            child: Icon(icon, color: Colors.indigo.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Ringkasan fitur singkat', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
    );
  }
}
