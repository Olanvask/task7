//
//  PostInCoreData+CoreDataProperties.h
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
//

#import "PostInCoreData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PostInCoreData (CoreDataProperties)

+ (NSFetchRequest<PostInCoreData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *videoURL;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *descr;
@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic) int16_t duration;
@property (nonatomic) int16_t speakers;

@end

NS_ASSUME_NONNULL_END
