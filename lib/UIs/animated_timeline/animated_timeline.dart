
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum STATUS { completed, ongoing, incomplete, error }

class Items {
  final String title;
  final String subtitle;
  final STATUS status;

  Items({
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

class Timeline extends StatefulWidget {


  final List<Items> items = [
    Items(
      title: "Address Received",
      subtitle:
          "Your address is received and we are processing it skjdhflk dsfjlskdjf lkdsfhjlidsjflkd jsflidjslfjdslf sjdflidjslfkjdsl fdisjfhlidsj fdsjhflidsjfli dfldshoifjdsi fsidnfoidsjfldsjfoirej oifn dsiofndsi fndsoifjdiosjfds oifkndslifjndsoifjsdilf sdlknldsjfidsjnfli sdinfli sdnfildsn lifsdnlif dslin",
      status: STATUS.completed,
    ),
    Items(
      title: "Address Verification",
      subtitle: "Your address is received and we are verifying it",
      status: STATUS.completed,
    ),
    Items(
      title: "Address Verification",
      subtitle: "Your address is received and we are verifying it",
      status: STATUS.ongoing,
    ),
    Items(
      title: "Address Approved",
      subtitle: "Your address is verified and approved",
      status: STATUS.incomplete,
    ),
  ];

  Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.items.length ),
      lowerBound: 0,
      upperBound: 1,
    )..addListener(() {
        setState(() {});
      });
  }

  void initAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(onPressed: () {
        initAnimation();
      }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (ctx, i) {
            double computedAnimatedValue = 0;
            double singleSegmentAnimValue = 1 / widget.items.length;
            if (_animationController.value < (i) * singleSegmentAnimValue) {
              computedAnimatedValue = 0;
            }
            if (_animationController.value >= i * singleSegmentAnimValue && _animationController.value < (i + 1) * singleSegmentAnimValue) {
              computedAnimatedValue = ((singleSegmentAnimValue * i) - _animationController.value).abs() / singleSegmentAnimValue;
            }
            if (_animationController.value > (i + 1) * singleSegmentAnimValue) {
              computedAnimatedValue = 1;
            }

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: i == 0 ? 0 : 6,
                            bottom: i == widget.items.length - 1 ? 0 : 6,
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: 1 - computedAnimatedValue,
                                    child: const CircleAvatar(
                                      radius: 6,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Opacity(
                                    opacity: computedAnimatedValue,
                                    child: widget.items[i].status == STATUS.completed
                                        ? const Icon(
                                            Icons.verified,
                                            color: Colors.green,
                                            size: 24,
                                          )
                                        : CircleAvatar(
                                            radius: 6,
                                            backgroundColor: widget.items[i].status == STATUS.ongoing ? Colors.orange : Colors.grey,
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (i != widget.items.length - 1)
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minHeight: 70,
                                maxWidth: 3,
                                minWidth: 3,
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  gradient: LinearGradient(
                                    colors: [Colors.green, Colors.grey],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: widget.items[i + 1].status != STATUS.incomplete ? [computedAnimatedValue, computedAnimatedValue] : [0, 0],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.items[i].title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.items[i].subtitle,
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
