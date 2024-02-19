// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stardew_valley_assistant/models/models.dart';
import 'package:stardew_valley_assistant/network/network.dart';
import 'package:stardew_valley_assistant/utils/shared_preference_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CollectionsPage extends GetView<CollectionsController> {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      return CustomScrollView(
        slivers: [
          _buildHeader(controller.shippedTitle),
          _buildGrid(controller.shippedItems),
          _buildHeader(controller.fishTitle),
          _buildGrid(controller.fishItems),
          _buildHeader(controller.artifactTitle),
          _buildGrid(controller.artifactItems),
          _buildHeader(controller.miniralTitle),
          _buildGrid(controller.minaralItems),
          _buildHeader(controller.cookingTitle),
          _buildGrid(controller.cookingItems),
        ],
      );
    });
  }

  Widget _buildGrid(RxList<CollectionModel> collections) {
    return SliverGrid.extent(
      maxCrossAxisExtent: 50,
      children: List.generate(
        collections.length,
        (index) => _buildTile(collections[index]),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Text(title),
      ),
    );
  }

  Widget _buildTile(CollectionModel collection) {
    return GestureDetector(
      child: _buildImage(collection),
      onTap: () {
        controller.tapItem(collection);
      },
    );
  }

  Widget _buildImage(CollectionModel collection) {
    final link = "https://www.stardewvalleywiki.com/${collection.iconLink}";
    final key = controller.getKeyFrom(collection);
    final state = controller.itemState[key];
    return ColorFiltered(
      colorFilter: _genColorFilter(state),
      child: CachedNetworkImage(imageUrl: link),
    );
  }

  ColorFilter _genColorFilter(CollectionState? state) {
    state ??= CollectionState.uncollected;
    switch (state) {
      case CollectionState.uncollected:
        return const ColorFilter.mode(Colors.grey, BlendMode.saturation);
      case CollectionState.collected:
        return const ColorFilter.mode(Colors.transparent, BlendMode.multiply);
      case CollectionState.inMuseum:
        return const ColorFilter.mode(Colors.green, BlendMode.overlay);
    }
  }
}

class CollectionsController extends GetxController {
  var collections = <CollectionModel>[].obs;
  var shippedItems = <CollectionModel>[].obs;
  var fishItems = <CollectionModel>[].obs;
  var artifactItems = <CollectionModel>[].obs;
  var minaralItems = <CollectionModel>[].obs;
  var cookingItems = <CollectionModel>[].obs;
  final shippedTitle = 'Shipped Items';
  final fishTitle = 'Fish';
  final artifactTitle = 'Artifacts';
  final miniralTitle = 'Minirals';
  final cookingTitle = 'Cookings';
  var itemState = <String, CollectionState>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    collections.value = await Network.findCollections();
    shippedItems.value = List.from(
        collections.where((e) => e.type == CollectionType.shippedItem));
    fishItems.value =
        List.from(collections.where((e) => e.type == CollectionType.fish));
    artifactItems.value =
        List.from(collections.where((e) => e.type == CollectionType.artifact));
    minaralItems.value =
        List.from(collections.where((e) => e.type == CollectionType.mineral));
    cookingItems.value =
        List.from(collections.where((e) => e.type == CollectionType.cooking));
    for (var collection in collections) {
      final key = getKeyFrom(collection);
      final state = _getStateFrom(collection);
      itemState[key] = state;
    }
  }

  void tapItem(CollectionModel collection) {
    final key = getKeyFrom(collection);
    final state = _getStateFrom(collection);
    final nextState = _getNextState(state, collection);
    SharedPreferenceManager().setString(key, nextState.toString());
    itemState[key] = nextState;
    itemState.refresh();
  }

  CollectionState _getStateFrom(CollectionModel collection) {
    final key = getKeyFrom(collection);
    final stateStr = SharedPreferenceManager().getString(key);
    if (stateStr == null) {
      return CollectionState.uncollected;
    } else {
      return CollectionState.values.firstWhere((e) => e.toString() == stateStr);
    }
  }

  String getKeyFrom(CollectionModel collection) {
    return "${collection.name},${collection.link}";
  }

  CollectionState _getNextState(
      CollectionState state, CollectionModel collection) {
    final type = collection.type;
    switch (type) {
      case CollectionType.shippedItem:
      case CollectionType.fish:
      case CollectionType.cooking:
        if (state == CollectionState.uncollected) {
          return CollectionState.collected;
        }
        if (state == CollectionState.collected) {
          return CollectionState.uncollected;
        }
        break;
      case CollectionType.artifact:
      case CollectionType.mineral:
        switch (state) {
          case CollectionState.uncollected:
            return CollectionState.collected;
          case CollectionState.collected:
            return CollectionState.inMuseum;
          case CollectionState.inMuseum:
            return CollectionState.uncollected;
        }
    }
    return CollectionState.uncollected;
  }
}

enum CollectionState {
  uncollected,
  collected,
  inMuseum,
}
