import {
  BarChart, // 柱状图图表类
  BarChartModel, // 柱状图配置构建类
  BarData, // 柱状图数据包
  BarDataSet, // 柱状图数据集合
  BarEntry, // 柱状图数据结构
  ChartGesture, // 手势事件模式
  Description, // 图表Description(描述)部件
  EntryOhos, // 图表数据结构基础类
  Fill, // 图表填充类型构建类
  Highlight, // 图表高亮数据
  IBarDataSet, // 柱状图数据集合的操作类
  JArrayList, // 工具类：数据集合
  Legend, // 图表Legend(图例)部件
  LimitLabelPosition, // 图表的LimitLine标签位置枚举类
  LimitLine, // 图表LimitLine
  MarkerView, // 图表的Marker(标志气泡)部件
  OnChartGestureListener, // 手势事件监听
  OnChartValueSelectedListener, // 数据选择监听
  XAxis, // 图表X轴部件
  XAxisPosition, // 图表X轴标签位置枚举类
  YAxis, // 图表Y轴部件
  YAxisLabelPosition // 图表Y轴标签位置枚举类
} from '@ohos/mpchart';

@Entry
@Component
struct DataPage {
  model: BarChartModel | null = null; // 柱状图模型
  limitLine1: LimitLine | null = null
  limitLine2: LimitLine | null = null
  leftAxis: YAxis | null = null
  rightAxis: YAxis | null = null
  xAxis: XAxis | null = null
  normalMarker: MarkerView | null = null
  // stackMarker: CustomMarkerView | null = null
  data: BarData | null = null

    // 构造数据选择监听器
  private valueSelectedListener: OnChartValueSelectedListener = {
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      // ...todoSomething
    },
    onNothingSelected: () => {
      // ...todoSomething
    }
  }

  // 构造手势识别事件监听器
  private chartGestureListener: OnChartGestureListener = {
    onChartGestureStart: (isTouchEvent: boolean, me: TouchEvent | GestureEvent, lastPerformedGestureMode: ChartGesture) => {
    },
    onChartGestureEnd: (isTouchEvent: boolean, me: TouchEvent | GestureEvent, lastPerformedGestureMode: ChartGesture) => {
      // ...todoSomething
    },
    onChartLongPressed: (isTouchEvent: boolean, me: TouchEvent | GestureEvent) => {
      // ...todoSomething
    },
    onChartDoubleTapped: (isTouchEvent: boolean, me: TouchEvent | GestureEvent) => {
      // ...todoSomething
    },
    onChartSingleTapped: (isTouchEvent: boolean, me: TouchEvent | GestureEvent) => {
      // ...todoSomething
    },
    onChartFling: (isTouchEvent: boolean, me1: TouchEvent | GestureEvent, me2: TouchEvent, velocityX: number, velocityY: number) => {
      // ...todoSomething
    },
    onChartScale: (isTouchEvent: boolean, me: TouchEvent | GestureEvent, scaleX: number, scaleY: number) => {
      // ...todoSomething
    },
    onChartTranslate: (isTouchEvent: boolean, me: TouchEvent | GestureEvent, dX: number, dY: number) => {
      // ...todoSomething
    }
  }

  // 图表数据初始化
  aboutToAppear() {

    // Step1:必须：初始化图表配置构建类
    this.model = new BarChartModel();

    // Step2:配置图表指定样式，各部件间没有先后之分

    // 为图表添加数据选择的监听器
    this.model.setOnChartValueSelectedListener(this.valueSelectedListener);
    // 为图表添加手势识别监听器
    this.model.setOnChartGestureListener(this.chartGestureListener);
    // 获取图表描述部件，设置图表描述部件不可用，即图表不进行绘制描述部件
    let description: Description | null = this.model.getDescription()
    if (description) {
      description.setEnabled(false);
    }
    // 获取图表图例部件，设置图表图例部件不可用
    let l: Legend | null = this.model.getLegend();
    if (l) {
      l.setEnabled(false);
    }
    // 设置图表数据最大的绘制数，如果超过该数值，则不进行绘制图表的数值标签
    this.model.setMaxVisibleValueCount(40);
    // 是否绘制图表的背景色，绘制范围为图表柱状图的绘制范围，不包含轴线之外的部分
    this.model.setDrawGridBackground(false);
    // 设置图表的背景色，颜色的规格需要满足CanvasRenderingContext2D.fillstyle/strokestyle规格
    this.model.setGridBackgroundColor('#500000ff')
    // 设置不绘制柱状图的柱体阴影背景
    this.model.setDrawBarShadow(false);
    // 设置柱状图的数值在柱体上方
    this.model.setDrawValueAboveBar(false);
    // 设置柱状图的高亮范围是否为整个柱体，只在堆叠柱状图中有区别
    this.model.setHighlightFullBarEnabled(false);
    // 为左Y轴设置LimitLine,可设置限制线的宽度，线段样式，限制标签的位置，标签字体大小等
    this.limitLine1 = new LimitLine(120, 'Upper Limit');
    this.limitLine1.setLineWidth(4);
    this.limitLine1.enableDashedLine(10, 10, 0);
    this.limitLine1.setLabelPosition(LimitLabelPosition.RIGHT_TOP);
    this.limitLine1.setTextSize(10);

    this.limitLine2 = new LimitLine(50, 'Lower Limit');
    this.limitLine2.setLineWidth(4);
    this.limitLine2.enableDashedLine(10, 10, 0);
    this.limitLine2.setLineColor(Color.Yellow);
    this.limitLine2.setLabelPosition(LimitLabelPosition.RIGHT_BOTTOM);
    this.limitLine2.setTextSize(10);

    // 设置图表左Y轴信息
    this.leftAxis = this.model.getAxisLeft();
    if (this.leftAxis) {
      this.leftAxis.setAxisMinimum(0); // this replaces setStartAtZero(true)
      this.leftAxis.setDrawLimitLinesBehindData(false);

      // 添加LimitLines
      this.leftAxis.addLimitLine(this.limitLine1);
      this.leftAxis.addLimitLine(this.limitLine2);
    }
    // 设置图表右Y轴信息
    this.rightAxis = this.model.getAxisRight();
    if (this.rightAxis) {
      this.rightAxis.setEnabled(false);
      this.rightAxis.setAxisMinimum(0);
    }
    // 设置X轴信息
    this.xAxis = this.model.getXAxis();
    if (this.xAxis) {
      this.xAxis.setPosition(XAxisPosition.BOTTOM);
    }

    // 为图表设置markerView
    this.normalMarker = new MarkerView();
    this.model.setMarker(this.normalMarker);
    // 也可设置定义图表MarkerView
    // this.stackMarker = new CustomMarkerView();
    // 生成单一颜色数据
    this.data = this.getNormalData();
    // 将数据与图表配置类绑定
    this.model.setData(this.data);
    // 设置图表最大的X轴显示范围，如不设置，则默认显示全部数据
    this.model.setVisibleXRangeMaximum(20);
  }

  private getNormalData(): BarData {
    let values: JArrayList<BarEntry> = new JArrayList<BarEntry>();
    values.add(new BarEntry(1, 23.3));
    values.add(new BarEntry(2, 15.4));
    values.add(new BarEntry(3, 13.4));
    values.add(new BarEntry(4, 26.4));
    values.add(new BarEntry(5, 9.4));
    values.add(new BarEntry(6, 10));
    let dataSet: BarDataSet = new BarDataSet(values, 'DataSet');
    dataSet.setHighLightColor(Color.Black);
    dataSet.setDrawIcons(false);
    // 为柱体添加颜色信息
    dataSet.setColorByColor(Color.Green);

    let dataSetList: JArrayList<IBarDataSet> = new JArrayList<IBarDataSet>();
    dataSetList.add(dataSet);

    let barData: BarData = new BarData(dataSetList);
    //设置柱状图宽度
    barData.setBarWidth(0.85);
    //设置顶部圆角半径
    barData.setTopRadius(5);
    return barData;
  }


  build() {
    Column(){
      BarChart({
        model: this.model  // 要渲染的模型数据
      })
        .width('100%')
        .height('30%')
    }.width('100%')
    .height('100%')
  }
}