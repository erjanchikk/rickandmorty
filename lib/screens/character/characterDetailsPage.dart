import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/bloc/episode/episode_bloc.dart';
import 'package:rickandmorty/helpers/utils.dart';

import 'package:rickandmorty/models/characterModel.dart';
import 'package:rickandmorty/screens/location/locationDetailsPage.dart';

class CharacterDetailsPage extends StatefulWidget {
  final Character character;
  const CharacterDetailsPage({super.key, required this.character});
  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  late final EpisodeBloc episodebloc;
  @override
  void initState() {
    episodebloc = EpisodeBloc();
    episodebloc.add(GetCharacterEpisodes(
        numbers: extractId(widget.character.episode ?? [])));
    super.initState();
  }

  @override
  void dispose() {
    episodebloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF0B1E2D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 308.r,
                ),
                SizedBox(
                  height: 218.r,
                  width: MediaQuery.sizeOf(context).width,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Color(0xff0B1E2D).withOpacity(0.5), BlendMode.darken),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Image.network(
                        widget.character.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.r,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 138.r,
                  left: 107.r,
                  right: 106.r,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180.r),
                    child: Container(
                      color: Color(0XFF0B1E2D),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180.r),
                          child: Image.network(
                            width: 146.r,
                            height: 146.r,
                            widget.character.image.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.character.name.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 34.sp,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.character.status!.name.toString(),
              style: TextStyle(
                  color: checkStatus(widget.character.status ?? Status.UNKNOWN),
                  fontSize: 10.sp,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                color: Color(0xff5B6975),
                                fontSize: 12.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.character.gender!.name[0] +
                                widget.character.gender!.name
                                    .substring(1)
                                    .toLowerCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      118.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Species",
                            style: TextStyle(
                                color: Color(0xff5B6975),
                                fontSize: 12.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.character.species!.name[0] +
                                widget.character.species!.name
                                    .substring(1)
                                    .toLowerCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  InkWell(
                    onTap: () {
                      String id =
                          extractId([widget.character.origin!.url.toString()]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationDetailsPage(id: id),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Origin",
                                style: TextStyle(
                                    color: Color(0xff5B6975),
                                    fontSize: 12.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.character.origin!.name.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 17.r,
                        ),
                      ],
                    ),
                  ),
                  24.verticalSpace,
                  InkWell(
                    onTap: () {
                      String id =
                          extractId([widget.character.origin!.url.toString()]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationDetailsPage(id: id),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                    color: Color(0xff5B6975),
                                    fontSize: 12.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                widget.character.location!.name.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 17.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Divider(
              color: Color(0xff152A3A),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Episodes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            letterSpacing: 0.15,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "All Episodes",
                        style: TextStyle(
                            color: Color(0xff5B6975),
                            fontSize: 12.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  BlocBuilder(
                    bloc: episodebloc,
                    builder: (context, state) {
                      if (state is EpisodeLoadingState) {
                        return const Center(child: CupertinoActivityIndicator(color: Colors.white,));
                      } else if (state is EpisodeLoadedState) {
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.episode.length,
                          separatorBuilder: (_, __) => SizedBox(height: 24.r),
                          itemBuilder: (BuildContext context, int index) {
                            final episode = state.episode[index];

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
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white, size: 17.r),
                              onTap: () {},
                            );
                          },
                        );
                      } else if (state is EpisodeErrorState) {
                        return Center(
                            child: Text(state.error,
                                style: TextStyle(color: Colors.red)));
                      }
                      return Container();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
