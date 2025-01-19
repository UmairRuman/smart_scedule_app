import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_club_app/pages/pretimer_selection_page.dart/controller/pretimer_state_controller.dart';
import 'package:smart_club_app/pages/pretimer_selection_page.dart/widgets/dialog_for_pretimer_confirmation.dart';

class PretimerSelectionPage extends ConsumerWidget {
  const PretimerSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPretimer = ref.watch(pretimerStateProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF004D40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Select Pretimer Duration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How much time do you need?",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Icon(
              Icons.hourglass_top_rounded,
              color: Colors.tealAccent,
              size: 80,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildChoiceButton(
                    context, "2 Minutes", 2, selectedPretimer, ref),
                _buildChoiceButton(
                    context, "5 Minutes", 5, selectedPretimer, ref),
                _buildChoiceButton(
                    context, "10 Minutes", 10, selectedPretimer, ref),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Prepare for the session with your chosen time.",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceButton(BuildContext context, String text, int duration,
      int selectedPretimer, WidgetRef ref) {
    final isSelected = duration == selectedPretimer;

    return GestureDetector(
      onTap: () {
        showPretimerConfirmationDialog(context, text, duration, ref);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00796B), Color(0xFF004D40)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.tealAccent, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.tealAccent,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
