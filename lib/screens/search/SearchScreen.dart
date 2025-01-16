import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/search/search_bloc.dart';
import 'package:tentwentytask/bloc/watch/watch_bloc.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/widgets/MovieSearchWidget.dart';
import 'package:tentwentytask/widgets/MovieWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc;
  final SearchController controller = SearchController();

  @override
  void initState() {
    super.initState();
    final watchBloc = BlocProvider.of<WatchBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.allMovies.addAll(watchBloc.movieList);
  }

  @override
  void dispose() {
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => searchBloc,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              children: [
                searchAnchor(),
                SizedBox(height: 20.sp),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      print(state);
                      if (state is SearchInitial) {
                        return gridView(searchBloc.allMovies);
                      } else if (state is SearchLoaded) {
                        if (state.filteredMovies.isEmpty) {
                          return const Center(child: Text("No results found"));
                        }
                        return gridView(state.filteredMovies);
                      } else {
                        return const Center(child: Text("Unexpected state"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridView(List<Movie> list) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final movie = list[index];
        return MovieWidget(
          movie: movie,
          isGrid: true,
          onClick: () {
            Navigator.pushNamed(
              context,
              RoutesName.detailsScreen,
              arguments: movie,
            );
          },
        );
      },
    );
  }

  Widget searchAnchor() {
    return SearchAnchor.bar(
      barLeading: GestureDetector(
        onTap: () {
          if (controller.text.isEmpty) {
            controller.closeView('');
          } else {
            controller.openView();
          }
        },
        child: Icon(controller.text.isEmpty ? Icons.arrow_back : Icons.search),
      ),
      barTrailing: [
        GestureDetector(
          onTap: () {
            if (controller.text.isEmpty) {
              controller.closeView('');
            } else {
              controller.text = '';
            }
          },
          child: const Icon(Icons.close),
        ),
      ],
      searchController: controller,
      barHintText: 'TV shows, movies and more',
      barHintStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) {
          return kNormalTextStyle;
        },
      ),
      barBackgroundColor: WidgetStateColor.resolveWith(
        (states) => Colors.grey[200]!,
      ),
      onChanged: (query) {
        context.read<SearchBloc>().add(SearchQueryChanged(query));
      },
      suggestionsBuilder: (context, query) {
        final state = context.read<SearchBloc>().state;
        if (state is SearchLoaded) {
          return state.filteredMovies
              .map(
                (suggestion) => Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10.sp,
                    horizontal: 12.sp,
                  ),
                  child: MovieSearchWidget(
                    movie: suggestion,
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.detailsScreen,
                        arguments: suggestion,
                      );
                    },
                  ),
                ),
              )
              .toList();
        }
        return <Widget>[];
      },
    );
  }
}
