//
//  Post.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/21/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "Post.h"

@implementation Post
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _title = dictionary[@"title"];
        _speaker = dictionary[@"media:credit"];
        _imageURL = [NSURL URLWithString: dictionary[@"imageURL"]];
        _videoURL = [NSURL URLWithString:dictionary[@"videoURL"]];
        _url = [NSURL URLWithString:dictionary[@"link"]];
    }
    return self;
};
@end
