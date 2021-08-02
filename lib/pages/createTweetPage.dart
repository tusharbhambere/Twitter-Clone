import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import 'package:twitter_clone/themes.dart';

class CreateTweetPage extends StatefulWidget {
  static const routename = '/CreateTweet';
  CreateTweetPage({Key? key}) : super(key: key);

  @override
  _CreateTweetPageState createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends State<CreateTweetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isEnabled = false;
  final _tweet = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(CupertinoIcons.xmark,
                        color: TwitterTheme.blueTColor),
                  ),
                  MaterialButton(
                    // TODO: use StateProvider instead of setstate
                    onPressed: _tweet.text.isEmpty ? null : () {},
                    child: Text('Tweet'),
                    color: TwitterTheme.blueTColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ],
              ),
              Consumer(
                builder: (context, watch, _) {
                  final _userProfileimage = watch(getUserProfileDataProvider);
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    leading: _userProfileimage.when(
                        data: (data) => CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(data.avatarUrl)),
                        loading: () =>
                            CircleAvatar(backgroundColor: Colors.blue),
                        error: (e, trace) =>
                            CircleAvatar(child: Text(e.toString()))),
                    title: TextFormField(
                      controller: _tweet,
                      onChanged: (val) {
                        setState(() {
                          _isEnabled = true;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'What\'s happening? ',
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
