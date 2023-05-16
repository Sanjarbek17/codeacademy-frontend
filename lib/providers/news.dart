import 'package:flutter/material.dart';

import '../models/message.dart';

class NewsMessages with ChangeNotifier {
  List<Message> messages = [
    // i need four messages with my message model
    Message(
      title: 'First \nMessage',
      isNew: true,
      body: 'Apple News+ delivers an incredibly diverse collection of the world’s best publications. Vivid photography and animation, rich videos, and immersive layouts bring articles to life in stunning new ways. Swipe through issues from cover to cover or download them to read on the go.',
      date: '2021-09-01 12:35',
    ),
    Message(
      title: 'Second\n Message',
      body: 'Apple News+ delivers an incredibly diverse collection of the world’s best publications. Vivid photography and animation, rich videos, and immersive layouts bring articles to life in stunning new ways. Swipe through issues from cover to cover or download them to read on the go.',
      date: '2021-08-01 19:28',
    ),
    Message(
      title: 'Third Message\nThird Message',
      body: 'TApple News+ delivers an incredibly diverse collection of the world’s best publications. Vivid photography and animation, rich videos, and immersive layouts bring articles to life in stunning new ways. Swipe through issues from cover to cover or download them to read on the go.',
      date: '2021-07-01 20:55',
    ),
    Message(
      title: 'Fourth Message',
      body: 'Apple News+ delivers an incredibly diverse collection of the world’s best publications. Vivid photography and animation, rich videos, and immersive layouts bring articles to life in stunning new ways. Swipe through issues from cover to cover or download them to read on the go.',
      date: '2021-06-01 21:35',
    ),
  ];
}
