//
//  AssetsYieldCurveCollectionViewCell.m
//  DolphinFinancial
//
//  Created by FDXDZ on 2018/3/19.
//  Copyright © 2018年 zhantong. All rights reserved.
//

#import "AssetsYieldCurveCollectionViewCell.h"
#import <Charts/Charts-Swift.h>

#import "AssetEarn.h"

@interface AssetsYieldCurveCollectionViewCell()<ChartViewDelegate,IChartAxisValueFormatter>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *segmentingLine;
@property (nonatomic, strong) LineChartView *chartView;
@property (nonatomic, strong) NSArray<AssetEarn *> *earns;

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
        _chartView.leftAxis.enabled = NO;
        _chartView.rightAxis.enabled = NO;
        _chartView.dragEnabled = NO;
        _chartView.scaleXEnabled = NO;
        _chartView.scaleYEnabled = NO;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.axisMinimum = 0.0;
        xAxis.granularity = 1.0;
        xAxis.valueFormatter = self;

        
        _chartView.legend.form = ChartLegendFormLine;
        
        [_chartView animateWithXAxisDuration:2.5];
    }
    return _chartView;
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

- (void)reloadTrend:(NSArray<AssetEarn *> *)trend
{
    self.earns = trend;
    NSMutableArray<ChartDataEntry *> *values = [[NSMutableArray alloc] init];
    [trend enumerateObjectsUsingBlock:^(AssetEarn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:idx y:[obj.earn doubleValue] data:obj];
        [values addObject:entry];
    }];
    
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
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"收益"];
        
        set1.drawIconsEnabled = NO;
        set1.mode = LineChartModeCubicBezier;
        [set1 setColor:DFTINTCOLOR];
        [set1 setCircleColor:DFTINTCOLOR];
//        set1.lineWidth = 1.0;
        set1.circleRadius = 2.0;
        set1.drawCircleHoleEnabled = NO;
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineWidth = 1.0;
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#001779D4"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ff1779D4"].CGColor
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

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    AssetEarn *earn = SafeArrayObjectIndex(self.earns, (int)value);
    return earn.date;
}


@end
