//
//  FeedItem.swift
//  KarrotRouter
//
//  Created by Geektree0101 on 2020/07/01.
//  Copyright © 2020 Geektree0101. All rights reserved.
//

import Foundation

struct FeedItem {
  
  var id: Int
  var card: Card?
  var user: User?
}

extension FeedItem {
  
  static func dummyData() -> [FeedItem] {
    return seedFeedItems
  }
  
  static func dummyData(userID: Int) -> [FeedItem] {
    return seedFeedItems.filter({ $0.user?.id == userID })
  }
}

private let seedFeedItems = [
  FeedItem(
    id: 1,
    card: Card(
      id: 1,
      title: "Bts Memes are just way to funny",
      content: """
If your not a fan of bts your probly a caveman, are just living in a cave somewhere, but either way i have some funny bts memes to make you smile are just to convert you and make you a fan.

but if that doesnt work i can always try brain washing you.
So i was browsing the internet and found some awesome bts memes and just want to share them here after all, if you cant mix the funny with the awesome then life really doesnt make much sense, so have a laugh and thank me later.

The Things we hope for and tell our selves but we all know its not so lol funny
"""
    ),
    user: User(
      id: 1,
      username: "coollie"
    )
  ),
  FeedItem(
    id: 2,
    card: Card(
      id: 2,
      title: "New BTS Community President!!",
      content: """
Hello ARMY!!🤗I just wanted to make this card to let you all know that I did not apply to be the president again for the BTS community! I have decided that I will not be getting on here as much. Because I have so many things going on In my life right now and I need to focus on that. But you will still be seeing post here and there. I would also like to say thank you to my team  @Mochiroon @MelissaGarza @DefSoul1994 !!💕 These girls have worked their butts off on here and helped maintain the BTS community! I really appreciate you all for the help! Thank you again girls!
"""
    ),
    user: User(
      id: 2,
      username: "Yugykookie97"
    )
  ),
  FeedItem(
    id: 3,
    card: Card(
      id: 3,
      title: "Funny Halloween Costume Pics You need to see",
      content: """
When people Think about halloween they really dont think about the Humor part of the halloween theme, I know you dont, because most people only think of the scary halloween adventure are the candy, But for me, I love funny Halloween costumes, I really cant stand the scary costumes, and its not because im afraid are anything, Its just that i find more fun in humor than scary things.

And I really cant see why anyone would want to be Scared, Wouldnt it be better to smile.
Anyways so i found these amazing funny Halloween pics and i couldnt stop my self from sharing them, lol so ill share a few with you guys, who and if you want to see more funny Halloween Pics ill leave a link.

This first costume is crazy, who did this lol, now i know what character is was going for but it sure didnt work out the way he planed it. and the people who sold him this halloween costume new what they was doing what a rip off.

"""
    ),
    user: User(
      id: 1,
      username: "coollie"
    )
  ),
  FeedItem(
    id: 4,
    card: Card(
      id: 4,
      title: "Funny Stuff",
      content: """
  I really like funny Pics and i want to share some, so if your into funny memes and pics then these 5 pics will be really funny and you can have a good laugh.
  """
    ),
    user: User(
      id: 1,
      username: "coollie"
    )
  ),
  FeedItem(
    id: 5,
    card: Card(
      id: 5,
      title: "BTS FESTA D-5!!! Jungkook: “Still With You”!!!🙌🏻😭 💜",
      content: "Hello ARMY!!!🤗Jungkook just posted his song on twitter!!!! Asdfghjkl!!! Omg!!"
    ),
    user: User(
      id: 2,
      username: "Yugykookie97"
    )
  )
]
