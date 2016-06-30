//
//  ViewController.h
//  LTSports
//
//  Created by 孙晨 on 16/2/18.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>


/** 健身时间Picker */
@property (nonatomic, strong) UIPickerView *intervalPicker;
/** 健身的tool */
@property (nonatomic, strong) UIToolbar *sportTool;



/** 计数器 */
@property (weak, nonatomic) IBOutlet UILabel *CountLabel;
/** 运动判断 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *sportActivity;


/**
 *  健身时间
 */
@property (weak, nonatomic) IBOutlet UITextField *sportTime;



/**
 *  开始健身
 */
- (IBAction)startSports:(id)sender;

@end

