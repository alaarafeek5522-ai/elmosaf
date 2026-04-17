import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elmosaf/screens/search_results_screen.dart';
import 'package:elmosaf/screens/favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = ['اسبرين', 'بنادول', 'بروفين', 'اموكسيسيلين'];

  void _search() {
    if (_searchController.text.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
            query: _searchController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'الموسعف 🏥',
                style: GoogleFonts.cairo(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                  );
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // شعار التطبيق
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1E3E3E), const Color(0xFF00897B)]
                          : [const Color(0xFF00897B), const Color(0xFF4DB6AC)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.medical_services,
                        size: 50,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ابحث عن دوائك بسهولة',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'اعرف السعر والتفاصيل في ثواني',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
                
                const SizedBox(height: 30),
                
                // حقل البحث
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: '🔍  اكتب اسم الدواء...',
                    hintStyle: GoogleFonts.cairo(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                  ),
                  onSubmitted: (_) => _search(),
                  textInputAction: TextInputAction.search,
                ).animate().fadeIn(delay: 200.ms).slideX(),
                
                const SizedBox(height: 15),
                
                // زر البحث
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _search,
                    icon: const Icon(Icons.search),
                    label: Text(
                      'بحث',
                      style: GoogleFonts.cairo(fontSize: 18),
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(),
                
                const SizedBox(height: 30),
                
                // عمليات البحث الأخيرة
                Text(
                  '🔍  عمليات بحث مقترحة',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 600.ms),
                
                const SizedBox(height: 15),
                
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _recentSearches.map((item) {
                    return ActionChip(
                      label: Text(item, style: GoogleFonts.cairo()),
                      avatar: const Icon(Icons.history, size: 16),
                      onPressed: () {
                        _searchController.text = item;
                        _search();
                      },
                    );
                  }).toList(),
                ).animate().fadeIn(delay: 800.ms),
                
                const SizedBox(height: 30),
                
                // مميزات التطبيق
                Text(
                  '✨  مميزات الموسعف',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(delay: 1000.ms),
                
                const SizedBox(height: 15),
                
                _buildFeatureCard(
                  icon: Icons.search,
                  title: 'بحث سريع',
                  subtitle: 'ابحث عن أي دواء في ثواني',
                  delay: 1200,
                ),
                
                _buildFeatureCard(
                  icon: Icons.favorite,
                  title: 'المفضلة',
                  subtitle: 'احفظ أدويتك المفضلة للرجوع إليها',
                  delay: 1400,
                ),
                
                _buildFeatureCard(
                  icon: Icons.share,
                  title: 'مشاركة النتائج',
                  subtitle: 'شارك تفاصيل الدواء مع أصدقائك',
                  delay: 1600,
                ),
                
                _buildFeatureCard(
                  icon: Icons.image,
                  title: 'صور الأدوية',
                  subtitle: 'شاهد صورة الدواء بوضوح عالي',
                  delay: 1800,
                ),
                
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int delay,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF00897B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF00897B)),
        ),
        title: Text(title, style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: GoogleFonts.cairo(fontSize: 12)),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX();
  }
}
