import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newso/commonwidgets/empty_news_widget.dart.dart';
import 'package:newso/consts/app_colors.dart';
import 'package:newso/consts/enum_variables.dart';
import 'package:newso/commonwidgets/vertical_spacing_widget.dart';
import 'package:newso/models/news_model.dart';
import 'package:newso/providers/news_provider.dart';
import 'package:newso/screens/homescreen/widgets/article_widget.dart';
import 'package:newso/services/get_theme_color_service.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  late final FocusNode focusNode;
  bool isSearching = false;
  List<NewsModel>? searchList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = GetThemeColorService(context).getColor;
    final newsProvider = Provider.of<NewsProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            const VerticalSpacingWidget(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    focusNode.unfocus();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrowLeft2,
                    size: 30,
                    color: GetThemeColorService(context).getPaginationColor,
                  ),
                ),
                Flexible(
                  //! search button
                  child: TextFormField(
                    focusNode: focusNode,
                    controller: _searchController,
                    style: TextStyle(color: color),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    keyboardType: TextInputType.text,
                    onEditingComplete: () async {
                      //* search function
                      searchList = await newsProvider.searchNews(
                          searchQuery: _searchController.text);
                      isSearching = true;
                      focusNode.unfocus();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 6.w, top: 15.h),
                      hintText: "Search...",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController.clear();
                          isSearching = false;
                          searchList!.clear();
                          focusNode.unfocus();
                          setState(() {});
                        },
                        icon: Icon(
                          IconlyLight.closeSquare,
                          size: 18,
                          color: darkIconsColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const VerticalSpacingWidget(height: 10),
            //* user is not searching
            if (!isSearching && searchList!.isEmpty)
              Expanded(
                child: MasonryGridView.count(
                  itemCount: searchKeyword.length,
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: GestureDetector(
                        onTap: () async {
                          //* impleaments the search keyords
                          _searchController.text = searchKeyword[index];
                          searchList = await newsProvider.searchNews(
                              searchQuery: _searchController.text);
                          isSearching = true;
                          focusNode.unfocus();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: color),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                searchKeyword[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            //* user is searching and that query not in search list(api)
            if (isSearching && searchList!.isEmpty)
              const Expanded(
                child: EmptyNewsWidget(
                  text: "Ops! No result found",
                  animation: "assets/animations/no_serach.json",
                  animationHeight: 300,
                  animationWidth: 300,
                ),
              ),
            //* user searched query available in searchlist
            if (searchList!.isNotEmpty && searchList != null)
              Expanded(
                child: ListView.builder(
                  itemCount: searchList!.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: searchList![index],
                      child: const ArticleWidget(),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      _searchController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }
}
