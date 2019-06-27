//
//  CLCarMO+CoreDataProperties.m
//  CLCoreDataDemo
//
//  Created by 周冯婷 on 2019/6/26.
//  Copyright © 2019年 周冯婷. All rights reserved.
//
//

#import "CLCarMO+CoreDataProperties.h"

@implementation CLCarMO (CoreDataProperties)

+ (NSFetchRequest<CLCarMO *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CLCar"];
}

@dynamic carBrand;
@dynamic carId;
@dynamic user;

@end
