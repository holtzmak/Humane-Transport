import 'package:app/core/services/service_locator.dart';
import 'package:app/core/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TemplateBaseViewModel<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  TemplateBaseViewModel(
      {this.builder, this.onModelReady, GlobalKey<FormState> key});

  @override
  _TemplateBaseViewModelState<T> createState() =>
      _TemplateBaseViewModelState<T>();
}

class _TemplateBaseViewModelState<T extends BaseViewModel>
    extends State<TemplateBaseViewModel<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}
