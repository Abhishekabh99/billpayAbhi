import 'package:flutter/material.dart';

class AppinioAnimatedToggleTab extends StatefulWidget {
  /// function(int) for call back and control the view of tabs
  final Function(int) callback;

  /// a list of texts displayed on the tabs
  final List<String> tabTexts;

  /// style of text when active
  final TextStyle activeStyle;

  /// style of text when inactive
  final TextStyle inactiveStyle;

  /// height of the tab
  final double height;

  /// decoration of the tab
  final BoxDecoration boxDecoration;

  /// the decoration of animated box used to toggle
  final BoxDecoration animatedBoxDecoration;

  /// width of the tab
  final double width;

  final List<double> outerWidths;

  /// offset of the area to toggle
  final double offset;

  /// animation duration for the toggling
  final Duration duration;

  final int initialIndex;
  void Function(void Function())? setState;

  AppinioAnimatedToggleTab({
    super.key,
    required this.callback,
    required this.tabTexts,
    required this.height,
    required this.boxDecoration,
    required this.animatedBoxDecoration,
    required this.activeStyle,
    required this.inactiveStyle,
    required this.width,
    required this.outerWidths,
    this.setState,
    this.offset = 0.02,
    this.duration = const Duration(milliseconds: 300),
    this.initialIndex = 0,
  });

  @override
  State<StatefulWidget> createState() => _AppinioAnimatedToggleTabState();
}

class _AppinioAnimatedToggleTabState extends State<AppinioAnimatedToggleTab> {
  late int index;

  _AppinioAnimatedToggleTabState() : super();

  @override
  void initState() {
    super.initState();

    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width + 2,
      decoration: widget.boxDecoration,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedAlign(
            alignment: Alignment(
                (index /
                        (widget.tabTexts.length - 1) *
                        (2 - 2 * widget.offset)) -
                    1 +
                    widget.offset,
                0),
            duration: widget.duration,
            child: Container(
              width: widget.outerWidths[index],
              height: widget.height * 0.9,
              decoration: widget.animatedBoxDecoration,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.tabTexts.length; i++)
                _buildSwitchTab(
                  i == index,
                  widget.tabTexts[i],
                  i == index ? widget.activeStyle : widget.inactiveStyle,
                  i,
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// building and returning one item of the tab
  Widget _buildSwitchTab(
    bool isLeft,
    String title,
    TextStyle style,
    int i,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.setState != null) {
          widget.setState!(() {
            if (index == 0) {
              index = 1;
            } else {
              index = 0;
            }
            widget.callback(i);
          });
        } else {
          setState(() {
            index = i;
            widget.callback(i);
          });
        }
      },
      child: Container(
          alignment: Alignment.center,
          width: widget.outerWidths[i],
          height: widget.height,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          )),
    );
  }
}
