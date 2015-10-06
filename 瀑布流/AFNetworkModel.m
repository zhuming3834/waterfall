//
//  AFNetworkModel.m
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "AFNetworkModel.h"
#import "AFNetworking.h"

@implementation AFNetworkModel

- (void)downloadDataFromURLString:(NSString *)URLString{
	NSURL *url = [NSURL URLWithString:URLString];
	AFHTTPRequestOperationManager *manage = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
	[manage.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
		if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
			UIAlertView * netStatusAl = [[UIAlertView alloc] initWithTitle:@"服务器连接失败" message:@"请检查网络连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
			[netStatusAl show];  //请检查网络连接
		}
	}];
	[manage.reachabilityManager startMonitoring];
	
	manage.responseSerializer = [AFHTTPResponseSerializer serializer];
	[manage GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self.delegate getDownloadData:responseObject];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		UIAlertView * netStatusAl = [[UIAlertView alloc] initWithTitle:@"服务器连接失败" message:@"请检查网络连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
		[netStatusAl show];  //请检查网络连接
	}];
	
	
}










@end




























