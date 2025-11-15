import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis UI/UX Flutter',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeMenu(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
      ),
    );
  }
}

// ============================================
// HOME MENU
// ============================================
class HomeMenu extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  HomeMenu({required this.isDarkMode, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuis UI/UX Flutter'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[400]!, Colors.indigo[700]!],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(Icons.quiz, size: 60, color: Colors.white),
                SizedBox(height: 12),
                Text('Latihan UI/UX',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text('GridView, Card & ListTile',
                    style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildMenuItem(
            context,
            'Soal 1: Grid Produk',
            'GridView dengan Card produk',
            Icons.grid_view,
            Colors.blue,
            () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => GridProdukPage())),
          ),
          _buildMenuItem(
            context,
            'Soal 2: Profil Mahasiswa',
            'Card profil dengan animasi',
            Icons.person,
            Colors.teal,
            () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => ProfileCardPage())),
          ),
          _buildMenuItem(
            context,
            'Soal 3: Daftar Kontak',
            'ListTile dengan status',
            Icons.contacts,
            Colors.indigo,
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ContactListPage(
                        isDarkMode: isDarkMode,
                        onToggleTheme: onToggleTheme))),
          ),
          _buildMenuItem(
            context,
            'Soal 4: Dashboard',
            'Kombinasi Multi-Widget',
            Icons.dashboard,
            Colors.deepPurple,
            () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => DashboardPage())),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, String subtitle,
      IconData icon, Color color, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13)),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

// ============================================
// SOAL 1: GRID PRODUK
// ============================================
class GridProdukPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Laptop Gaming',
      'price': 'Rp 15.000.000',
      'icon': Icons.laptop_mac
    },
    {
      'name': 'Smartphone Pro',
      'price': 'Rp 8.500.000',
      'icon': Icons.phone_android
    },
    {
      'name': 'Headphone Premium',
      'price': 'Rp 2.300.000',
      'icon': Icons.headphones
    },
    {'name': 'Smart Watch', 'price': 'Rp 3.200.000', 'icon': Icons.watch},
    {
      'name': 'Tablet Design',
      'price': 'Rp 6.700.000',
      'icon': Icons.tablet_mac
    },
    {
      'name': 'Camera DSLR',
      'price': 'Rp 12.500.000',
      'icon': Icons.camera_alt
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Soal 1: Grid Produk')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(
                context, products[index]['name'], products[index]['price'],
                products[index]['icon']);
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context, String name, String price, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 4))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('$name dipilih'))),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[400]!, Colors.blue[700]!]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, size: 40, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================
// SOAL 2: PROFIL MAHASISWA
// ============================================
class ProfileCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Soal 2: Profil Mahasiswa'),
          backgroundColor: Colors.teal[600]),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shadowColor: Colors.teal.withOpacity(0.3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.teal[50]!]),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.teal[400]!, Colors.teal[700]!]),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text('IK',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[700])),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Insan Kamil',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.badge, size: 16, color: Colors.teal[600]),
                      SizedBox(width: 6),
                      Text('221080200109',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 16, color: Colors.teal[600]),
                      SizedBox(width: 6),
                      Text('Teknik Informatika', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showDetailDialog(context),
                    icon: Icon(Icons.visibility),
                    label: Text('Lihat Detail'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[600],
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Detail Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: Insan Kamil'),
            SizedBox(height: 8),
            Text('NIM: 221080200109'),
            SizedBox(height: 8),
            Text('Prodi: Teknik Informatika'),
            SizedBox(height: 8),
            Text('Semester: 7'),
            SizedBox(height: 8),
            Text('IPK: 3.75'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Tutup')),
        ],
      ),
    );
  }
}

// ============================================
// SOAL 3: DAFTAR KONTAK
// ============================================
class ContactListPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  ContactListPage({required this.isDarkMode, required this.onToggleTheme});

  final List<Map<String, String>> contacts = [
    {'name': 'Insan Kamil', 'phone': '+62 812-3456-7890', 'status': 'Online'},
    {'name': 'Satria Kusumadewa', 'phone': '+62 813-4567-8901', 'status': 'Offline'},
    {'name': 'Muhammad Fikri Amin', 'phone': '+62 814-5678-9012', 'status': 'Away'},
    {'name': 'Mas Agung T.B', 'phone': '+62 815-6789-0123', 'status': 'Online'},
    {'name': 'Shendy Dwi H.', 'phone': '+62 816-7890-1234', 'status': 'Online'},
    {'name': 'Prima Mahardika', 'phone': '+62 817-8901-2345', 'status': 'Offline'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal 3: Daftar Kontak'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _buildContactCard(context, contacts[index]['name']!,
              contacts[index]['phone']!, contacts[index]['status']!);
        },
      ),
    );
  }

  Widget _buildContactCard(
      BuildContext context, String name, String phone, String status) {
    Color statusColor = status == 'Online'
        ? Colors.green[600]!
        : status == 'Away'
            ? Colors.orange[600]!
            : Colors.grey[600]!;

    String initials = name.split(' ').length >= 2
        ? '${name.split(' ')[0][0]}${name.split(' ')[1][0]}'
        : name[0];

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: isDarkMode ? 4 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.indigo[400],
              child: Text(initials,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: isDarkMode ? Color(0xFF121212) : Colors.white,
                      width: 2),
                ),
              ),
            ),
          ],
        ),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(phone, style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration:
                      BoxDecoration(color: statusColor, shape: BoxShape.circle),
                ),
                SizedBox(width: 6),
                Text(status,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: statusColor)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: Colors.indigo[600], size: 28),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Memanggil $name...'),
                backgroundColor: Colors.green[600],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================
// SOAL 4: DASHBOARD
// ============================================
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal 4: Dashboard'),
        backgroundColor: Colors.deepPurple[600],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple[600]!, Colors.deepPurple[400]!]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Selamat Datang!',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
                SizedBox(height: 4),
                Text('Insan Kamil',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('Kategori',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: [
                        _buildCategoryCard(
                            'E-Learning', Icons.school, Colors.blue),
                        _buildCategoryCard('Keuangan',
                            Icons.account_balance_wallet, Colors.green),
                        _buildCategoryCard(
                            'Tugas', Icons.assignment, Colors.orange),
                        _buildCategoryCard(
                            'Jadwal', Icons.calendar_today, Colors.purple),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('Ringkasan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStat('5', 'Tugas', Colors.green),
                            _buildStat('3', 'Kelas', Colors.blue),
                            _buildStat('2', 'Deadline', Colors.orange),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Text('Aktivitas',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          _buildActivityTile('Mengumpulkan Tugas UX',
                              '2 jam lalu', Icons.check_circle),
                          Divider(height: 1),
                          _buildActivityTile('Mengikuti Kelas Flutter',
                              '5 jam lalu', Icons.play_circle),
                          Divider(height: 1),
                          _buildActivityTile('Membaca Materi GridView',
                              '1 hari lalu', Icons.book),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              LinearGradient(colors: [color.withOpacity(0.7), color]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            SizedBox(height: 8),
            Text(name,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildActivityTile(String title, String time, IconData icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple[100],
        child: Icon(icon, color: Colors.deepPurple[600], size: 22),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(time, style: TextStyle(fontSize: 12)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}