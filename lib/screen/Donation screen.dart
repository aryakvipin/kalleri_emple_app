import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/AppBackground.dart';
import 'Booking success screen.dart';





class Donationpage extends StatelessWidget {
  const Donationpage({super.key});

  @override
  Widget build(BuildContext context) {
    // No nested MaterialApp here — this screen is pushed inside the
    // existing app's Navigator, so wrapping it in a second MaterialApp
    // would create a duplicate widget tree that can disconnect it from
    // ancestors (Firebase/auth providers, existing theme, etc.).
    return const DonationScreen();
  }
}
class DonationCategory {
  final String label;
  final IconData icon;
  const DonationCategory(this.label, this.icon);
}

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final List<DonationCategory> _categories = const [
    DonationCategory('Annadanam', Icons.restaurant),
    DonationCategory('Renovation', Icons.account_balance),
    DonationCategory('General Fund', Icons.description_outlined),
  ];

  final List<int> _amounts = const [501, 1001, 5001, 10001];

  int _selectedCategory = 0;
  int? _selectedAmount = 501;

  bool _isSubmitting = false;

  final TextEditingController _customAmountController =
  TextEditingController(text: '500');
  final TextEditingController _nameController = TextEditingController();

  final Map<String, String> _nakshatrams = const {
    "Ashwathi": "അശ്വതി",
    "Bharani": "ഭരണി",
    "Karthika": "കാർത്തിക",
    "Rohini": "രോഹിണി",
    "Makayiram": "മകയിരം",
    "Thiruvathira": "തിരുവാതിര",
    "Punartham": "പുണർതം",
    "Pooyam": "പൂയം",
    "Ayilyam": "ആയില്യം",
    "Makam": "മകം",
    "Pooram": "പൂരം",
    "Uthram": "ഉത്രം",
    "Atham": "അത്തം",
    "Chithira": "ചിത്തിര",
    "Chothi": "ചോതി",
    "Vishakham": "വിശാഖം",
    "Anizham": "അനിഴം",
    "Thrikketta": "തൃക്കേട്ട",
    "Moolam": "മൂലം",
    "Pooradam": "പൂരാടം",
    "Uthradam": "ഉത്രാടം",
    "Thiruvonam": "തിരുവോണം",
    "Avittam": "അവിട്ടം",
    "Chathayam": "ചതയം",
    "Pooruruttathi": "പൂരുരുട്ടാതി",
    "Uthrattathi": "ഉത്രട്ടാതി",
    "Revathi": "രേവതി",
  };
  String? _selectedNakshatram;

  @override
  void dispose() {
    _customAmountController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategorySelector(),
                    const SizedBox(height: 24),
                    _buildAmountSection(),
                    const SizedBox(height: 24),
                    _buildPersonalDetailsSection(),
                    const SizedBox(height: 20),
                    _buildTrustRow(),
                    const SizedBox(height: 6),
                    Text(
                      'Your contributions are used directly for temple '
                          'activities and community service. All transactions '
                          'are encrypted.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDonateButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(28),
        bottomRight: Radius.circular(28),
      ),
      child: Container(
        height: 250,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkMaroon, Color(0xFF2A0505)],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background glow (stand-in for a temple photo).
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.6, 0.4),
                    radius: 1.2,
                    colors: [
                      AppColors.gold.withOpacity(0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      const Text(
                        'Donations',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 4),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.12),
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Support the Sacred\nMission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      '"Giving is not just about making a donation. '
                          'It is about making a difference." Experience '
                          'the divine merit of Seva.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12.5,
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Row(
      children: List.generate(_categories.length, (index) {
        final category = _categories[index];
        final selected = _selectedCategory == index;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == _categories.length - 1 ? 0 : 8,
            ),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selected ? AppColors.lightPink : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? AppColors.maroon : Colors.black12,
                    width: selected ? 1.4 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      category.icon,
                      color: AppColors.maroon,
                      size: 22,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      category.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DONATION AMOUNT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.6,
          children: _amounts.map((amount) {
            final selected = _selectedAmount == amount;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAmount = amount;
                  _customAmountController.text = amount.toString();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? AppColors.maroon : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected ? AppColors.maroon : AppColors.gold,
                    width: 1.2,
                  ),
                ),
                child: Text(
                  '₹$amount',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColors.textDark,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _customAmountController,
          keyboardType: TextInputType.number,
          onChanged: (_) => setState(() => _selectedAmount = null),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 8),
              child: Text(
                '₹',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: AppColors.lightPink,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.maroon.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'PERSONAL DETAILS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.maroon,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '(Optional)',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textGrey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Devotee Name',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Full Name',
              hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 13),
              filled: true,
              fillColor: AppColors.lightPink,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Nakshatram (Star)',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedNakshatram,
                hint: const Text(
                  'Select Star',
                  style: TextStyle(color: AppColors.textGrey, fontSize: 13),
                ),
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey),
                items: _nakshatrams.entries
                    .map((entry) => DropdownMenuItem(
                  value: entry.key,
                  child: Text(
                    "${entry.key} (${entry.value})",
                    style: const TextStyle(fontSize: 13),
                  ),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedNakshatram = value),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.verified_user_outlined, size: 14, color: AppColors.textGrey),
        SizedBox(width: 4),
        Text('Secure Payment', style: TextStyle(fontSize: 11.5, color: AppColors.textGrey)),
        SizedBox(width: 14),
        Icon(Icons.account_balance_outlined, size: 14, color: AppColors.textGrey),
        SizedBox(width: 4),
        Text('80G Tax Benefits', style: TextStyle(fontSize: 11.5, color: AppColors.textGrey)),
      ],
    );
  }

  /// Fetches the logged-in user's stored name from `users/{uid}`
  /// (fullName field) to save alongside the donation record, separate
  /// from the "Devotee Name" the person typed in for this specific
  /// donation (which may be for someone else, e.g. a family member).
  Future<String> _fetchAccountUserName(User user) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final name = doc.data()?['fullName'] as String?;
      if (name != null && name.trim().isNotEmpty) return name.trim();
    } catch (_) {
      // fall through to other fallbacks below
    }

    if ((user.displayName ?? '').trim().isNotEmpty) {
      return user.displayName!.trim();
    }
    return user.email ?? "Devotee";
  }

  Future<void> _submitDonation(BuildContext context) async {
    if (_isSubmitting) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please sign in to donate.")),
      );
      return;
    }

    final amountValue = _selectedAmount ??
        int.tryParse(_customAmountController.text.trim());

    if (amountValue == null || amountValue <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount.")),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final accountUserName = await _fetchAccountUserName(user);
      final devoteeName = _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : accountUserName;

      final docRef = await FirebaseFirestore.instance.collection('donations').add({
        'category': _categories[_selectedCategory].label,
        'amount': amountValue,
        'uid': user.uid,
        'userName': accountUserName,
        'devoteeName': devoteeName,
        'nakshatram': _selectedNakshatram,
        'nakshatramMalayalam':
        _selectedNakshatram != null ? _nakshatrams[_selectedNakshatram] : null,
        'createdAt': Timestamp.now(),
        'status': 'pending',
      });

      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BookingSuccessScreen(
            donationId: docRef.id,
            categoryLabel: _categories[_selectedCategory].label,
            categoryIcon: _categories[_selectedCategory].icon,
            amount: amountValue.toString(),
            date: '23 May 2025, Saturday',
            timeSlot: '06:00 AM - 07:00 AM',
          ),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Donation failed to save. Please try again.")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Widget _buildDonateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.maroon,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        icon: _isSubmitting
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Icon(Icons.volunteer_activism, color: Colors.white, size: 20),
        label: Text(
          _isSubmitting ? 'Processing...' : 'Donate Now',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        onPressed: _isSubmitting ? null : () => _submitDonation(context),
      ),
    );
  }
}