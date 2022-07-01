import 'package:flutter/material.dart';

class ChannelControlWidget extends StatefulWidget {
  const ChannelControlWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  State<ChannelControlWidget> createState() => _ChannelControlWidgetState();
}

class _ChannelControlWidgetState extends State<ChannelControlWidget> {
  int currentPage = 1;
  String currentChannel = "Channel 1";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_left, size: 50),
            onPressed: () {
              widget.controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              setState(() {
                if (currentPage > 1) {
                  currentChannel = "Channel ${currentPage = currentPage - 1}";
                }
              });
            }),
        const Spacer(),
        Text(
          currentChannel,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        IconButton(
            icon: const Icon(Icons.arrow_right, size: 50),
            onPressed: () {
              widget.controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              setState(() {
                if (currentPage < 3) {
                  currentChannel = "Channel ${currentPage = currentPage + 1}";
                }
              });
            }),
      ],
    );
  }
}
