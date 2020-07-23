//
//  XMLParser.m
//  rs.ios-stage2-task7
//
//  Created by Oleg Vasiluk on 7/22/20.
//  Copyright © 2020 Oleg Vasiluk. All rights reserved.
//

#import "XMLParser.h"
#import "Post.h"
@interface XMLParser()<NSXMLParserDelegate>
@property (nonatomic, copy) void (^completion)(NSArray<Post *> *, NSError *);

@property (nonatomic, strong) NSMutableDictionary *postDictionary;
@property (nonatomic, strong) NSMutableDictionary *parsingDictionary;
@property (nonatomic, strong) NSMutableString *parsingString;
@property (nonatomic, strong) NSMutableArray *posts;
@end

@implementation XMLParser

- (void) parseData:(NSData *)data
        completion:(void (^)(NSArray<Post *> *, NSError *))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }
    [self resetParserState];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.posts = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([elementName isEqualToString:@"item"]) {
        self.postDictionary = [NSMutableDictionary new];
    }
    else if ([elementName isEqualToString:@"itunes:image"]){
        [self.postDictionary setValue:attributeDict[@"url"] forKey:@"imageURL"];
    }else if ([elementName isEqualToString:@"enclosure"]){
        [self.postDictionary setValue:attributeDict[@"url"] forKey:@"videoURL"];
    }else{
        self.parsingString = [NSMutableString new];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if (self.parsingString) {
        [self.postDictionary setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    }
    
    if ([elementName isEqualToString:@"item"]) {
        Post *post = [[Post alloc] initWithDictionary:self.postDictionary];
        self.postDictionary = nil;
        [self.posts addObject:post];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.posts, nil);
    }
    [self resetParserState];
}

#pragma mark - Private methods

- (void)resetParserState {
    self.completion = nil;
    self.posts = nil;
    self.postDictionary = nil;
    self.parsingString = nil;
}

@end
