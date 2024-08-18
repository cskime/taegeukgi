import 'package:flutter/material.dart';
import 'package:taegukgi/taegukgi/taegukgi.dart';

void main() {
  // runApp(const TaegukgiApp());
  runApp(const FixedFooterScrollableExampleApp());
}

class FixedFooterScrollableExampleApp extends StatelessWidget {
  const FixedFooterScrollableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Fixed Footer Scrollable Widget"),
        ),
        body: FixedFooterSingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.amber,
                height: 500,
                child: const Center(
                  child: Text("CONTENT", style: textStyle),
                ),
              ),
              const Spacer(),
              Container(
                color: Colors.blue,
                height: 100,
                child: const Center(
                  child: Text("FOOTER", style: textStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FixedFooterSingleChildScrollView extends StatelessWidget {
  const FixedFooterSingleChildScrollView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minHeight: constraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      ),
    );
  }
}

class TaegukgiApp extends StatelessWidget {
  const TaegukgiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Taegukgi(),
        ),
      ),
    );
  }
}
