import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorBuilder extends StatefulWidget {
  @override
  _ColorState createState() => _ColorState();
}

class _ColorState extends State<ColorBuilder> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDialog(
            context: context,
            useSafeArea: true,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: pickerColor,
                      onColorChanged: changeColor,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        setState(() => currentColor = pickerColor);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      },
      shape: const CircleBorder(),
      color: currentColor,
    );
  }
}
