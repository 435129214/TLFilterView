//
//  TLFilterViewController.h
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLFilterViewController : UIViewController

//此属于如果是YES，就没有数据请求
@property(nonatomic, assign) BOOL noNetRequest;
//是否开启自动关闭功能
@property(nonatomic, assign) BOOL openRemoveFlag;

@property (nonatomic,strong) UIView *topHeader;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *resetBt,*sureBt;
#pragma mark 底部视图属性
//如果有footView,设置此数据
@property(nonatomic, strong) NSArray *footDataArr;

#pragma mark 基本回调函数
//没有头部和底部控件，只有主控件
@property(nonatomic, copy) void(^DoFilter)(NSDictionary *dic);

//包含主控件，头部和底部控件
@property(nonatomic, copy) void(^DoMoreFilterParam)(NSDictionary *dic, NSDictionary *headDic, NSDictionary *footDic);

//底部按钮视图
@property(nonatomic, strong) UIView *bottomView;

//向后面追加数据
-(void) appendDataArr:(NSArray *)dataArr sectionTitle:(NSString *)title;

//像指定位置添加数据
-(void) insertDataArr:(NSArray *)dataArr sectionTitle:(NSString *)title at:(NSInteger)at;

@end

NS_ASSUME_NONNULL_END
