//
//  AssetsYieldCurveCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsYieldCurveCollectionViewCell.h"
#import <Charts/Charts-Swift.h>

@interface AssetsYieldCurveCollectionViewCell()<ChartViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *segmentingLine;
@property (nonatomic, strong) LineChartView *chartView;


@end


@implementation AssetsYieldCurveCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self makeView];
    }
    return self;
}

+ (CGSize)cellSize
{
    return CGSizeMake(DFSCREENW, 176);
}
+ (NSString*)reuseIdentifier
{
    return NSStringFromClass([self class]);
}
+ (void)registCell:(UICollectionView *) collectionView
{
    [collectionView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}
- (void)makeView
{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(6);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
    }];
    
    [self.contentView addSubview:self.segmentingLine];
    [self.segmentingLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(6);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentView addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentingLine.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = DFColorWithHexString(@"#101010");
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.text = @"收益曲线";
    }
    return _titleLabel;
}
- (UIView *)segmentingLine
{
    if (!_segmentingLine) {
        _segmentingLine = [UIView new];
        _segmentingLine.backgroundColor = DFColorWithHexString(@"#F8F8F8");
    }
    return _segmentingLine;
}
- (LineChartView *)chartView
{
    if (!_chartView) {
        _chartView = [[LineChartView alloc] init];
        _chartView.delegate = self;
        _chartView.noDataText = @"暂无数据";
        _chartView.scaleYEnabled = NO;
        _chartView.chartDescription.enabled = NO;
        
        _chartView.dragEnabled = YES;
        [_chartView setScaleEnabled:YES];
        _chartView.pinchZoomEnabled = YES;
        _chartView.drawGridBackgroundEnabled = NO;
        
        // x-axis limit line
        ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
        llXAxis.lineWidth = 4.0;
        llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
        llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
        llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
        
        //[_chartView.xAxis addLimitLine:llXAxis];
        
        _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
        _chartView.xAxis.gridLineDashPhase = 0.f;
        
        ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"Upper Limit"];
        ll1.lineWidth = 4.0;
        ll1.lineDashLengths = @[@5.f, @5.f];
        ll1.labelPosition = ChartLimitLabelPositionRightTop;
        ll1.valueFont = [UIFont systemFontOfSize:10.0];

        ChartLimitLine *ll2 = [[ChartLimitLine alloc] initWithLimit:-30.0 label:@"Lower Limit"];
        ll2.lineWidth = 4.0;
        ll2.lineDashLengths = @[@5.f, @5.f];
        ll2.labelPosition = ChartLimitLabelPositionRightBottom;
        ll2.valueFont = [UIFont systemFontOfSize:10.0];
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        [leftAxis removeAllLimitLines];
        [leftAxis addLimitLine:ll1];
        [leftAxis addLimitLine:ll2];
        leftAxis.axisMaximum = 200.0;
        leftAxis.axisMinimum = 0;
        leftAxis.gridLineDashLengths = @[@5.f, @5.f];
        leftAxis.drawZeroLineEnabled = YES;
        leftAxis.drawLimitLinesBehindDataEnabled = YES;
        
        _chartView.rightAxis.enabled = NO;
        
        [_chartView.viewPortHandler setMaximumScaleY: 2.f];
        [_chartView.viewPortHandler setMaximumScaleX: 2.f];
        

        
        _chartView.legend.form = ChartLegendFormLine;
        

        [self setDataCount:45.0 range:100.0];
        
        [_chartView animateWithXAxisDuration:2.5];
    }
    return _chartView;
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 3;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        
        set1.drawIconsEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        set1.drawFilledEnabled = YES;
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"entry:%@,highlight:%@",entry,highlight);
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}


@end
