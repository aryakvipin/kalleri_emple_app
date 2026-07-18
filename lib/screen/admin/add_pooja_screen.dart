import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalleri_emple_app/screen/admin/widgets/bottom_nav.dart';

import '../../utils/AppBackground.dart';

import 'dashboard_screen.dart';
import 'bookings_screen.dart';
import 'gallery_screen.dart';
import 'profile_screen.dart';

class AddPoojaScreen extends StatefulWidget {
  final bool embedded;
  const AddPoojaScreen({super.key, this.embedded = false});

  @override
  State<AddPoojaScreen> createState() => _AddPoojaScreenState();
}

class _AddPoojaScreenState extends State<AddPoojaScreen> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  String? _category;
  String? _duration;
  bool _activeStatus = true;

  bool _isSaving = false;

  // This screen represents index 1 (Pooja) in the bottom nav.
  static const int _navIndex = 1;

  final CollectionReference _poojaCollection =
  FirebaseFirestore.instance.collection('poojas');

  final _categories = const [
    'Homam',
    'Vellatt',
    'Dhanam',
    'Special Pooja',
  ];
  final _durations = const [
    '15 mins',
    '30 mins',
    '1 hour',
    '2+ hours',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _savePooja() async {
    final name = _nameController.text.trim();
    final amountText = _amountController.text.trim();
    final description = _descController.text.trim();

    if (name.isEmpty) {
      _showMessage("Enter a pooja name");
      return;
    }

    if (_category == null) {
      _showMessage("Select a category");
      return;
    }

    final amount = double.tryParse(amountText);

    if (amount == null) {
      _showMessage("Enter a valid amount");
      return;
    }

    if (_duration == null) {
      _showMessage("Select a duration");
      return;
    }

    setState(() => _isSaving = true);

    try {
      await _poojaCollection.add({
        'name': name,
        'category': _category,
        'amount': amount,
        'description': description,
        'duration': _duration,
        'activeStatus': _activeStatus,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _showMessage("Pooja offering saved");
      _discardDraft(popAfter: !widget.embedded);
    } catch (e) {
      if (!mounted) return;
      _showMessage("Could not save pooja. Please try again.");
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _discardDraft({bool popAfter = false}) {
    _nameController.clear();
    _amountController.clear();
    _descController.clear();
    setState(() {
      _category = null;
      _duration = null;
      _activeStatus = true;
    });

    if (popAfter && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Shared bottom-nav routing: index 0 (Home) pops back to the first
  /// route (the DashboardScreen); every other tab swaps to its peer
  /// screen via pushReplacement so screens don't stack up.
  void _onNavTap(int index) {
    if (index == _navIndex) return;

    if (index == 0) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    Widget target;
    switch (index) {
      case 2:
        target = const BookingsScreen(embedded: false);
        break;
      case 3:
        target = const AdminGalleryPage(embedded: false);
        break;
      case 4:
        target = const AdminProfileScreen(embedded: false);
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => target),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        automaticallyImplyLeading: !widget.embedded,
        title: const Text('Add Pooja'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sanctified Offering Registration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.maroon,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Prepare a new sacred ritual for the devotees by filling in the '
                  'traditional details below.',
              style: TextStyle(fontSize: 13, color: AppColors.textGrey),
            ),
            const SizedBox(height: 20),

            const _FieldLabel('Pooja Image  (Optional but recommended)'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // TODO: wire up Firebase Storage image upload here, then
                // store the resulting download URL in an 'imageUrl' field
                // on the pooja document when saving.
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: AppColors.creamCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.maroon.withOpacity(0.3),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                      child:
                      const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text('Tap to upload a sacred visual',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('Recommended size: 1200x675px',
                        style: TextStyle(
                            fontSize: 11, color: AppColors.textGrey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            const _FieldLabel('Pooja Name'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration:
              const InputDecoration(hintText: 'e.g. Maha Ganapathi Homam'),
            ),
            const SizedBox(height: 18),

            const _FieldLabel('Category'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _category,
              hint: const Text('Select category'),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v),
            ),
            const SizedBox(height: 18),

            const _FieldLabel('Amount (₹)'),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '0.00'),
            ),
            const SizedBox(height: 18),

            const _FieldLabel('Description'),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Briefly describe the significance and steps of '
                    'this ritual...',
              ),
            ),
            const SizedBox(height: 18),

            const _FieldLabel('Duration'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _duration,
              hint: const Text('Select duration'),
              items: _durations
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(() => _duration = v),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _activeStatus,
                onChanged: (v) => setState(() => _activeStatus = v),
                activeColor: AppColors.gold,
                title: const Text('Active Status',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Visible to devotees immediately',
                    style: TextStyle(fontSize: 12)),
              ),
            ),
            const SizedBox(height: 28),

            ElevatedButton.icon(
              onPressed: _isSaving ? null : _savePooja,
              icon: _isSaving
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.save_outlined, size: 18),
              label: Text(_isSaving ? 'Saving...' : 'Save Pooja Offering'),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: _isSaving ? null : () => _discardDraft(),
                child: const Text(
                  'Discard Draft',
                  style: TextStyle(color: AppColors.textGrey),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.embedded
          ? null
          : AdminBottomNavBar(
        selectedIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }
}