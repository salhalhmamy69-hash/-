import 'package:flutter/material.dart';

void main() => runApp(const HackerApp());

// 🔑 الباسورد — يمكنك تغييره من هنا
const String kPassword = "hacker123";

class HackerApp extends StatelessWidget {
  const HackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        fontFamily: 'monospace',
      ),
      home: const GateScreen(),
    );
  }
}

// ===== الشاشة 1: الموافقة =====
class GateScreen extends StatelessWidget {
  const GateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.terminal, size: 90, color: Color(0xFF00FF9C)),
              const SizedBox(height: 24),
              const Text(
                "الأمام هكر قوي",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF9C),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "قبل الدخول عليك الموافقة:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF00FF9C)),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF161B22),
                ),
                child: const Text(
                  "أوافق على أن جهازي أصبح تحت سيطرة هذا التطبيق، "
                  "وأن المطوّر يعتبر نفسه هكراً قوياً جداً 😎\n"
                  "ولن أستطيع استخدام الجهاز قبل كتابة الباسورد.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, height: 1.6, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF9C),
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LockScreen()),
                    );
                  },
                  child: const Text("✅ أوافق، دخول"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== الشاشة 2: القفل (مع منع الرجوع) =====
class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final TextEditingController _controller = TextEditingController();
  String _status = "";
  bool _loading = false;

  void _tryUnlock() {
    setState(() {
      _loading = true;
      _status = "";
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (_controller.text == kPassword) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else {
        setState(() {
          _status = "ACCESS DENIED ❌";
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 70, color: Color(0xFF00FF9C)),
                const SizedBox(height: 20),
                const Text(
                  "🔒 الجهاز مقفول",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  "اكتب الباسورد لتجاوز القفل (كلمة المرور الافتراضية: hacker123)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _controller,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Color(0xFF00FF9C)),
                  decoration: InputDecoration(
                    hintText: "••••••",
                    filled: true,
                    fillColor: const Color(0xFF161B22),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onSubmitted: (_) => _tryUnlock(),
                ),
                const SizedBox(height: 16),
                Text(
                  _status,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF9C),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: _loading ? null : _tryUnlock,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.black)
                        : const Text("فتح", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

// ===== الشاشة 3: الشاشة الرئيسية =====
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم الهكر 🚀", style: TextStyle(color: Color(0xFF00FF9C))),
        backgroundColor: const Color(0xFF161B22),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock, color: Color(0xFF00FF9C)),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LockScreen()),
              );
            },
            tooltip: "قفل التطبيق",
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, size: 80, color: Color(0xFF00FF9C)),
              const SizedBox(height: 20),
              const Text(
                "ACCESS GRANTED ✅",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF9C),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "أهلاً بك أيها الهكر العبقري! لقد تخطيت النظام بنجاح.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LockScreen()),
                  );
                },
                icon: const Icon(Icons.lock),
                label: const Text("إعادة القفل", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
