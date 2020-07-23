//
//  Loader.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "Loader.h"
#import "XMLParser.h"
@implementation Loader
- (void)loadPostsWithCompletion:(void (^)(NSArray *, NSError *))completion{
    NSURL *url = [NSURL URLWithString:@"https://www.ted.com/themes/rss/id"];
      NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                        dataTaskWithURL:url
                                        completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError * error) {
   
          if (!data) { return; }
          XMLParser *parser = [XMLParser new];
          [parser parseData:data completion:completion];
      }];
      [dataTask resume];
    
}
- (void)loadImageWithURL: (NSURL *) url completion:(void (^)(UIImage *, NSError *))completion{

      NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                        dataTaskWithURL:url
                                        completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError * error) {
   
          if (!data) { return; }
          UIImage *image = [[UIImage alloc] initWithData:data];
          completion(image,error);
      }];
      [dataTask resume];
}
@end
