//
//  PostInCoreData+CoreDataProperties.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/23/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//
//

#import "PostInCoreData+CoreDataProperties.h"

@implementation PostInCoreData (CoreDataProperties)

+ (NSFetchRequest<PostInCoreData *> *)fetchRequest {
    NSFetchRequest<PostInCoreData *> *request = [NSFetchRequest fetchRequestWithEntityName:@"PostInCoreData"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    return request;
}


@dynamic title;
@dynamic videoURL;
@dynamic imageURL;
@dynamic descr;
@dynamic duration;
@dynamic speakers;
@dynamic url;

@end
