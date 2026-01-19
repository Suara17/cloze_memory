import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cloze_provider_simple.dart';
import '../widgets/text_input_section.dart';
import '../widgets/file_upload_section.dart';
import '../widgets/cloze_display_section.dart';
import '../widgets/control_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('挖空背书'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ClozeProvider>(
              builder: (context, clozeProvider, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: clozeProvider.isClozeMode
                      ? Column(
                          key: const ValueKey('cloze_mode'),
                          children: [
                            const ControlPanel(),
                            const SizedBox(height: 16),
                            Expanded(child: ClozeDisplaySection()),
                          ],
                        )
                      : Column(
                          key: const ValueKey('input_mode'),
                          children: [
                            const TextInputSection(),
                            const SizedBox(height: 16),
                            const FileUploadSection(),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}