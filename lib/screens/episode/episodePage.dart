import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/models/episodeModel.dart';

import '../../bloc/episode/episode_bloc.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});
  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  late final PagingController<int, Episode> pagingController;
  late final EpisodeBloc episodeBloc;
  late final TextEditingController controller;
  int pageCount = 1;

  @override
  void initState() {
    episodeBloc = EpisodeBloc();
    controller = TextEditingController();
    pagingController = PagingController(firstPageKey: pageCount);
    pagingController.addPageRequestListener(
      (pageKey) {
        episodeBloc.add(GetEpisodes(page: pageKey));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    episodeBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B1E2D),
      body: Padding(
        padding:
            EdgeInsets.only(left: 16.r, right: 16.r, top: 16.r, bottom: 5.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            15.verticalSpace,
            Container(
              height: 48.r,
              decoration: BoxDecoration(
                color: Color(0xff152A3A),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 11.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Color(0xff5B6975)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Find episode',
                          hintStyle: TextStyle(
                              color: Color(0xff5B6975),
                              fontWeight: FontWeight.w400,
                              fontSize: 16.r,
                              letterSpacing: 0.44.r),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
            33.verticalSpace,
            Expanded(
              child: BlocListener(
                bloc: episodeBloc,
                listener: (context, state) {
                  if (state is EpisodeLoadedState) {
                    pageCount++;
                    setState(() {});
                    pagingController.appendPage(state.episode, pageCount + 1);
                  } else if (state is EpisodeErrorState) {
                    pagingController.error = state.error;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TOTAL EPISODES: ${pagingController.itemList == null ? "0" : pagingController.itemList!.length}",
                      style: TextStyle(
                        color: Color(0xff5B6975),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5.r,
                        fontSize: 10.sp,
                      ),
                    ),
                    24.verticalSpace,
                    Expanded(
                        child: PagedListView<int, Episode>.separated(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Episode>(
                        itemBuilder: (context, item, index) {
                          final episode = item;
                          return ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            title: Text(
                              "Episode ${episode.id}",
                              style: TextStyle(
                                color: Color(0xff22A2BD),
                                fontSize: 10.sp,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  episode.name ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  episode.airDate ?? '',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {},
                          );
                        },
                      ),
                      separatorBuilder: (context, index) {
                        return 24.verticalSpace;
                      },
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
