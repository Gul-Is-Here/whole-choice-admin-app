import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Color> colors = [
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.orange,
  Colors.black,
  Colors.white,
  Colors.pink,
  Colors.purple,
  Colors.indigo,
  Colors.amber,
  Colors.blueAccent,
  Colors.blueGrey
];

class ColorSelector extends StatefulWidget {
  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  List<int> selectedColors = [];

  void _onColorTapped(Color color) {
    setState(() {
      final colorValue = color.value;
      if (selectedColors.contains(colorValue)) {
        selectedColors.remove(colorValue);
      } else {
        selectedColors.add(colorValue);
      }
    });

    final user = FirebaseAuth.instance.currentUser;
    final productRef =
        FirebaseFirestore.instance.collection('products').doc(user!.uid);

    productRef.update({
      'p_color': selectedColors,
    });
  }

  bool _isColorSelected(Color color) {
    return selectedColors.contains(color.value);
  }

  Widget _buildColorList() {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        Color color = colors[index];
        bool isSelected = _isColorSelected(color);
        return GestureDetector(
          onTap: () {
            _onColorTapped(color);
          },
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: isSelected ? BorderRadius.circular(20.0) : null,
              border: isSelected
                  ? Border.all(color: Colors.black, width: 2.0)
                  : null,
            ),
            child: isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 40.0,
                  )
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: _buildColorList(),
    );
  }
}
