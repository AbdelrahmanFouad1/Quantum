import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moa/core/util/constants.dart';

class SliderWidget extends StatefulWidget {
  final List<String> images = [
    'https://images.unsplash.com/photo-1502117859338-fd9daa518a9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1554321586-92083ba0a115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1536679545597-c2e5e1946495?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  ];

  SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final CarouselController carouselController = CarouselController();

  int currentSliderIndicator = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                items: widget.images
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: responsiveValue(context, 12.0,),
                          horizontal: responsiveValue(context, 10.0,),
                        ),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                e,
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 210,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentSliderIndicator = index;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentSliderIndicator == entry.key ? 12.0 : 6.0,
                        height:
                            currentSliderIndicator == entry.key ? 12.0 : 6.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : HexColor(mainColor))
                                  .withOpacity(
                            currentSliderIndicator == entry.key ? 1.0 : 0.3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
