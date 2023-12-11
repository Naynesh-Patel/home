import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/bloc/search/search_bloc.dart';
import '/presentation/utils/constraints.dart';
import '/presentation/utils/k_images.dart';
import '/presentation/widget/empty_widget.dart';
import '/presentation/widget/loading_widget.dart';
import '../../../data/model/search_response_model/search_property_model.dart';
import '../../router/route_names.dart';
import 'component/search_component.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final searchBloc = context.read<SearchBloc>();
    scrollController.addListener(() {
      final maxExtent = scrollController.position.maxScrollExtent - 200;
      if (maxExtent < scrollController.position.pixels) {
        searchBloc.add(const SearchEventLoadMoreProperty());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    // if (mounted) {
    //   clearProperty();
    // }
  }

  // clearProperty() {
  //   final searchBloc = context.read<SearchBloc>();
  //   if (searchBloc.property.isNotEmpty) {
  //     searchBloc.property.clear();
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   clearProperty();
  //   print('didChangeDependencies');
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return WillPopScope(
      onWillPop: () async {
        if (searchBloc.property.isNotEmpty) {
          searchBloc.property.clear();
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: whiteColor,
          appBar: SearchTextField(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.done,
                controller: searchTextEditingController,
                decoration: const InputDecoration(
                    hintText: 'Search property..',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0)),
                onChanged: (String text) {
                  if (text.isEmpty) return;
                  searchBloc.add(SearchEventProperty(text.trim()));
                },
                onFieldSubmitted: (String text) {
                  if (text.isEmpty) return;
                  searchBloc.add(SearchEventProperty(text.trim()));
                },
              ),
            ),
          ),
          body: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {},
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const LoadingWidget();
                } else if (state is SearchError) {
                  //Utils.errorSnackBar(context, state.message);
                } else if (state is SearchLoaded) {
                  return SearchLoadedWidget(property: state.property);
                }
                return const SizedBox.shrink();
                // return const Center(
                //   child: CustomTextStyle(
                //     text: 'something is wrong',
                //   ),
                // );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SearchLoadedWidget extends StatelessWidget {
  const SearchLoadedWidget({Key? key, required this.property})
      : super(key: key);
  final List<SearchProperty> property;

  @override
  Widget build(BuildContext context) {
    if (property.isNotEmpty) {
      return ListView.builder(
          itemCount: property.length,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 40.0)
              .copyWith(top: 0.0),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.pushNamed(
                  context, RouteNames.propertyDetailsScreen,
                  arguments: property[index].slug),
              child: SearchComponent(property: property[index])));
    } else {
      return const Center(
          child: EmptyWidget(
              icon: KImages.emptyProperty, title: 'No Property Found!'));
    }
  }
}

class SearchTextField extends StatelessWidget implements PreferredSizeWidget {
  const SearchTextField({Key? key, required this.child}) : super(key: key);
  final Widget child;
  final double height = 100.0;

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: transparent,
      toolbarHeight: height,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                searchBloc.property.clear();
              },
              child: const CircleAvatar(
                backgroundColor: primaryColor,
                minRadius: 18.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                    size: 22.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
