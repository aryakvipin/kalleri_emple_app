import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/AppBackground.dart';

/// Matches the "Add Images" mockup — but every field (EVENT NAME,
/// START DATE, END DATE, DESCRIPTION) and the "Save Event" button
/// point to this being an event-creation form, so that's what it does:
/// it writes a new doc to the `events` collection. Header text kept as
/// "Add Images" to match the screenshot exactly — rename it to
/// "Add Event" if that title was a mockup mistake.
///
/// Requires the `image_picker` and `firebase_storage` packages — add
/// them to pubspec.yaml if they aren't already there, and make sure
/// iOS/Android photo-library permissions are set up (Info.plist /
/// AndroidManifest.xml) since ImagePicker needs them.
class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  File? _bannerFile;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickBanner() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _bannerFile = File(picked.path));
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: (isStart ? _startDate : _endDate) ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveEvent() async {
    if (_nameController.text.trim().isEmpty) {
      _showError('Please enter an event name.');
      return;
    }
    if (_startDate == null || _endDate == null) {
      _showError('Please select both a start and end date.');
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      _showError("End date can't be before the start date.");
      return;
    }

    setState(() => _isSaving = true);

    try {
      String? bannerUrl;
      if (_bannerFile != null) {
        final ref = FirebaseStorage.instance
            .ref('event_banners/${DateTime.now().millisecondsSinceEpoch}.jpg');
        await ref.putFile(_bannerFile!);
        bannerUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('events').add({
        'title': _nameController.text.trim(),
        'startDate': Timestamp.fromDate(_startDate!),
        'endDate': Timestamp.fromDate(_endDate!),
        'description': _descriptionController.text.trim(),
        'bannerUrl': bannerUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      _showError('Could not save event: $e');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamCard,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildBannerPicker(),
                    const SizedBox(height: 20),
                    _buildLabel('EVENT NAME'),
                    const SizedBox(height: 6),
                    _buildTextField(controller: _nameController, hint: 'Enter event name'),
                    const SizedBox(height: 16),
                    _buildLabel('START DATE'),
                    const SizedBox(height: 6),
                    _buildDateField(value: _startDate, onTap: () => _pickDate(isStart: true)),
                    const SizedBox(height: 16),
                    _buildLabel('END DATE'),
                    const SizedBox(height: 6),
                    _buildDateField(value: _endDate, onTap: () => _pickDate(isStart: false)),
                    const SizedBox(height: 16),
                    _buildLabel('DESCRIPTION'),
                    const SizedBox(height: 6),
                    _buildTextField(controller: _descriptionController, hint: 'Enter description', maxLines: 4),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.maroon,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 0,
                        ),
                        child: _isSaving
                            ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.4),
                        )
                            : const Text('Save Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.maroon, Color(0xFF4A0E0E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text('Add Images', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white70, width: 1.2)),
            child: const Icon(Icons.notifications_none, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerPicker() {
    return GestureDetector(
      onTap: _pickBanner,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFCEFEF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.maroon.withOpacity(0.3)),
        ),
        child: _bannerFile != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(_bannerFile!, fit: BoxFit.cover, width: double.infinity, height: 150),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, color: AppColors.maroon, size: 26),
            const SizedBox(height: 8),
            Text('Upload Banner', style: TextStyle(color: AppColors.maroon, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textGrey, letterSpacing: 0.5),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.maroon)),
      ),
    );
  }

  Widget _buildDateField({required DateTime? value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value != null ? _formatDate(value) : 'Select date',
                style: TextStyle(color: value != null ? Colors.black87 : Colors.grey, fontSize: 14),
              ),
            ),
            Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}