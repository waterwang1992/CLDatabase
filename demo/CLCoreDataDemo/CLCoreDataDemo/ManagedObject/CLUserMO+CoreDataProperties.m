//
//  CLUserMO+CoreDataProperties.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLUserMO+CoreDataProperties.h"

@implementation CLUserMO (CoreDataProperties)

+ (NSFetchRequest<CLUserMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CLUser"];
}

@dynamic userId;
@dynamic userName;
@dynamic secionId;
@dynamic cars;
@dynamic houses;

@end
