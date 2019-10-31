//
//  FilterSearchView.h
//  UnicomApp3
//
//  Created by Jack on 2018/1/25.
//

#import <UIKit/UIKit.h>
#import "TLFilterCommonHeader.h"

@interface FilterSearchView : UIView<UITextFieldDelegate>

@property(nonatomic, strong) UILabel *title;

@property(nonatomic, strong) UITextField *searchField;

@property(nonatomic, copy) void(^SearchClick)(NSString *text);

@end
