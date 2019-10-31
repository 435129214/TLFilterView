//
//  Children.h
//
//  Created by   on 2017/12/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryGroup;

@interface Children : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double childrenIdentifier;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, assign) BOOL hasChildren;
@property (nonatomic, assign) double childrenCount;
@property (nonatomic, strong) NSString *childrenDescription;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) CategoryGroup *categoryGroup;

//自定义属性
@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) BOOL fobitDeSelected;//禁止取消选择

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
