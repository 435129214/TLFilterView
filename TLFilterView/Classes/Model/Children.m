//
//  Children.m
//
//  Created by   on 2017/12/6
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Children.h"
#import "CategoryGroup.h"

NSString *const kChildrenId = @"id";
NSString *const kChildrenChildren = @"childList";
NSString *const kChildrenHasChildren = @"hasChildren";
NSString *const kChildrenChildrenCount = @"childrenCount";
NSString *const kChildrenDescription = @"description";
NSString *const kChildrenName = @"name";
NSString *const kChildrenCategoryGroup = @"categoryGroup";


@interface Children ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Children

@synthesize childrenIdentifier = _childrenIdentifier;
@synthesize children = _children;
@synthesize hasChildren = _hasChildren;
@synthesize childrenCount = _childrenCount;
@synthesize childrenDescription = _childrenDescription;
@synthesize name = _name;
@synthesize categoryGroup = _categoryGroup;


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
            self.childrenIdentifier = [[self objectOrNilForKey:kChildrenId fromDictionary:dict] doubleValue];
               self.hasChildren = [[self objectOrNilForKey:kChildrenHasChildren fromDictionary:dict] boolValue];
        
#if 1    //此方法是，不管后台返回的情况，只有解析到有子就添加
        {
            id receivedChildren = [dict objectForKey:kChildrenChildren];
            NSMutableArray *parsedChildren = [NSMutableArray array];
            
            if ([receivedChildren isKindOfClass:[NSArray class]]) {
                for (id item in (NSArray *)receivedChildren) {
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        id parseData = [Children modelObjectWithDictionary:item];
                        [parsedChildren addObject:parseData];
                    }
                }
                self.children = [NSArray arrayWithArray:parsedChildren];
            }
            else{
                self.children = [self objectOrNilForKey:kChildrenChildren fromDictionary:dict];
            }
            
        }
#else
        if(self.hasChildren) //此方法是依靠后台的方法，只有后台返回有子时，才进行子类解析
        {
            id receivedChildren = [dict objectForKey:kChildrenChildren];
            NSMutableArray *parsedChildren = [NSMutableArray array];
            
            if ([receivedChildren isKindOfClass:[NSArray class]]) {
                for (id item in (NSArray *)receivedChildren) {
                    if ([item isKindOfClass:[NSDictionary class]]) {
                        id parseData = [Children modelObjectWithDictionary:item];
                        [parsedChildren addObject:parseData];
                    }
                }
                self.children = [NSArray arrayWithArray:parsedChildren];
            }
            else{
                self.children = [self objectOrNilForKey:kChildrenChildren fromDictionary:dict];
            }
            
        }
        else{
            self.children = nil;
        }
#endif

            self.childrenCount = [[self objectOrNilForKey:kChildrenChildrenCount fromDictionary:dict] doubleValue];
            self.childrenDescription = [self objectOrNilForKey:kChildrenDescription fromDictionary:dict];
            self.name = [self objectOrNilForKey:kChildrenName fromDictionary:dict];
            self.categoryGroup = [CategoryGroup modelObjectWithDictionary:[dict objectForKey:kChildrenCategoryGroup]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.childrenIdentifier] forKey:kChildrenId];
    [mutableDict setValue:self.children forKey:kChildrenChildren];
    [mutableDict setValue:[NSNumber numberWithBool:self.hasChildren] forKey:kChildrenHasChildren];
    [mutableDict setValue:[NSNumber numberWithDouble:self.childrenCount] forKey:kChildrenChildrenCount];
    [mutableDict setValue:self.childrenDescription forKey:kChildrenDescription];
    [mutableDict setValue:self.name forKey:kChildrenName];
    [mutableDict setValue:[self.categoryGroup dictionaryRepresentation] forKey:kChildrenCategoryGroup];

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

    self.childrenIdentifier = [aDecoder decodeDoubleForKey:kChildrenId];
    self.children = [aDecoder decodeObjectForKey:kChildrenChildren];
    self.hasChildren = [aDecoder decodeBoolForKey:kChildrenHasChildren];
    self.childrenCount = [aDecoder decodeDoubleForKey:kChildrenChildrenCount];
    self.childrenDescription = [aDecoder decodeObjectForKey:kChildrenDescription];
    self.name = [aDecoder decodeObjectForKey:kChildrenName];
    self.categoryGroup = [aDecoder decodeObjectForKey:kChildrenCategoryGroup];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_childrenIdentifier forKey:kChildrenId];
    [aCoder encodeObject:_children forKey:kChildrenChildren];
    [aCoder encodeBool:_hasChildren forKey:kChildrenHasChildren];
    [aCoder encodeDouble:_childrenCount forKey:kChildrenChildrenCount];
    [aCoder encodeObject:_childrenDescription forKey:kChildrenDescription];
    [aCoder encodeObject:_name forKey:kChildrenName];
    [aCoder encodeObject:_categoryGroup forKey:kChildrenCategoryGroup];
}

- (id)copyWithZone:(NSZone *)zone
{
    Children *copy = [[Children alloc] init];
    
    if (copy) {

        copy.childrenIdentifier = self.childrenIdentifier;
        copy.children = self.children;
        copy.hasChildren = self.hasChildren;
        copy.childrenCount = self.childrenCount;
        copy.childrenDescription = [self.childrenDescription copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.categoryGroup = [self.categoryGroup copyWithZone:zone];
    }
    
    return copy;
}


@end
