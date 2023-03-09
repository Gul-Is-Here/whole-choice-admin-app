// Create a list of colors
import '../../../const/const.dart';

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

// Create a Stateful Widget
class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorSelectorState createState() => _ColorSelectorState();
}

// Create a State class
class _ColorSelectorState extends State<ColorSelector> {
  // Create a set of selected colors
  Set<Color> selectedColors = <Color>{};

  // Create a method for adding colors to the set
  void _onColorTapped(Color color) {
    setState(() {
      selectedColors.add(color);
    });
  }

  // Create a method for removing colors from the set
  void _onColorDeselected(Color color) {
    setState(() {
      selectedColors.remove(color);
    });
  }

  // Create a method for displaying the colors
  Widget _buildColorList() {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        Color color = colors[index];
        // Check if the color is selected
        bool isSelected = selectedColors.contains(color);
        // Display the color
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              // Remove color from set
              _onColorDeselected(color);
            } else {
              // Add color to set
              _onColorTapped(color);
            }
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
