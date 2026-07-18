import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/AppBackground.dart';

/// Upload form for a single gallery photo or video thumbnail — reached
/// from AdminGalleryPage's "+ Upload Media" button. Writes a new doc
/// to the `gallery` collection (see AdminGalleryPage's schema comment)
/// and the file itself to Firebase Storage.
class AddMediaPage extends StatefulWidget {
  const AddMediaPage({super.key});

  @override
  State<AddMediaPage> createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  File? _file;
  String _type = 'photo'; // 'photo' | 'video'
  String _category = 'temple'; // 'temple' | 'festivals' | 'events'
  bool _isSaving = false;

  final _categories = const ['temple', 'festivals', 'events'];

  Future<void> _pickFile() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) {
      setState(() => _file = File(picked.path));
    }
  }

  Future<void> _save() async {
    if (_file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please choose an image first.')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final ref = FirebaseStorage.instance
          .ref('gallery/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(_file!);
      final url = await ref.getDownloadURL();

      // `order` just pushes new items to the end of their type/category
      // — swap for a manual field or drag-to-reorder later if you need
      // explicit control over ordering. Requires cloud_firestore's
      // aggregate-query support (count()) — bump the package if it's
      // an older version.
      final countSnapshot = await FirebaseFirestore.instance
          .collection('gallery')
          .where('type', isEqualTo: _type)
          .count()
          .get();

      await FirebaseFirestore.instance.collection('gallery').add({
        'imageUrl': url,
        'type': _type,
        'category': _category,
        'order': countSnapshot.count,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
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
                    _buildFilePicker(),
                    const SizedBox(height: 20),
                    _buildLabel('TYPE'),
                    const SizedBox(height: 6),
                    _buildTypeToggle(),
                    const SizedBox(height: 16),
                    _buildLabel('CATEGORY'),
                    const SizedBox(height: 6),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 28),
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
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
                            : const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
            child: Text('Upload Media', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFFCEFEF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.maroon.withOpacity(0.3)),
        ),
        child: _file != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(_file!, fit: BoxFit.cover, width: double.infinity, height: 150),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, color: AppColors.maroon, size: 26),
            const SizedBox(height: 8),
            Text('Upload Image', style: TextStyle(color: AppColors.maroon, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textGrey, letterSpacing: 0.5));
  }

  Widget _buildTypeToggle() {
    return Row(
      children: [
        _typeChip('Photo', 'photo'),
        const SizedBox(width: 10),
        _typeChip('Video', 'video'),
      ],
    );
  }

  Widget _typeChip(String label, String value) {
    final selected = _type == value;
    return GestureDetector(
      onTap: () => setState(() => _type = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.maroon : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: Colors.black12),
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600, fontSize: 13)),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _category,
          isExpanded: true,
          items: _categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c[0].toUpperCase() + c.substring(1))))
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => _category = value);
          },
        ),
      ),
    );
  }
}