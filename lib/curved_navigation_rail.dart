import 'package:flutter/material.dart';
import 'src/nav_button.dart';
import 'src/nav_custom_painter.dart';

typedef _LetIndexPage = bool Function(int value);

class CurvedNavigationRail extends StatefulWidget {
  final List<Widget> items;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;

  CurvedNavigationRail({
    Key? key,
    required this.items,
    this.index = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 75.0,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CurvedNavigationRailState createState() => CurvedNavigationRailState();
}

class CurvedNavigationRailState extends State<CurvedNavigationRail>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();
    _icon = widget.items[widget.index];
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(children: [
      Container(
        color: widget.backgroundColor,
        // TODO: change this to a width variable.
        width: widget.height,
        // height: 800,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            Scaffold(body: Center(child: Text('hello'))),
            Positioned1a(
              widget: widget,
              pos: _pos,
              size: size,
              length: _length,
              buttonHide: _buttonHide,
              icon: _icon,
            ),
            Positioned2a(widget: widget, pos: _pos, length: _length),
            Positioned(
              // left: 0,
              // right: 0,
              // bottom: 0 - (75.0 - widget.height),
              // TODO: Change to widget.width
              left: 0 - (75.0 - widget.height),
              top: 0,
              bottom: 0,
              child: SizedBox(
                  width: 100.0,
                  child: Column(
                      children: widget.items.map((item) {
                    return NavButton(
                      onTap: _buttonTap,
                      position: _pos,
                      length: _length,
                      index: widget.items.indexOf(item),
                      child: Center(child: item),
                    );
                  }).toList())),
            ),
          ],
        ),
      ),
    ]);

    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned1(
              widget: widget,
              pos: _pos,
              size: size,
              length: _length,
              buttonHide: _buttonHide,
              icon: _icon),
          Positioned2(widget: widget, pos: _pos, length: _length),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0 - (75.0 - widget.height),
            child: SizedBox(
                height: 100.0,
                child: Row(
                    children: widget.items.map((item) {
                  return NavButton(
                    onTap: _buttonTap,
                    position: _pos,
                    length: _length,
                    index: widget.items.indexOf(item),
                    child: Center(child: item),
                  );
                }).toList())),
          ),
        ],
      ),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}

class Positioned2a extends StatelessWidget {
  const Positioned2a({
    Key? key,
    required this.widget,
    required double pos,
    required int length,
  })  : _pos = pos,
        _length = length,
        super(key: key);

  final CurvedNavigationRail widget;
  final double _pos;
  final int _length;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: 0,
      // right: 0,
      // bottom: 0 - (75.0 - widget.height),
      // NEW
      // TODO: Change to widget.width
      left: 0 - (75.0 - widget.height),
      top: 0,
      bottom: 0,
      child: CustomPaint(
        painter: NavCustomPainter(
            _pos, _length, widget.color, Directionality.of(context)),
        child: Container(
          width: 75.0,
        ),
      ),
    );
  }
}

class Positioned2 extends StatelessWidget {
  const Positioned2({
    Key? key,
    required this.widget,
    required double pos,
    required int length,
  })  : _pos = pos,
        _length = length,
        super(key: key);

  final CurvedNavigationRail widget;
  final double _pos;
  final int _length;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0 - (75.0 - widget.height),
      child: CustomPaint(
        painter: NavCustomPainter(
            _pos, _length, widget.color, Directionality.of(context)),
        child: Container(
          height: 75.0,
        ),
      ),
    );
  }
}

class Positioned1a extends StatelessWidget {
  const Positioned1a({
    Key? key,
    required this.widget,
    required double pos,
    required this.size,
    required int length,
    required double buttonHide,
    required Widget icon,
  })  : _pos = pos,
        _length = length,
        _buttonHide = buttonHide,
        _icon = icon,
        super(key: key);

  final CurvedNavigationRail widget;
  final double _pos;
  final Size size;
  final int _length;
  final double _buttonHide;
  final Widget _icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _pos * size.height,
      left: -40 - (75.0 - widget.height),
      height: size.height / _length,
      child: Positioned1aCenter(
        buttonHide: _buttonHide,
        widget: widget,
        icon: _icon,
      ),
    );
  }
}

class Positioned1aCenter extends StatelessWidget {
  const Positioned1aCenter({
    Key? key,
    required double buttonHide,
    required this.widget,
    required Widget icon,
  })  : _buttonHide = buttonHide,
        _icon = icon,
        super(key: key);

  final double _buttonHide;
  final CurvedNavigationRail widget;
  final Widget _icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(
          (1 - _buttonHide) * 80,
          0,
        ),
        child: Material(
          color: widget.buttonBackgroundColor ?? widget.color,
          type: MaterialType.circle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class Positioned1 extends StatelessWidget {
  const Positioned1({
    Key? key,
    required this.widget,
    required double pos,
    required this.size,
    required int length,
    required double buttonHide,
    required Widget icon,
  })  : _pos = pos,
        _length = length,
        _buttonHide = buttonHide,
        _icon = icon,
        super(key: key);

  final CurvedNavigationRail widget;
  final double _pos;
  final Size size;
  final int _length;
  final double _buttonHide;
  final Widget _icon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -40 - (75.0 - widget.height),
      left: Directionality.of(context) == TextDirection.rtl
          ? null
          : _pos * size.width,
      right: Directionality.of(context) == TextDirection.rtl
          ? _pos * size.width
          : null,
      width: size.width / _length,
      child: Center(
        child: Transform.translate(
          offset: Offset(
            0,
            -(1 - _buttonHide) * 80,
          ),
          child: Material(
            color: widget.buttonBackgroundColor ?? widget.color,
            type: MaterialType.circle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _icon,
            ),
          ),
        ),
      ),
    );
  }
}
