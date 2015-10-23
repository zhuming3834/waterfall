//
//  ViewController.m
//  瀑布流
//
//  Created by HGDQ on 15/10/6.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkModel.h"
#import "BaseModel.h"
#import "UIImageView+WebCache.h"
#import "MyCollectionViewCell.h"

#define URLSTRING   @"http://itugo.com/client/ios/api/getpiclist?_version=20140117.2.5.1&_req_from=oc&_source=ios&type=&_uuid=efe47094e00109db8c28cf0ae9b607b9&max=&tag=&_promotion_channel=App%20Store&_platform=iPhone&sort=new&from=tag&_uiid=2FF998CF0D2A40E7AF6F8FAFB8F57538&_net=wifi&min=0"

@interface ViewController ()<AFNetworkDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self startDownloadData];
	[self setMainView];
	
	// Do any additional setup after loading the view, typically from a nib.
}

/**
 *  设置主页显示的collectionView
 */
- (void)setMainView{
	UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
	flow.scrollDirection = UICollectionViewScrollDirectionVertical;
	
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flow];
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.view addSubview:self.collectionView];
	
	[self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCell"];
}
/**
 *  确定item的个数
 *
 *  @param collectionView collectionView 本身
 *  @param section        每个section里面的item的个数
 *
 *  @return item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.dataArr.count;
}
/**
 *  设置每个item的大小
 *
 *  @param collectionView       collectionView 本身
 *  @param collectionViewLayout flow
 *  @param indexPath            item的位置
 *
 *  @return 需要设置的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	BaseModel *model = (BaseModel *)self.dataArr[indexPath.row];
	double width = model.width.doubleValue;
	double height = model.height.doubleValue;
	return CGSizeMake(width/2.0,height/2.0);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//	return UIEdgeInsetsMake(1, 1, 1, 1);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//	return 5;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//	return 5;
//}

/**
 *  cell的实现
 *
 *  @param collectionView collectionView 本身
 *  @param indexPath      indexPath
 *
 *  @return return cell
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
	BaseModel *model = (BaseModel *)self.dataArr[indexPath.row];
	cell.backImageView.clipsToBounds = YES;
	[cell.backImageView setImageWithURL:[NSURL URLWithString:model.pic_url_d]];
	return cell;
}
/**
 *  开始下载数据
 */
- (void)startDownloadData{
	AFNetworkModel *Amodel = [[AFNetworkModel alloc] init];
	[Amodel downloadDataFromURLString:URLSTRING];
	Amodel.delegate = self;
}
/**
 *  实现下载数据协议方法
 *
 *  @param revData 返回下载好的数据
 */
- (void)getDownloadData:(NSData *)revData{
	//JSON数据的解析
	NSDictionary *dice = [NSJSONSerialization JSONObjectWithData:revData options:NSJSONReadingMutableContainers error:nil];
	NSLog(@"dice = %@",dice);
	//数据存入模型
	BaseModel *Bmodel = [[BaseModel alloc] init];
	self.dataArr = [Bmodel setBaseModelWithDictionary:dice];
	//collectionView 加载数据
	[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}






















@end
