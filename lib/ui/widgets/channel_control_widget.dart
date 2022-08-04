import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/scuba_tx_bloc.dart';

class ChannelControlWidget extends StatefulWidget {
  const ChannelControlWidget({Key? key, required this.controller, required this.currentChannel}) : super(key: key);

  final PageController controller;
  final int currentChannel;

  @override
  State<ChannelControlWidget> createState() => _ChannelControlWidgetState();
}

class _ChannelControlWidgetState extends State<ChannelControlWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_left, size: 50),
            onPressed: () {
              widget.controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              BlocProvider.of<CurrentChannelBloc>(context).add(PrevChannelEvent());
            }),
        const Spacer(),
        Text(
          "Channel ${widget.currentChannel}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        IconButton(
            icon: const Icon(Icons.arrow_right, size: 50),
            onPressed: () {
              widget.controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
              BlocProvider.of<CurrentChannelBloc>(context).add(NextChannelEvent());
            }),
      ],
    );
  }
}
