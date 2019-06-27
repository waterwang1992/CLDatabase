//
//  CLHouseMO+CoreDataProperties.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLHouseMO+CoreDataProperties.h"

@implementation CLHouseMO (CoreDataProperties)

+ (NSFetchRequest<CLHouseMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CLHouse"];
}

@dynamic address;
@dynamic houseId;
@dynamic user;

@end
