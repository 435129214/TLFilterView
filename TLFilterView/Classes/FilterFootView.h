//
//  FilterFootView.h
//  UnicomApp3
//
//  Created by Jack on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "TLFilterCommonHeader.h"

@interface FilterFootView : UIView

@property(nonatomic,strong) UIButton *openOrHideBt;

//外部传入,数组元素为字典，此数组个数就是section个数，数组最底层数据，必须是Children类型
//字典包含至少包含一个title 是标题，一个data,一个type用于标识是什么分类,一个multi标记是否可以多选，对应标题下面的数组数据
@property(nonatomic, strong) NSArray *dataArr;

//处理点击时就想要外面页面更新的情况
@property(nonatomic, copy) void(^SendOutClickItem)(id item);

-(void) ResetAllSelectState;

-(NSDictionary *)GetNeedPara;

@end
