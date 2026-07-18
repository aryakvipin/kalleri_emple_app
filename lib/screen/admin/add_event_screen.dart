import 'package:flutter/material.dart';

import '../../utils/AppBackground.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
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

  String _fmt(DateTime? d) {
    if (d == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Add Event'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: AppColors.confirmedGreenBg.withOpacity(0),
                  border: Border.all(
                    color: AppColors.maroon.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.camera_alt_outlined,
                        color: AppColors.maroon, size: 26),
                    SizedBox(height: 8),
                    Text(
                      'Upload Banner',
                      style: TextStyle(
                        color: AppColors.maroon,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const _Label('EVENT NAME'),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter event name'),
            ),
            const SizedBox(height: 18),

            const _Label('START DATE'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _pickDate(isStart: true),
              child: AbsorbPointer(
                child: TextField(
                  controller:
                      TextEditingController(text: _fmt(_startDate)),
                  decoration: const InputDecoration(
                    hintText: 'Select start date',
                    suffixIcon: Icon(Icons.calendar_month_outlined,
                        color: AppColors.textGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            const _Label('END DATE'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _pickDate(isStart: false),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: _fmt(_endDate)),
                  decoration: const InputDecoration(
                    hintText: 'Select end date',
                    suffixIcon: Icon(Icons.calendar_month_outlined,
                        color: AppColors.textGrey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            const _Label('DESCRIPTION'),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration:
                  const InputDecoration(hintText: 'Enter description'),
            ),
            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: AppColors.textGrey,
      ),
    );
  }
}
