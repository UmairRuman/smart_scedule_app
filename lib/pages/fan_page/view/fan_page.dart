import 'package:flutter/material.dart';

class FansPage extends StatelessWidget {
  const FansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fans', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F1F1F), Color(0xFF292929)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(-4, -4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.ac_unit,
                          color: Theme.of(context).iconTheme.color,
                          size: 36,
                        ),
                        const Spacer(),
                        Switch(
                          value: false,
                          onChanged: (value) {},
                          activeColor: Colors.tealAccent,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade700,
                        ),
                      ],
                    ),
                    Text(
                      "Kitchen Fan",
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Slider(
                            min: 0,
                            max: 100,
                            value: 50,
                            onChanged: (value) {},
                            activeColor: Colors.tealAccent,
                            inactiveColor: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          "50%",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Status: ",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "On",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.tealAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
