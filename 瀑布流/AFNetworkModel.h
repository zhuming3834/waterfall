//
//  AFNetworkModel.h
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFNetworkDelegate <NSObject>

- (void)getDownloadData:(NSData *)revData;

@end

@interface AFNetworkModel : NSObject


- (void)downloadDataFromURLString:(NSString *)URLString;
@property (nonatomic,strong)id<AFNetworkDelegate>delegate;


@end
