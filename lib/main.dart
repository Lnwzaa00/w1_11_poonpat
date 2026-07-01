import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ข้อมูลโปรไฟล์
  final String username = '5555 เบต้าเทสเตอร์งั้นหรอ';
  final String fullName = 'พูลพัฒน์ มีสุข';
  final String bio =
      'นักศึกษาแผนกเทคโนโลยีสารสนเทศ\nไม่หลงใหลในการเขียน Flutter 👽👽';
  final int postCount = 6;
  final String followerCount = '24';
  final int followingCount = 327;


  final List<String> postImages = [
    'https://i.pinimg.com/736x/35/e4/50/35e45062dc72cc36813c01abc4de4ae5.jpg',
    'https://i.pinimg.com/736x/1c/48/8f/1c488f5b662c7c7d9f8832774c6f01eb.jpg',
    'https://i.pinimg.com/736x/07/b7/e4/07b7e4edc2417d93cf6d42620a5dbe0a.jpg',
    'https://i.pinimg.com/736x/90/c9/5b/90c95b264cf46f09f836d4170ed8a3e1.jpg',
    'https://i.pinimg.com/736x/3a/3a/12/3a3a1227e4f146ee8614f953db295e2d.jpg',
    'https://i.pinimg.com/736x/14/9e/41/149e41c42d2638287744445c66d53cd7.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Bar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Header(),
            ),
          ];
        },
        body: Column(
          children: [
            buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildPostGrid(),
                  _buildTaggedGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  AppBar Bar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Text(
        username,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  // ส่วนหัวโปรไฟล์
  Widget Header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              ProflieAvatar(),
              const SizedBox(width: 24),
              Expanded(child: _buildStats()),
            ],
          ),
          const SizedBox(height: 12),

          // ชื่อและไบโอ
          Text(
            fullName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            bio,
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),

          ActionButton(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // รูปโปรไฟล์วงกลม
  Widget ProflieAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/harf.png",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 80,
            height: 80,
            color: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 40, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // สถิติ: โพสต์ / ผู้ติดตาม / กำลังติดตาม
  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildStatItem(postCount.toString(), 'โพสต์'),
        buildStatItem(followerCount, 'ผู้ติดตาม'),
        buildStatItem(followingCount.toString(), 'กำลังติดตาม'),
      ],
    );
  }

  Widget buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }

  // ปุ่ม ติดตาม และ ข้อความ
  Widget ActionButton() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ติดตาม',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 34,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'ข้อความ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // TabBar: กริด / แท็ก
  Widget buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1.5,
      tabs: const [
        Tab(icon: Icon(Icons.grid_on, color: Colors.black, size: 24)),
        Tab(icon: Icon(Icons.person_pin_outlined, color: Colors.grey, size: 24)),
      ],
    );
  }

  // กริดโพสต์
  Widget _buildPostGrid() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: postImages.length,
      itemBuilder: (context, index) {
        return Image.network(
          postImages[index],
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, color: Colors.grey),
          ),
        );
      },
    );
  }

  // กริดแท็ก (ว่างเปล่า)
  Widget _buildTaggedGrid() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_pin_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'ยังไม่มีรูปภาพที่ถูกแท็ก',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}