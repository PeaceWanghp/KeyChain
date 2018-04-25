//
//  ViewController.m
//  KeyChain
//
//  Created by peace on 2018/4/25.
//  Copyright © 2018 peace. All rights reserved.
//

#import "ViewController.h"
#import "KeyChainUtil.h"

static NSString *key = @"test_key";

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -
#pragma mark -- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addButtonWithIndex:0];
    [self deleteButtonWithIndex:1];
    [self updateButtonWithIndex:2];
    [self getButtonWithIndex:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark -- Add
- (void)addButtonWithIndex:(int)index {
    float y = 20 + index*50;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor brownColor]];
    [button setFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    [button setTitle:@"Add" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addAction {
    NSString *text = @"wangheping";
    NSLog(@"Add text(%@) key(%@) value:%d",text,key,[KeyChainUtil saveData:text key:key]);
}

#pragma mark -
#pragma mark -- Delete
- (void)deleteButtonWithIndex:(int)index {
    float y = 20 + index*50;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor brownColor]];
    [button setFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    [button setTitle:@"Delete" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)deleteAction {
    NSLog(@"Delete key(%@) value:%d",key,[KeyChainUtil deleteDataWithKey:key]);
}

#pragma mark -
#pragma mark -- Update
- (void)updateButtonWithIndex:(int)index {
    float y = 20 + index*50;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor brownColor]];
    [button setFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    [button setTitle:@"Update" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)updateAction {
    NSString *text = @"zhang na";
    NSLog(@"Update text(%@) key(%@) value:%d",text,key,[KeyChainUtil saveData:text key:key]);
}

#pragma mark -
#pragma mark -- Get
- (void)getButtonWithIndex:(int)index {
    float y = 20 + index*50;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor brownColor]];
    [button setFrame:CGRectMake(0, y, self.view.frame.size.width, 40)];
    [button setTitle:@"Get" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)getAction {
    NSLog(@"Get text(%@) key(%@)",[KeyChainUtil dataWithKey:key],key);
}

@end
