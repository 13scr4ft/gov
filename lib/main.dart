import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const GovWalletDemoApp());
}

class GovWalletDemoApp extends StatelessWidget {
  const GovWalletDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gov Wallet Demo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF073574),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0BA9E8),
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashScreen(), // App launches with the splash screen
    );
  }
}

class AppColors {
  static const navy = Color(0xFF06336E);
  static const deepNavy = Color(0xFF03285C);
  static const blue = Color(0xFF5FA4D8);
  static const cyan = Color(0xFF08A9E7);
  static const textCyan = Color(0xFF00AEEF);
  static const card = Color(0xFF244984);
  static const textMuted = Color(0xFFB4C8E4);
  static const white = Colors.white;
}

// ==========================================
// 1. SPLASH SCREEN (Full Screen Edge-to-Edge)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait 2.5 seconds, then fade smoothly into the HomeScreen
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) => const HomeScreen(),
            transitionsBuilder: (_, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash_logo.png',
          fit: BoxFit.cover, // Fills full screen edge-to-edge
        ),
      ),
    );
  }
}

// ==========================================
// 2. HOME SCREEN
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _WalletBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _topBar()),
                SliverToBoxAdapter(child: _identityCarousel()),
                SliverToBoxAdapter(child: _personalNumber()),
                SliverToBoxAdapter(
                  child: _sectionHeader('My wallet', 'Προβολή'),
                ),
                SliverToBoxAdapter(child: _walletRow()),
                SliverToBoxAdapter(child: _sectionDivider()),
                SliverToBoxAdapter(
                  child: _sectionHeader('Η θυρίδα μου', 'Προβολή'),
                ),
                SliverToBoxAdapter(child: _inboxRow()),
                SliverToBoxAdapter(child: _sectionDivider()),
                SliverToBoxAdapter(
                  child: _sectionHeader(
                    'Επίκαιρες υπηρεσίες',
                    'Όλες οι υπηρεσίες',
                  ),
                ),
                SliverToBoxAdapter(child: _servicesRow()),
                const SliverToBoxAdapter(child: SizedBox(height: 110)),
              ],
            ),
          ),
          Positioned(
            right: 18,
            bottom: 20,
            child: Container(
              width: 84,
              height: 84,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(.14),
                    Colors.white.withOpacity(0),
                  ],
                ),
              ),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: AppColors.cyan,
                foregroundColor: Colors.white,
                elevation: 8,
                onPressed: () => _showAddSheet(context),
                child: const Icon(Icons.add, size: 34),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 390;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 18 : 24,
        10,
        compact ? 12 : 16,
        8,
      ),
      child: Row(
        children: [
          const Icon(Icons.menu, size: 40, color: Colors.white),
          const SizedBox(width: 18),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: compact ? 31 : 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
                color: Colors.white,
              ),
              children: const [
                TextSpan(text: 'gov.'),
                TextSpan(
                  text: 'gr',
                  style: TextStyle(color: AppColors.textCyan),
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(
            'assets/icons/ai_assistant.png',
            width: compact ? 46 : 50,
            height: compact ? 46 : 50,
          ),
          SizedBox(width: compact ? 6 : 8),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: compact ? 21 : 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              children: const [
                TextSpan(text: 'mAi'),
                TextSpan(
                  text: 'gov',
                  style: TextStyle(color: AppColors.textCyan),
                ),
              ],
            ),
          ),
          SizedBox(width: compact ? 7 : 12),
          Image.asset(
            'assets/icons/notification.png',
            width: 52,
            height: 52,
          ),
        ],
      ),
    );
  }

  Widget _identityCarousel() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const IdentityScreen()),
            );
          },
          child: Container(
            height: MediaQuery.sizeOf(context).width < 390 ? 205 : 220,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width < 390 ? 18 : 18,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.18),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/id_card_header.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(24, 12, 22, 12),
                        child: Align(
                          alignment: Alignment.topLeft, // Left-aligned
                          child: Text(
                            'Δελτίο Ταυτότητας',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 5, 28, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'DEMO-4827',
                              style: TextStyle(
                                color: Color(0xFF252B34),
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Εκδόθηκε: 08/2026',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 120 - (86 * .3),
                  right: 22,
                  child: const _DemoAvatar(size: 86),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dot(true),
            const SizedBox(width: 6),
            _dot(false),
          ],
        ),
        const SizedBox(height: 22),
      ],
    );
  }

  Widget _dot(bool active) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white24,
          shape: BoxShape.circle,
        ),
      );

  Widget _personalNumber() {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Container(
      margin: EdgeInsets.fromLTRB(
        compact ? 18 : 18,
        0,
        compact ? 18 : 18,
        20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 20 : 28,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(
            'Προσωπικός Αριθμός',
            style: TextStyle(
              fontSize: compact ? 21 : 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(Icons.visibility_outlined, size: 32),
        ],
      ),
    );
  }

  Widget _sectionDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.white.withOpacity(.18),
      ),
    );
  }

  Widget _sectionHeader(String title, String action) {
    final compact = MediaQuery.sizeOf(context).width < 390;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        compact ? 18 : 18,
        6,
        compact ? 18 : 18,
        10,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: compact ? 22 : 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            action,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, size: 28, color: AppColors.cyan),
        ],
      ),
    );
  }

  Widget _walletRow() {
    return SizedBox(
      height: 132,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 390 ? 18 : 18,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _walletTile(
            Image.asset('assets/icons/tickets.png', fit: BoxFit.contain),
            'Εισιτήρια',
          ),
          _walletTile(
            Image.asset('assets/icons/my_auto.png', fit: BoxFit.contain),
            'My Auto',
          ),
          _walletTile(
            Image.asset('assets/icons/insurance.png', fit: BoxFit.contain),
            'Ασφαλιστική\nικανότητα',
          ),
          _emptyWalletTile(),
          _emptyWalletTile(),
        ],
      ),
    );
  }

  Widget _walletTile(Widget icon, String label) {
    return Container(
      width: 88,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: icon,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyWalletTile() {
    return Container(
      width: 88,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 2),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            ' ',
            style: TextStyle(fontSize: 12, height: 1.15),
          ),
        ],
      ),
    );
  }

  Widget _inboxRow() {
    return SizedBox(
      height: 228,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 390 ? 18 : 18,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _noticeCard(
            'Αξιολογήστε\nΥπηρεσίες της\nΔημόσιας Διοίκησης',
            '24/06/2026, 14:38',
          ),
          _noticeCard(
            'Αξιολογήστε\nΥπηρεσίες της\nΔημόσιας Διοίκησης',
            '13/06/2026, 10:13',
          ),
          _noticeCard(
            'Ενημέρωση\nΠροσωπικών\nΥπηρεσιών',
            '05/06/2026, 09:42',
          ),
        ],
      ),
    );
  }

  Widget _noticeCard(String title, String date) {
    return Container(
      width: MediaQuery.sizeOf(context).width < 390 ? 292 : 315,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.fromLTRB(24, 22, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'ΝΕΟ',
              style: TextStyle(
                color: AppColors.cyan,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 21, height: 1.35),
          ),
          const Spacer(),
          Text(
            date,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _servicesRow() {
    return SizedBox(
      height: 180,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 390 ? 18 : 28,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _serviceCard(
            '1. Βεβαίωση\nΕπιλεξιμότητας\nστη δράση\n«Ανακαίνιση Κατοικίας»',
          ),
          _serviceCard(
            '2. Υπεύθυνη\nΔήλωση /\nΕξουσιοδότηση /\nΓνήσιο Υπογραφής',
          ),
          _serviceCard('3. Αίτηση\nγια δημόσια\nυπηρεσία'),
        ],
      ),
    );
  }

  Widget _serviceCard(String text) {
    return Container(
      width: MediaQuery.sizeOf(context).width < 390 ? 292 : 315,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white12, width: 3),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, height: 1.35),
      ),
    );
  }

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navy,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Προσθήκη εγγράφου',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              _sheetAction(Icons.badge_outlined, 'Ταυτότητα'),
              _sheetAction(
                Icons.directions_car_outlined,
                'Άδεια οδήγησης',
              ),
              _sheetAction(
                Icons.credit_card_outlined,
                'Κάρτα / έγγραφο',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetAction(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(
        title,
        style: const TextStyle(fontSize: 19),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pop(context),
    );
  }
}

// ==========================================
// 3. IDENTITY DETAILS SCREEN
// ==========================================
class IdentityScreen extends StatelessWidget {
  const IdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _IdentityBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColors.blue,
                  elevation: 0,
                  centerTitle: true, // Top Middle alignment
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 32),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: const Text(
                    'Δελτίο Ταυτότητας',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.more_vert, size: 32),
                      onPressed: () => _showMenu(context),
                    ),
                  ],
                ),
                SliverToBoxAdapter(child: _identityHero()),
                SliverToBoxAdapter(child: _identityFields()),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _identityHero() {
    const heroHeight = 220.0;
    const avatarSize = 150.0;
    const avatarOverflow = 0.08;

    return SizedBox(
      height: heroHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: heroHeight,
            padding: const EdgeInsets.fromLTRB(28, 16, 178, 16),
            color: AppColors.blue,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Αριθμός ταυτότητας:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'DEMO-4827',
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Ημ. Έκδοσης:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '08/2026',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: heroHeight - avatarSize * (1 - avatarOverflow),
            right: 28,
            child: const _DemoAvatar(size: avatarSize),
          ),
        ],
      ),
    );
  }

  Widget _identityFields() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 0),
      child: Column(
        children: [
          _actionButtons(),
          const SizedBox(height: 32),
          _field('ΕΠΩΝΥΜΟ', 'ΔΗΜΟΠΟΥΛΟΣ'),
          _field('SURNAME', 'DEMOPOULOS'),
          _field('ΟΝΟΜΑ', 'ΝΙΚΟΣ'),
          _field('GIVEN NAME', 'NIKOS'),
          _field('ΟΝΟΜΑ ΠΑΤΕΡΑ', 'ΑΛΕΞΑΝΔΡΟΣ'),
          _field('ΟΝΟΜΑ ΜΗΤΕΡΑΣ (MOTHER’S NAME)', 'ΕΛΕΝΗ'),
          _field('ΗΜ. ΓΕΝΝΗΣΗΣ (DATE OF BIRTH)', '12/05/1998'),
          _field('ΤΟΠΟΣ ΓΕΝΝΗΣΗΣ (PLACE OF BIRTH)', 'ΑΘΗΝΑ'),
          _field(
            'ΑΡΧΗ ΕΚΔΟΣΗΣ (ISSUANCE OFFICE)',
            'Τ.Α. ΑΘΗΝΩΝ',
          ),
          const SizedBox(height: 20),
          const Text(
            'DEMO • Δεν αποτελεί επίσημο κρατικό έγγραφο',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _imageActionButton(
                'assets/images/add_to_wallet.png',
                () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _imageActionButton(
                'assets/images/copy_pdf.png',
                () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _imageActionButton(
                'assets/images/view_qr.png',
                () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _imageActionButton(
                'assets/images/quick_scan.png',
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _imageActionButton(
    String imagePath,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: SizedBox(
          height: 86,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              letterSpacing: .7,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navy,
      showDragHandle: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.qr_code_2),
                title: const Text('Προβολή QR κωδικού'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => const _DemoQrDialog(),
                  );
                },
              ),
              const ListTile(
                leading: Icon(Icons.verified_user_outlined),
                title: Text('Πληροφορίες εγγράφου'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. HELPER WIDGETS
// ==========================================
class _DemoQrDialog extends StatelessWidget {
  const _DemoQrDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('QR κωδικός • DEMO'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 210,
            height: 210,
            child: CustomPaint(
              painter: _QrPainter(),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Μη έγκυρος κωδικός επίδειξης',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Κλείσιμο'),
        ),
      ],
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black;
    final cell = size.width / 21;

    void square(int x, int y, int w, int h) {
      canvas.drawRect(
        Rect.fromLTWH(
          x * cell,
          y * cell,
          w * cell,
          h * cell,
        ),
        p,
      );
    }

    void finder(int ox, int oy) {
      square(ox, oy, 7, 7);
      final white = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(
          (ox + 1) * cell,
          (oy + 1) * cell,
          5 * cell,
          5 * cell,
        ),
        white,
      );
      square(ox + 2, oy + 2, 3, 3);
    }

    finder(0, 0);
    finder(14, 0);
    finder(0, 14);

    final seed = <int>[
      8, 0, 10, 1, 12, 2, 8, 3, 10, 4, 12, 5,
      8, 7, 9, 8, 11, 8, 13, 8, 8, 10, 10, 10,
      12, 11, 14, 10, 16, 11, 18, 9, 20, 10,
      9, 13, 11, 13, 13, 14, 15, 13, 17, 14,
      19, 13, 8, 16, 10, 17, 12, 16, 14, 18,
      16, 17, 18, 18, 20, 16, 9, 20, 11, 19,
      13, 20, 15, 20, 17, 19, 19, 20,
    ];

    for (var i = 0; i + 1 < seed.length; i += 2) {
      square(seed[i], seed[i + 1], 1, 1);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DemoAvatar extends StatelessWidget {
  final double size;

  const _DemoAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFE9EDF1),
        borderRadius: BorderRadius.circular(size * .18),
      ),
      child: Icon(
        Icons.person,
        size: size * .58,
        color: const Color(0xFF667384),
      ),
    );
  }
}

class _WalletBackground extends StatelessWidget {
  const _WalletBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/home_background.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _IdentityBackground extends StatelessWidget {
  const _IdentityBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/id_background.png',
        fit: BoxFit.cover,
      ),
    );
  }
}