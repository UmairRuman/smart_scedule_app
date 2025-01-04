import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validation/form_validation.dart';
import 'package:smart_club_app/pages/controllers/session_notifier.dart';

class NameTextField extends ConsumerWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTEC = ref.read(sessionProvider.notifier).nameTEC;
    return SizedBox(
      width: 100,
      child: Form(
        key: ref.read(sessionProvider.notifier).globalNameKey,
        child: TextFormField(
          validator: (value) {
            final validator = Validator(
              validators: [
                const RequiredValidator(),
                const MinLengthValidator(length: 4),
              ],
            );

            return validator.validate(
              label: "Name must be of minimum 4 characters",
              value: value,
            );
          },
          controller: nameTEC,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Your name",
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(Icons.person, color: Colors.tealAccent),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.tealAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () {
            // Ensure focus node is properly activated
          },
        ),
      ),
    );
  }
}

class KeyTextField extends ConsumerWidget {
  const KeyTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyTEC = ref.read(sessionProvider.notifier).keyTEC;
    return SizedBox(
      width: 100,
      child: Form(
        key: ref.read(sessionProvider.notifier).globalSessionKey,
        child: TextFormField(
          validator: (value) {
            final validator = Validator(
              validators: [
                const RequiredValidator(),
                const MinLengthValidator(length: 6),
                const NumberValidator()
              ],
            );

            return validator.validate(
              label: "Key must contain minumum 6 numbers",
              value: value,
            );
          },
          controller: keyTEC,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter Session Key (Optional)",
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(Icons.key, color: Colors.tealAccent),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.tealAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () {
            // Ensure focus node is properly activated
          },
        ),
      ),
    );
  }
}

class DurationTextField extends ConsumerWidget {
  const DurationTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final durationTEC = ref.read(sessionProvider.notifier).durationTEC;
    return SizedBox(
      width: 100,
      child: Form(
        key: ref.read(sessionProvider.notifier).globalDurationKey,
        child: TextFormField(
          validator: (value) {
            final validator = Validator(
              validators: [
                const RequiredValidator(),
                const MaxLengthValidator(length: 2),
                const NumberValidator()
              ],
            );

            return validator.validate(
              label: "Duration must be in number",
              value: value,
            );
          },
          controller: durationTEC,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Session Duration (in minutes)",
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(Icons.key, color: Colors.tealAccent),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.tealAccent, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onTap: () {
            // Ensure focus node is properly activated
          },
        ),
      ),
    );
  }
}
