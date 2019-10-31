//
//  TLFilterViewController.h
//  Masonry
//
//  Created by liyanlei1 on 2019/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLFilterViewController : UIViewController

@property(nonatomic, assign) CGFloat leftW;//左侧距离

//此属于如果是YES，就没有数据请求
@property(nonatomic, assign) BOOL noNetRequest;

@property (nonatomic,strong) UITableView *myTableView;

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

-(void) insertDataArr:(NSArray *)dataArr sectionTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
