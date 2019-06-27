//
//  CLUserMO+CoreDataProperties.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/27.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLUserMO+CoreDataProperties.h"

@implementation CLUserMO (CoreDataProperties)

+ (NSFetchRequest<CLUserMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CLUser"];
}

@dynamic secionId;
@dynamic userId;
@dynamic userName;
@dynamic cars;
@dynamic houses;

@end
