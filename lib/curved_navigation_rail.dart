import 'package:flutter/material.dart';
import 'src/nav_button.dart';
import 'src/nav_custom_painter.dart';

typedef _LetIndexPage = bool Function(int value);

class CurvedNavigationRail extends StatefulWidget {
  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color? backgroundColor;
  final ValueChanged<int>? onDestinationSelected;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double width;

  CurvedNavigationRail({
    Key? key,
    required this.destinations,
    this.selectedIndex = 0,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.backgroundColor,
    this.onDestinationSelected,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.width = 75.0,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(destinations.length >= 1),
        assert(0 <= selectedIndex && selectedIndex < destinations.length),
        assert(0 <= width && width <= 75.0),
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
    _icon = widget.destinations[widget.selectedIndex].icon;
    _length = widget.destinations.length;
    _pos = widget.selectedIndex / _length;
    _startingPos = widget.selectedIndex / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.destinations.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.destinations[_endingIndex].icon;
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      final newPosition = widget.selectedIndex / _length;
      _startingPos = _pos;
      _endingIndex = widget.selectedIndex;
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
        color:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        width: widget.width,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            SelectedIcon(
              widget: widget,
              pos: _pos,
              size: size,
              length: _length,
              buttonHide: _buttonHide,
              icon: _icon,
            ),
            CurvedRail(widget: widget, pos: _pos, length: _length),
            UnselectedIcons(
                widget: widget, pos: _pos, length: _length, onTap: _buttonTap),
          ],
        ),
      ),
    ]);
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onDestinationSelected != null) {
      widget.onDestinationSelected!(index);
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

class UnselectedIcons extends StatelessWidget {
  const UnselectedIcons({
    Key? key,
    required this.widget,
    required this.pos,
    required this.length,
    required this.onTap,
  }) : super(key: key);

  final CurvedNavigationRail widget;
  final double pos;
  final int length;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0 - (75.0 - widget.width),
      top: 0,
      bottom: 0,
      child: SizedBox(
          width: 100.0,
          child: Column(
              children: widget.destinations.map((item) {
            return NavButton(
              onTap: onTap,
              position: pos,
              length: length,
              index: widget.destinations.indexOf(item),
              child: Center(child: item.icon),
            );
          }).toList())),
    );
  }
}

class CurvedRail extends StatelessWidget {
  const CurvedRail({
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
      left: 0 - (75.0 - widget.width),
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

class SelectedIcon extends StatelessWidget {
  const SelectedIcon({
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
      left: -40 - (75.0 - widget.width),
      height: size.height / _length,
      child: SelectedIconCircle(
        buttonHide: _buttonHide,
        widget: widget,
        icon: _icon,
      ),
    );
  }
}

class SelectedIconCircle extends StatelessWidget {
  const SelectedIconCircle({
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
