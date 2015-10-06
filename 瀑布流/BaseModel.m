//
//  BaseModel.m
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


- (NSArray *)setBaseModelWithDictionary:(NSDictionary *)dice{
	NSMutableArray *baseModelArr = [[NSMutableArray alloc] init];
	NSArray *dataArr = dice[@"data"][@"data"];
	for (NSDictionary *dic in dataArr) {
		BaseModel *model = [BaseModel setModelWithDictionary:dic];
		[baseModelArr addObject:model];
	}
	return baseModelArr;
}

+ (BaseModel *)setModelWithDictionary:(NSDictionary *)dice{
	BaseModel *model = [[BaseModel alloc] init];
	
	[model setValue:dice[@"brand_name"] forKey:@"brand_name"];
	[model setValue:dice[@"new_height"] forKey:@"height"];
	[model setValue:dice[@"new_width"] forKey:@"width"];
	[model setValue:dice[@"pic_url_d"] forKey:@"pic_url_d"];
	[model setValue:dice[@"pic_url_x"] forKey:@"pic_url_x"];
	[model setValue:dice[@"price"] forKey:@"price"];
	[model setValue:dice[@"title"] forKey:@"title"];
	return model;
}


@end





























