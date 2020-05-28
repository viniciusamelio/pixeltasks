import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class ColorPicker extends StatefulWidget {
  final Function onSelect;
  const ColorPicker({Key key, this.onSelect}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Function onSelect;
  int selected;
  @override
  void initState() {
    onSelect = widget.onSelect;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () =>
            setState(() {
              this.selected = 0;
              onSelect(purple);
            })
          ,
          child: AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 350),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selected == 0 ? Border.all(color: Colors.blue,width: 3) : null
            ),
            child: ColorPointer(
              color: purple
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () =>
            setState(() {
              this.selected = 1;
              onSelect(pink);
            })
          ,
          child: AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 350),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selected == 1 ? Border.all(color: Colors.blue,width: 3) : null
            ),
            child: ColorPointer(
              color: pink
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () =>
            setState(() {
              this.selected = 2;
              onSelect(blue);
            })
          ,
          child: AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 350),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selected == 2 ? Border.all(color: Colors.blue,width: 3) : null
            ),
            child: ColorPointer(
              color: blue
            ),
          ),
        ),
      ],
    );
  }
}

class ColorPointer extends StatefulWidget {
  final Color color;
  final bool selected;
  final Function onSelect;

  const ColorPointer(
      {Key key, this.color, this.selected = false, this.onSelect})
      : super(key: key);
  @override
  _ColorPointerState createState() => _ColorPointerState();
}

class _ColorPointerState extends State<ColorPointer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(     
      child: AnimatedContainer(
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 350),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color),
      ),
    );
  }
}
