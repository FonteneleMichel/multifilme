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
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Idioma",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            Row(
              children: [
                // 🔥 Ícone de localização personalizado
                Image.asset(
                  'assets/icon/location.png',
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                DropdownButton<Locale>(
                  value: languageProvider.locale,
                  dropdownColor: Colors.black,
                  underline: Container(),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en', 'US'),
                      child: Text('English', style: TextStyle(color: Colors.white)),
                    ),
                    DropdownMenuItem(
                      value: Locale('pt', 'BR'),
                      child: Text('Português', style: TextStyle(color: Colors.white)),
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

        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/icon/profile-circle.png',
            width: 42,
            height: 42,
          ),
        ),
      ],
    );
  }
}
