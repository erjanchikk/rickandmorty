import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rickandmorty/bloc/location/location_bloc.dart';
import 'package:rickandmorty/models/locationModel.dart';

import 'locationDetailsPage.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late final PagingController<int, ResultLocation> pagingController;
  late final LocationBloc locationBloc;
  late final TextEditingController controller;
  int pageCount = 1;

  @override
  void initState() {
    locationBloc = LocationBloc();
    controller = TextEditingController();
    pagingController = PagingController(firstPageKey: pageCount);
    pagingController.addPageRequestListener(
      (pageKey) {
        locationBloc.add(GetLocations(page: pageKey));
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.close();
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
          children: [
            15.verticalSpace,
            Container(
              height: 48.r,
              decoration: BoxDecoration(
                color: Color(0xff152A3A),
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 12.r),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xff5B6975)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Find location',
                          hintStyle: TextStyle(
                              color: Color(0xff5B6975),
                              fontWeight: FontWeight.w400,
                              fontSize: 16.r,
                              letterSpacing: 0.44.r),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Color(0xff5B6975),
                    ),
                    SvgPicture.asset("assets/icons/filtr_icon.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xff5B6975), BlendMode.dstIn)),
                  ],
                ),
              ),
            ),
            33.verticalSpace,
            Expanded(
              child: BlocListener(
                bloc: locationBloc,
                listener: (context, state) {
                  if (state is LocationLoadedState) {
                    pageCount++;
                    setState(() {});
                    pagingController.appendPage(state.location, pageCount + 1);
                  } else if (state is LocationErrorState) {
                    pagingController.error = state.error;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TOTAL LOCATIONS: ${pagingController.itemList == null ? "0" : pagingController.itemList!.length}",
                      style: TextStyle(
                        color: Color(0xff5B6975),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5.r,
                        fontSize: 10.sp,
                      ),
                    ),
                    24.verticalSpace,
                    Expanded(
                        child: PagedListView<int, ResultLocation>.separated(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate<ResultLocation>(
                        itemBuilder: (context, item, index) {
                          final location = item;
                          return InkWell(
                            
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetailsPage(location: location,),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff152A3A),
                                borderRadius: BorderRadius.circular(16.r)
                              ),
                              width: MediaQuery.sizeOf(context).width - 32.r,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                                    child: Image.asset(
                                      "assets/location.png",
                                      height: 150.r,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.r, horizontal: 16.r),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.name ?? '',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          "${location.type} • ${location.dimension}",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Color(0xff6E798C),
                                              fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
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
