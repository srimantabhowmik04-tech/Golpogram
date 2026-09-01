// ---------------------- LOGO SECTION ----------------------
Container(
  width: 90,
  height: 90,
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF00897B), Color(0xFF004D40)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(28),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF00897B).withOpacity(0.35),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'G',
        style: TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          height: 1.0,
          letterSpacing: -1,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        'GOLPOGRAM',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 1.2,
        ),
      ),
    ],
  ),
),
const SizedBox(height: 16),
const Text(
  'গল্প ও ভাবনার সহজ ঠিকানা',
  style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
),
// ----------------------------------------------------------
