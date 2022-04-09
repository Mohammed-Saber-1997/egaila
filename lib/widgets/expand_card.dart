import 'package:flutter/material.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class MyExpandCard extends StatefulWidget {
  const MyExpandCard({
    Key? key,
    this.leading,
    required this.title,
    this.background,
    this.backgroundColor,
    this.margin = const EdgeInsets.only(top: 30),
    this.borderRadius = 20.0,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.iconColor = Colors.white,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);
  final Color iconColor;

  /// Adds margin to content of the card.
  final EdgeInsets margin;

  /// Provides CircularRadius to the border of the card.
  final double borderRadius;

  /// A widget to add background.
  /// it can be a gif or image.
  final Widget? background;

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget? trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  @override
  _ExpandCard createState() => _ExpandCard();
}

class _ExpandCard extends State<MyExpandCard>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged!(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = Colors.transparent; // _borderColor.value ??

    return Stack(
      children: <Widget>[
        widget.background == null
            ? Container()
            : ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Align(
                  heightFactor:
                      _heightFactor.value < 0.5 ? 0.5 : _heightFactor.value,
                  child: widget.background,
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: _backgroundColor.value ?? Colors.transparent,
            border: Border(
              top: BorderSide(color: borderSideColor),
              bottom: BorderSide(color: borderSideColor),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTileTheme.merge(
                  iconColor: _iconColor.value,
                  textColor: _headerColor.value,
                  child: Container(
                    margin: widget.margin,
                    child: ListTile(
                      onTap: _handleTap,
                      leading: widget.leading,
                      title: widget.title,
                      trailing: widget.trailing ??
                          RotationTransition(
                            turns: _iconTurns,
                            child: Icon(Icons.keyboard_arrow_down,
                                color: widget.iconColor),
                          ),
                    ),
                  )),
              ClipRect(
                child: Align(
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween..end = theme.dividerColor;
    _headerColorTween
      ..begin = Colors.white
      ..end = Colors.white;
    _iconColorTween
      ..begin = Colors.white
      ..end = Colors.white;
    _backgroundColorTween..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
