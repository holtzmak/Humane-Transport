import 'package:app/ui/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NumericProgressBar extends StatefulWidget {
  final int stages;

  NumericProgressBar({
    @required this.stages,
  });

  final _NumericProgressBarState state = new _NumericProgressBarState();

  void updateStage(int index, bool isSuccessful) =>
      state.updateStage(index, isSuccessful);

  @override
  _NumericProgressBarState createState() => state;
}

class _NumericProgressBarState extends State<NumericProgressBar> {
  List<Chip> stages = [];

  @override
  void initState() {
    stages.addAll(List.generate(
        widget.stages,
        (index) => Chip(
              label: Text("${index + 1}", style: TextStyle(color: NavyBlue)),
              shape: StadiumBorder(side: BorderSide(color: NavyBlue)),
              backgroundColor: Colors.white,
            )));
    super.initState();
  }

  void updateStage(int index, bool isSuccessful) {
    setState(() {
      stages[index] = Chip(
        label: Text("${index + 1}",
            style: TextStyle(color: isSuccessful ? Colors.green : Colors.red)),
        shape: StadiumBorder(
            side: BorderSide(color: isSuccessful ? Colors.green : Colors.red)),
        backgroundColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          stages.length,
          (index) => _buildState(
              isLeading: index == 0,
              isTrailing: index == stages.length - 1,
              stage: stages[index])),
    );
  }

  Widget line() {
    return Container(
      color: NavyBlue,
      height: 5,
      width: 8,
    );
  }

  Widget _buildState({bool isLeading, bool isTrailing, Chip stage}) {
    return Column(
      children: [
        Container(
          margin: isLeading
              ? const EdgeInsets.only(left: 30.0)
              : isTrailing
                  ? const EdgeInsets.only(right: 30.0)
                  : const EdgeInsets.all(0.0),
          child: Row(
            children: [
              if (!isLeading) line(),
              stage,
              if (!isTrailing) line(),
            ],
          ),
        ),
      ],
    );
  }
}
