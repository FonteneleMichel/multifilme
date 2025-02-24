import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Idioma",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // 🔥 Texto branco
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                DropdownButton<Locale>(
                  value: languageProvider.locale,
                  dropdownColor: Colors.black, // 🔥 Define fundo preto para o dropdown
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white), // 🔥 Ícone da seta branca
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('English', style: TextStyle(color: Colors.white)), // 🔥 Texto branco
                    ),
                    DropdownMenuItem(
                      value: Locale('pt', 'BR'),
                      child: Text('Português', style: TextStyle(color: Colors.white)), // 🔥 Texto branco
                    ),
                  ],
                  onChanged: (Locale? newValue) {
                    if (newValue != null) {
                      languageProvider.setLocale(newValue);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
