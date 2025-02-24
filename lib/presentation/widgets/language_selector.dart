import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 🔥 Distribui os elementos igualmente
      children: [
        // Seção do seletor de idioma
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Idioma", // 🔥 Label do idioma
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                DropdownButton<Locale>(
                  value: languageProvider.locale,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('pt', 'BR'),
                      child: Text('Português'),
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

        // Ícone de perfil do usuário
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
