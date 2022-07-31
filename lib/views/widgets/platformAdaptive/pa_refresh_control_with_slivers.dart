import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_mng_frontend/views/widgets/platformAdaptive/platform_adaptive_base.dart';

class PlatformAdaptiveRefreshControlWithSlivers
    extends PlatformAdaptiveWidget<CustomScrollView, RefreshIndicator> {
  const PlatformAdaptiveRefreshControlWithSlivers(
      {Key? key,
      required this.slivers,
      required this.onRefresh,
      this.scrollController})
      : super(key: key);

  final List<Widget> slivers;
  final Future<void> Function() onRefresh;
  final ScrollController? scrollController;

  @override
  RefreshIndicator buildMaterialWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        controller: scrollController,
        slivers: slivers,
      ),
    );
  }

  @override
  CustomScrollView buildCupertinoWidget(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
        ...slivers
      ],
    );
  }
}
