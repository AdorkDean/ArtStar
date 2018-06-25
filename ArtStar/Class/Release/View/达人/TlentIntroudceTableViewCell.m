//
//  TlentIntroudceTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "TlentIntroudceTableViewCell.h"

@implementation TlentIntroudceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)locationClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(whereAreYour)]) {
        [self.delegate whereAreYour];
    }
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length > 0) {
        _plholderLab.hidden = YES;
    }else{
        _plholderLab.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
