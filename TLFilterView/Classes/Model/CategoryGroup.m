//
//  CategoryGroup.m
//
//  Created by   on 2017/12/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "CategoryGroup.h"


NSString *const kCategoryGroupId = @"id";
NSString *const kCategoryGroupName = @"name";
NSString *const kCategoryGroupIdentifier = @"identifier";
NSString *const kCategoryGroupRemark = @"remark";


@interface CategoryGroup ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoryGroup

@synthesize categoryGroupIdentifier = _categoryGroupIdentifier;
@synthesize name = _name;
@synthesize identifier = _identifier;
@synthesize remark = _remark;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoryGroupIdentifier = [[self objectOrNilForKey:kCategoryGroupId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kCategoryGroupName fromDictionary:dict];
            self.identifier = [self objectOrNilForKey:kCategoryGroupIdentifier fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kCategoryGroupRemark fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryGroupIdentifier] forKey:kCategoryGroupId];
    [mutableDict setValue:self.name forKey:kCategoryGroupName];
    [mutableDict setValue:self.identifier forKey:kCategoryGroupIdentifier];
    [mutableDict setValue:self.remark forKey:kCategoryGroupRemark];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.categoryGroupIdentifier = [aDecoder decodeDoubleForKey:kCategoryGroupId];
    self.name = [aDecoder decodeObjectForKey:kCategoryGroupName];
    self.identifier = [aDecoder decodeObjectForKey:kCategoryGroupIdentifier];
    self.remark = [aDecoder decodeObjectForKey:kCategoryGroupRemark];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_categoryGroupIdentifier forKey:kCategoryGroupId];
    [aCoder encodeObject:_name forKey:kCategoryGroupName];
    [aCoder encodeObject:_identifier forKey:kCategoryGroupIdentifier];
    [aCoder encodeObject:_remark forKey:kCategoryGroupRemark];
}

- (id)copyWithZone:(NSZone *)zone
{
    CategoryGroup *copy = [[CategoryGroup alloc] init];
    
    if (copy) {

        copy.categoryGroupIdentifier = self.categoryGroupIdentifier;
        copy.name = [self.name copyWithZone:zone];
        copy.identifier = [self.identifier copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
    }
    
    return copy;
}


@end
