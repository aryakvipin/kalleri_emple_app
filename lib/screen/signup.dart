import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loginscreen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // Tracks whether a signup request is in flight, so we can disable the
  // button and show a spinner instead of letting the user double-submit.
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  /// Creates the Firebase Auth account, then writes the devotee's profile
  /// into the `users` collection using the new UID as the document ID.
  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final uid = credential.user!.uid;

      // Save the extra profile fields Firebase Auth doesn't store itself
      // (full name, phone) into Firestore under users/{uid}.
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        // WARNING: storing the raw password here is a security risk.
        // Firebase Auth already stores it securely and is the only thing
        // that needs it to verify logins. Anyone with read access to this
        // collection (misconfigured rules, leaked API keys, console access)
        // will see every user's password in plain text. Lock down your
        // Firestore security rules tightly on this collection if you keep this.
        'password': passwordController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Optional but recommended: also set the display name on the Auth
      // user itself, so it's available anywhere you read FirebaseAuth
      // .instance.currentUser without a Firestore round-trip.
      await credential.user!.updateDisplayName(nameController.text.trim());

      if (!mounted) return;

      Get.snackbar(
        'Welcome',
        'Account created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );

      // Navigate to login (or swap this for your home/dashboard route
      // if you want new users to skip straight past login).
      Get.off(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      final message = switch (e.code) {
        'email-already-in-use' => 'An account already exists for that email.',
        'invalid-email' => 'That email address looks invalid.',
        'weak-password' => 'Password is too weak.',
        _ => e.message ?? 'Something went wrong. Please try again.',
      };

      if (!mounted) return;
      Get.snackbar(
        'Sign up failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Sign up failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: const Color(0xFF7B100C),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9E1711),
              Color(0xFF7B100C),
              Color(0xFF5B0000),
              Color(0xFF8E120D),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 5,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 10,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BACK BUTTON
                        SizedBox(
                          height: 30,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),

                        // MALAYALAM TITLE
                        const Center(
                          child: Text(
                            "ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ\nക്ഷേത്രം",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              height: 1.1,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black38,
                                  offset: Offset(1, 2),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 2),

                        // ENGLISH TITLE
                        const Center(
                          child: Text(
                            "Sree Kalleri Kuttichathan Kshethram",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 3),

                        // GOD IMAGE + LAMPS
                        SizedBox(
                          height: 85,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/god1.png",
                                height: 82,
                                fit: BoxFit.contain,
                              ),

                              Positioned(
                                left: 25,
                                bottom: 3,
                                child: Image.asset(
                                  "assets/images/lambb.png",
                                  width: 28,
                                ),
                              ),

                              Positioned(
                                right: 25,
                                bottom: 3,
                                child: Image.asset(
                                  "assets/images/lambb.png",
                                  width: 28,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 3),

                        // CREATE ACCOUNT TITLE
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Text(
                          "Begin your sacred journey with us",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // FULL NAME
                        _inputField(
                          controller: nameController,
                          label: "FULL NAME",
                          hint: "Enter your full name",
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final name = value?.trim() ?? "";

                            if (name.isEmpty) {
                              return "Please enter your full name";
                            }

                            if (name.length < 3) {
                              return "Name must contain at least 3 characters";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 7),

                        // PHONE NUMBER
                        _inputField(
                          controller: phoneController,
                          label: "PHONE NUMBER",
                          hint: "Enter your phone number",
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          validator: (value) {
                            final phone = value?.trim() ?? "";

                            if (phone.isEmpty) {
                              return "Please enter your phone number";
                            }

                            if (!RegExp(r'^[6-9][0-9]{9}$')
                                .hasMatch(phone)) {
                              return "Please enter a valid phone number";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 7),

                        // EMAIL
                        _inputField(
                          controller: emailController,
                          label: "EMAIL",
                          hint: "Enter your email",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            final email = value?.trim() ?? "";

                            if (email.isEmpty) {
                              return "Please enter your email";
                            }

                            if (!GetUtils.isEmail(email)) {
                              return "Please enter a valid email";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 7),

                        // PASSWORD
                        _inputField(
                          controller: passwordController,
                          label: "PASSWORD",
                          hint: "Create your password",
                          icon: Icons.lock_outline,
                          obscure: obscurePassword,
                          textInputAction: TextInputAction.next,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }

                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 7),

                        // CONFIRM PASSWORD
                        _inputField(
                          controller: confirmPasswordController,
                          label: "CONFIRM PASSWORD",
                          hint: "Confirm your password",
                          icon: Icons.lock_outline,
                          obscure: obscureConfirmPassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureConfirmPassword =
                                !obscureConfirmPassword;
                              });
                            },
                            icon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }

                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // CREATE ACCOUNT BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton(
                            onPressed: isLoading ? null : _handleSignUp,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.4,
                              ),
                            )
                                : const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CREATE ACCOUNT",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 2),

                        // LOGIN NAVIGATION
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 2,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 8,
                                  ),
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Get.off(() => LoginPage());
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool obscure = false,
    Widget? suffixIcon,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 3),

        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLength: maxLength,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            isDense: true,
            hintStyle: const TextStyle(
              color: Colors.white60,
              fontSize: 13,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 42,
              minHeight: 40,
            ),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 42,
              minHeight: 40,
            ),
            errorMaxLines: 1,
            errorStyle: const TextStyle(
              color: Color(0xFFFFD6D6),
              fontSize: 10,
              height: 1,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFFFD6D6),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFFFD6D6),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}