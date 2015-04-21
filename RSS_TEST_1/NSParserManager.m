//
//  NSParser.m
//  SidebarDemo
//
//  Created by Andy on 4/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "NSParserManager.h"
#import "NSNews.h"

@interface NSParserManager () <NSXMLParserDelegate>
{
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *imageUrl;
    NSString *element;
}
@property (strong, nonatomic) NSData *rssData;
//@property (strong, nonatomic) NSURL *xmlUrl;
//@property (strong, nonatomic) NSMutableArray *urlsArray;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) NSDictionary *category;

/*
@property (strong, nonatomic) NSString *element;
@property (strong, nonatomic) NSMutableDictionary *item;
@property (strong, nonatomic) NSMutableString *title;
@property (strong, nonatomic) NSMutableString *link;
@property (strong, nonatomic) NSMutableArray *feeds;
*/
 @end
@implementation NSParserManager
+(instancetype)sharedInstance {

    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}/*
-(void)getNewsWithCategory:(NSDictionary *)category onSuccess:(void (^)(NSArray *))success onFailure:(void (^)(NSError *, NSInteger))failure {

    
    self.feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    //parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    rssParser.delegate = self;
    [rssParser parse];
    
    NSMutableArray *objectsArray = [NSMutableArray array];
    NSLog(@"%lu",[self.feeds count]);
    for (NSDictionary *dict in self.feeds) {
        NSNews *news = [[NSNews alloc] initWithServerResponse:dict];
        [objectsArray addObject:news];
        NSLog(@"objectsArray =  %@",dict);
    }
    if (success) {
        success(objectsArray);
    }
    
}*/

-(void)getNewsWithCategory:(NSDictionary*)category
                       key:(NSString*)keyCategory
                 onSuccess:(void(^)(NSArray *news)) success
                           onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure
{
    NSLog(@"go");
    feeds = [[NSMutableArray alloc] init];
    self.dict = category;
    self.category = [self.dict objectForKey:keyCategory];
  //  NSArray *arr = [self.category allValues];
 
    
    

    
    NSMutableArray *array = [NSMutableArray new];
    [self.category enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [array addObject:obj];
    }];
    for (NSString *url in array) {
        
        NSURL *xmlUrl = [NSURL URLWithString:url];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:xmlUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                                        if (!error) {
                                                            if ([request.URL isEqual:xmlUrl]) {
                                                                self.rssData = [NSData dataWithContentsOfURL:localfile];
                                                                
                                                                
                                                                parser = [[NSXMLParser alloc] initWithData:self.rssData];
                                                                parser.delegate = self;
                                                                [parser setShouldResolveExternalEntities:NO];
                                                                [parser parse];
                                                                
                                                                NSMutableArray *objectsArray = [NSMutableArray array];
                                                                
                                                                for (NSDictionary *dict in feeds) {
                                                                     NSNews *news = [[NSNews alloc] initWithServerResponse:dict];
                                                                    [objectsArray addObject:news];
                                                                    
                                                                }
                                                                if (success) {
                                                                    success(objectsArray);
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                    }];
    [task resume];
    
    }
                       
    

   
    
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if([element isEqualToString:@"item"]) {
    
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        imageUrl = [[NSMutableString alloc] init];
    

    }
}
- (NSString *)findFirstImgUrlInString:(NSString *)string
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSTextCheckingResult *result = [regex firstMatchInString:string
                                                     options:0
                                                       range:NSMakeRange(0, [string length])];
    
    if (result)
        return [string substringWithRange:[result rangeAtIndex:2]];
    
    return nil;
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }else if ([element isEqualToString:@"image"]) {
        [imageUrl appendString:string];
    }

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([elementName isEqualToString:@"item"]) {
        
        if (title) {
            [item setObject:title forKey:@"title"];

        }
        if (link) {
            [item setObject:link forKey:@"link"];

        }
        NSString *imgUrl = [self findFirstImgUrlInString:imageUrl];
        if (imgUrl) {
            [item setObject:imgUrl forKey:@"imageUrl"];
        }else {
           // NSLog(@"NO IMAGE");
            
        }
        
        [feeds addObject:[item copy]];
        
    }
    
}
-(void)parserDidEndDocument:(NSXMLParser *)parser {

    

 
}

@end
