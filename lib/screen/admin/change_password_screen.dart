import 'package:flutter/material.dart';

import '../../utils/AppBackground.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_newController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: const Text('Change Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Label('Current Password'),
            const SizedBox(height: 8),
            TextField(
              controller: _currentController,
              obscureText: true,
              decoration:
                  const InputDecoration(hintText: 'Enter current password'),
            ),
            const SizedBox(height: 18),

            const _Label('New Password'),
            const SizedBox(height: 8),
            TextField(
              controller: _newController,
              obscureText: !_showNew,
              decoration: InputDecoration(
                hintText: 'Enter new password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showNew
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textGrey,
                  ),
                  onPressed: () => setState(() => _showNew = !_showNew),
                ),
              ),
            ),
            const SizedBox(height: 18),

            const _Label('Confirm Password'),
            const SizedBox(height: 8),
            TextField(
              controller: _confirmController,
              obscureText: !_showConfirm,
              decoration: InputDecoration(
                hintText: 'Confirm new password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirm
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textGrey,
                  ),
                  onPressed: () =>
                      setState(() => _showConfirm = !_showConfirm),
                ),
              ),
            ),
            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: _submit,
              child: const Text('Update Password'),
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
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }
}
