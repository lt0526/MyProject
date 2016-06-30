//
//  ViewController.m
//  LTSports
//
//  Created by 孙晨 on 16/2/18.
//  Copyright © 2016年 nplus. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sportTime.inputView = self.intervalPicker;
    self.sportTime.inputAccessoryView = self.sportTool;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIPickerView *)intervalPicker
{
    if(!_intervalPicker)
    {
        _intervalPicker = [[UIPickerView alloc] init];
        _intervalPicker.tag = 101;
        _intervalPicker.delegate = self;
    }
    return _intervalPicker;
}
- (UIToolbar *)sportTool
{
    if(!_sportTool)
    {
        _sportTool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(didSelectIntervalPicker)];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelSelected)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        _sportTool.items = @[spaceItem, cancelItem, confirmItem];
    }
    return _sportTool;
}

/**
 *  选中时间
 */
- (void)didSelectIntervalPicker
{
    self.sportTime.text = [NSString stringWithFormat:@"%ld分钟", [self.intervalPicker selectedRowInComponent:0]+1];
    [self.view endEditing:YES];
}

- (void)cancelSelected
{
    [self.view endEditing:YES];
}


- (IBAction)startSports:(id)sender {
    [timer invalidate];
    timer = nil;
    timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(playSystemSound) userInfo:nil repeats:YES];
    
    [self.sportActivity startAnimating];
    self.CountLabel.text = [NSString stringWithFormat:@"%d次", 0];
    
    double timerInterval = [self.sportTime.text doubleValue] * 60.0f;
    [self performSelector:@selector(stopPlaying) withObject:nil afterDelay:timerInterval];
    
}

- (void)playSystemSound
{
    AudioServicesPlaySystemSound(1005);
    int count = [self.CountLabel.text intValue];
    self.CountLabel.text = [NSString stringWithFormat:@"%d次", ++count];
}
- (void)stopPlaying
{
    [timer invalidate];
    timer = nil;
    [self.sportActivity stopAnimating];
}


#pragma mark - UIPickerDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld分钟", row+1];
}

@end
