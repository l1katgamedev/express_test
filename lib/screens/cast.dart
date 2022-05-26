import 'dart:developer';
import 'dart:ui';

import 'package:express_test/bloc/cast/cast_bloc.dart';
import 'package:express_test/bloc/cast_detail/cast_detail_bloc.dart';
import 'package:express_test/widgets/cast_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CastDetailScreen extends StatefulWidget {
  final int castId;

  const CastDetailScreen({Key? key, required this.castId}) : super(key: key);

  @override
  State<CastDetailScreen> createState() => _CastDetailScreenState();
}

class _CastDetailScreenState extends State<CastDetailScreen> {
  @override
  void initState() {
    final CastDetailBloc bloc = BlocProvider.of<CastDetailBloc>(context);
    if (bloc.state is! CastLoadedState) {
      bloc.add(CastDetailLoadEvent(widget.castId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailBloc, CastDetailState>(
        builder: (context, state) {
      if (state is CastDetailLoadingState) {
        log("first $state");
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CastDetailLoadedState) {
        log(" second $state");
        return CastDetailWidget();
      }
      return Center(
        child: Text('Нету детальной страницы'),
      );
    });
  }
}
