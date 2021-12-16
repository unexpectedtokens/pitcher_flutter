
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pitcher/models/climb.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pitcher/models/send.dart';
import 'package:pitcher/reusables/content_title.dart';
import 'package:pitcher/reusables/creator_title.dart';
import 'package:pitcher/reusables/likes_display.dart';
import 'package:pitcher/reusables/send_card.dart';

class ClimbDetailArgs{
  final Climb climb;

  ClimbDetailArgs({
    required this.climb
  });
}





class ContentContainer extends StatelessWidget{
  final Widget content;

  const ContentContainer({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: content,
      padding: const EdgeInsets.all(30.0),
    );
  }
}


class ClimbDetail extends StatefulWidget {
  const ClimbDetail({Key? key}) : super(key: key);

  @override
  _ClimbDetailState createState() => _ClimbDetailState();
}

class _ClimbDetailState extends State<ClimbDetail> {
  XFile? bannerImage;
  bool initialLoad = true;
  late Climb climb;
  List<Send> sendList = [];

  
  Future takeImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      bannerImage = image;
    });

  }

  void _loadSends(int id) async {
    var sends = await Send.getSendsForClimb(id);
    setState((){
      sendList = sends;
    });
  }




  @override
  Widget build(BuildContext context) {
    if(initialLoad){
      final args = ModalRoute.of(context)!.settings.arguments as ClimbDetailArgs;
      var curClimb = args.climb;
      setState((){
        initialLoad = false;
        climb = curClimb;
      });
      _loadSends(curClimb.id!);
    }


    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    bannerImage != null ? Image.file(
                        File(bannerImage!.path),
                    ) :  Container(
                      child: Text(""),
                    ),
                    ContentContainer(
                        content: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ContentTitle(
                                          title: "${climb.name} - ${climb.grade}"
                                      ),
                                      CreatorText(
                                          username: climb.climber.username
                                      ),
                                    ],
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          // Navigator.pushNamed(
                                          //     context,
                                          //     "/climbcamera"
                                          // );
                                          takeImage();
                                        },
                                        icon: const Icon(Icons.add_a_photo),
                                      ),
                                      LikesDisplay(
                                          likedByUser: true,
                                          action: (){
                                            print("liked");
                                          },
                                          likes: climb.likes.length
                                      ),
                                    ],
                                  ),

                                  Text("This climb has ${sendList.length} sends")
                                ],
                              ),
                            ]
                        )
                    ),
                    const Divider(
                        height: 2.0,
                        color: Colors.grey
                    ),
                    ContentContainer(
                        content: Text(climb.description)
                    ),
                    ContentContainer(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Send by",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: ()async {
                                await Navigator.pushNamed(
                                    context, "/climbaddsend",
                                    arguments: {"id": climb.id}
                                );
                                _loadSends(climb.id!);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.blue,

                              ),
                              child: Row(
                                children: const [
                                  Icon(

                                      Icons.add
                                  ),
                                  Text("Add send")
                                ],
                              ))],
                      ),
                    ),
                    sendList.length > 0 ?
                    ConstrainedBox(

                      child: ListView.builder(
                          itemCount: sendList.length,
                          itemBuilder: (BuildContext context, int index){
                            return SendCard(
                              send: sendList[index],
                            );
                          }
                      ),
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight / 2,
                          maxHeight: constraints.maxHeight / 2
                      ),

                    ) : const ContentContainer(
                        content: Text(
                            "This climb hasn't been completed by anyone yet"
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              );
            }
        ),
      ),

    );
  }
}





