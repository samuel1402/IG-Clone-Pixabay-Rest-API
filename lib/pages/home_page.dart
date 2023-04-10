import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ig_flutter_ui/models/content_model.dart';
import 'package:ig_flutter_ui/widgets/bubble_story.dart';
import 'package:ig_flutter_ui/widgets/user_post.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Content> users = [
    // 'Erika',
    // 'Hasan',
    // 'Suryono',
    // 'Ngatman',
    // 'Budi',
    // 'Rojanah',
    // 'Bahri',
    // 'Erwin',
    // 'Rocky'
  ];

  final String dataUrl =
      'https://pixabay.com/api/?key=31248557-13e87bcf1d8a9e590bdee5d75&q=background&image_type=photo&pretty=true';

  Future<List<Content>> getListContent() async {
    final response = await Dio().get(dataUrl);
    final dataModel =
        ContentModel.fromJson(response.data as Map<String, dynamic>);
    return dataModel.listContent;
  }

  List<Content> listContent = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getListContent().then((result) {
      listContent = result;
      _isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pixabay_Rest API",
          style: TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          SvgPicture.asset(
            'assets/icons/ic_add.svg',
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              'assets/icons/ic_favorite.svg',
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              'assets/icons/ic_send.svg',
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BubbleStory(
                    name: listContent[index].user.toString(),
                    isMe: index == 0 ? true : false,
                    isLive: index == 1 ? true : false,
                  );
                },
                itemCount: listContent.length,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (contex, index) {
              return UserPost(
                content: listContent[index],
              );
            },
            childCount: listContent.length,
          )),
        ],
      ),

      // Column(
      //   children: [
      //     SizedBox(
      //       height: 120,
      //       child: ListView.builder(
      //         scrollDirection: Axis.horizontal,
      //         itemBuilder: (context, index) {
      //           return BubbleStory(
      //             name: users[index],
      //             isMe: index == 0 ? true : false,
      //             isLive: index == 1 ? true : false,
      //           );
      //         },
      //         itemCount: users.length,
      //       ),
      //     ),
      //     const Divider(
      //       height: 1,
      //     ),
      //     Expanded(
      //       child: ListView.builder(
      //         itemBuilder: (context, index) {
      //           return UserPost(
      //             content: listContent[index],
      //           );
      //         },
      //         itemCount: listContent.length,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
