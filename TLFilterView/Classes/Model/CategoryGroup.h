//
//  CategoryGroup.h
//
//  Created by   on 2017/12/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CategoryGroup : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double categoryGroupIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *remark;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
