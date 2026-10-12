import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// ---------- Palet warna (dark & light) ----------

class AppPalette {
  const AppPalette({
    required this.bgTop,
    required this.bgBottom,
    required this.accent,
    required this.onAccent,
    required this.text,
    required this.surface,
    required this.surfacePressed,
    required this.border,
    required this.navBg,
    required this.drawerBg,
  });

  final Color bgTop;
  final Color bgBottom;
  final Color accent;
  final Color onAccent;
  final Color text;
  final Color surface;
  final Color surfacePressed;
  final Color border;
  final Color navBg;
  final Color drawerBg;

  Color get textSoft => text.withValues(alpha: 0.7);
  Color get textMuted => text.withValues(alpha: 0.55);

  static final dark = AppPalette(
    bgTop: Colors.black,
    bgBottom: Colors.black,
    accent: const Color(0xFFFFB86B),
    onAccent: const Color(0xFF1B1F4B),
    text: Colors.white,
    surface: Colors.white.withValues(alpha: 0.07),
    surfacePressed: Colors.white.withValues(alpha: 0.12),
    border: Colors.white.withValues(alpha: 0.10),
    navBg: Colors.black,
    drawerBg: Colors.black,
  );

  static final light = AppPalette(
    bgTop: Colors.white,
    bgBottom: Colors.white,
    accent: Colors.black,
    onAccent: Colors.white,
    text: Colors.black,
    surface: Colors.white.withValues(alpha: 0.55),
    surfacePressed: Colors.white.withValues(alpha: 0.85),
    border: const Color(0xFF1B1F4B).withValues(alpha: 0.08),
    navBg: const Color(0xFFF3F1FF).withValues(alpha: 0.95),
    drawerBg: const Color(0xFFF1EFFF),
  );

  static AppPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}

// ---------- App ----------

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static const appTitle = 'Nexon App';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _mode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B5BD6);

    return MaterialApp(
      title: MyApp.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: _mode,
      themeAnimationDuration: const Duration(milliseconds: 350),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),
      home: MyHomePage(
        title: MyApp.appTitle,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onToggleTheme,
  });

  final String title;
  final VoidCallback onToggleTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const _HomeView(key: ValueKey(0));
      case 1:
        return const _StaticView(key: ValueKey(1));
      default:
        return const _ProfileView(key: ValueKey(2));
    }
  }

  Widget _drawerItem(
    AppPalette p,
    int index,
    IconData icon,
    String label,
  ) {
    final selected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        selected: selected,
        selectedColor: p.accent,
        selectedTileColor: p.accent.withValues(alpha: 0.12),
        iconColor: p.textSoft,
        textColor: p.textSoft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        onTap: () {
          _onItemTapped(index);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.bgTop, p.bgBottom],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: p.text,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          systemOverlayStyle:
              isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              tooltip: isDark ? 'Mode terang' : 'Mode gelap',
              onPressed: widget.onToggleTheme,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  key: ValueKey(isDark),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.03, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _buildPage(_selectedIndex),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: p.navBg,
            indicatorColor: p.accent.withValues(alpha: 0.18),
            elevation: 0,
            height: 68,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              final selected = states.contains(WidgetState.selected);
              return IconThemeData(
                color: selected ? p.accent : p.textMuted,
                size: 24,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final selected = states.contains(WidgetState.selected);
              return TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? p.accent : p.textMuted,
              );
            }),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: p.border)),
            ),
            child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart_rounded),
                  label: 'Statistic',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: p.drawerBg,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                        child: Row(
                          children: [
                            const SizedBox(width: 14),
                            Text(
                              'Nexon',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: p.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _drawerItem(p, 0, Icons.home_rounded, 'Home'),
                      _drawerItem(p, 1, Icons.bar_chart_rounded, 'Statistic'),
                      _drawerItem(p, 2, Icons.person_rounded, 'Profile'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: SwitchListTile(
                    value: isDark,
                    onChanged: (_) => widget.onToggleTheme(),
                    activeThumbColor: p.accent,
                    title: Text(
                      'Mode gelap',
                      style: TextStyle(
                        color: p.textSoft,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    secondary: Icon(
                      isDark
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                      color: p.textSoft,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- Halaman ----------

class _HomeView extends StatelessWidget {
  const _HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      physics: const BouncingScrollPhysics(),
      children: const [
        _Reveal(
          index: 0,
          child: _PageHeader(
            label: 'HOME',
            title: 'Selamat datang\ndi Nexon.',
            subtitle: 'Ringkasan singkat untuk hari ini.',
          ),
        ),
        _Reveal(
          index: 1,
          child: _InfoCard(
            icon: Icons.bolt_rounded,
            title: 'Task',
            value: 'Tingkatkan peluang keberhasilan akun kamu dengan menyelesaikan tugas.',
          ),
        ),
        _Reveal(
          index: 2,
          child: _InfoCard(
            icon: Icons.notifications_none_rounded,
            title: 'Pembaruan',
            value: 'Belum ada notifikasi baru.',
          ),
        ),
      ],
    );
  }
}

class _StaticView extends StatelessWidget {
  const _StaticView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      physics: const BouncingScrollPhysics(),
      children: const [
        _Reveal(
          index: 0,
          child: _PageHeader(
            label: 'Pendapatan',
            title: 'Rp.2.561.500',
            subtitle: 'real-time statistik information',
          ),
        ),
        _Reveal(
          index: 1,
          child: _InfoCard(
            icon: Icons.trending_up_rounded,
            title: 'Rata-Rata Views',
            value: '1.284.390',
          ),
        ),
        _Reveal(
          index: 2,
          child: _InfoCard(
            icon: Icons.check_circle_outline_rounded,
            title: 'Total Video Upload',
            value: '2.136',
          ),
        ),
        _Reveal(
          index: 3,
          child: _InfoCard(
            icon: Icons.schedule_rounded,
            title: 'Rata-rata Durasi Video',
            value: '4m 12d',
          ),
        ),
        _Reveal(
          index: 4,
          child: _InfoCard(icon: Icons.subscriptions_rounded, 
          title: 'Subscriber', 
          value: '68.901'),
          )
      ],
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      physics: const BouncingScrollPhysics(),
      children: [
        _Reveal(
          index: 0,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: p.accent.withValues(alpha: 0.16),
                  border: Border.all(color: p.accent, width: 2),
                ),
                child: Text(
                  'N',
                  style: TextStyle(
                    color: p.accent,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'The Shape of Town',
                style: TextStyle(
                  color: p.text,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'fikii0631@gmail.com',
                style: TextStyle(color: p.textMuted),
              ),
              const SizedBox(height: 4),
              Text(
                'LV.78 (Intermediate Level)',
                style: TextStyle(color: p.textMuted),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
        const _Reveal(
          index: 1,
          child: _InfoCard(
            icon: Icons.edit_outlined,
            title: 'Edit profil',
            value: 'Ubah nama dan foto.',
          ),
        ),
        const _Reveal(
          index: 2,
          child: _InfoCard(
            icon: Icons.lock_outline_rounded,
            title: 'Keamanan',
            value: 'Kata sandi dan sesi aktif.',
          ),
        ),
      ],
    );
  }
}

// ---------- Komponen ----------

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.label,
    required this.title,
    required this.subtitle,
  });

  final String label;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: text.labelLarge?.copyWith(
              color: p.accent,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: text.displaySmall?.copyWith(
              color: p.text,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: text.bodyLarge?.copyWith(color: p.textSoft),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatefulWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final text = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: _pressed ? p.surfacePressed : p.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: p.accent.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(widget.icon, color: p.accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: text.titleMedium?.copyWith(
                        color: p.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: text.bodyMedium?.copyWith(color: p.textSoft),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Fade + slide masuk bertahap. Main lagi tiap halaman berganti.
class _Reveal extends StatelessWidget {
  const _Reveal({required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 450 + index * 120),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}