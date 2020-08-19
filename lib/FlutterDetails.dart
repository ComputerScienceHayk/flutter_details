import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String img = "assets/images/alan.jpg";
String alan = "Alan Turing";
String bio = "biography";
String text = "Alan Mathison Turing was born on 23 June 1912, the second and last child (after his brother John) of Julius Mathison and Ethel Sara Turing. The unusual name of Turing placed him in a distinctive family tree of English gentry, far from rich but determinedly upper-middle-class in the peculiar sense of the English class system. His father Julius had entered the Indian Civil Service, serving in the Madras Presidency, and had there met and married Ethel Sara Stoney. She was the daughter of the chief engineer of the Madras railways, who came from an Anglo-Irish family of somewhat similar social status. Although conceived in British India, most likely in the town of Chatrapur, Alan Turing was born in a nursing home in Paddington, London.";

class FlutterDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailPage(index);
              }));
            },
            child: Hero(
              tag: index,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 20,
                        bottom: 20,
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final index;

  DetailPage(this.index);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final double expandedHeight = 400;
  final double roundedContainerHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              buildSliverHead(),
              SliverToBoxAdapter(child: buildDetail()),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSliverHead() {
    return SliverPersistentHeader(
      delegate: DetailSliverDelegate(
        expandedHeight,
        roundedContainerHeight,
        widget.index,
      ),
    );
  }

  Widget buildDetail() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildUserInfo(),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Container(
              color: Colors.blue[50],
              child: Text(text),
            )
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 24,
        backgroundImage: AssetImage(img),
      ),
      title: Text(alan),
      subtitle: Text(bio),
      trailing: Icon(Icons.share),
    );
  }
}

class DetailSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double roundedContainerHeight;
  final index;

  DetailSliverDelegate(this.expandedHeight, this.roundedContainerHeight, this.index);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Hero(
        tag: index,
        child: Stack(
          children: <Widget>[
            Image.asset(
              img,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: expandedHeight - roundedContainerHeight - shrinkOffset,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: roundedContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Positioned(
              top: expandedHeight - 120 - shrinkOffset,
              left: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    alan,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    bio,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}