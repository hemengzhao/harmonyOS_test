
import  {mediaquery} from '@kit.ArkUI'


export function add(a: number, b: number): number {
  return a + b;
}

export class BreakPointSystem{
  private currentBreakPoint: string = BreakPointConstants.RANGE_SM

  // (1) 屏幕大小条件查询
  private smListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_SM)
  private mdListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_MD)
  private lgListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_LG)
  private xlListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_XL)

  // 定义保存单位的公共函数
  // sm, md, lg, xl   应用状态
  private updateCurrentBreakPoint(breakPoint: string){
    if(this.currentBreakPoint !== breakPoint){
      this.currentBreakPoint = breakPoint
      AppStorage.setOrCreate<string>(BreakPointConstants.CURRENT_BREAK_POINT, this.currentBreakPoint)
    }
  }

  // (2) 给监听器绑定change事件
  private isBreakPointSm = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将sm单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.RANGE_SM)
    }
  }

  private isBreakPointMd = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将md单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.RANGE_MD)
    }
  }

  private isBreakPointLg = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将lg单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.RANGE_LG)
    }
  }

  private isBreakPointXl = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将xl单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.RANGE_XL)
    }
  }
  public register (){
    this.smListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_SM)
    this.smListener.on('change', this.isBreakPointSm)

    this.mdListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_MD)
    this.mdListener.on('change', this.isBreakPointMd)

    this.lgListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_LG)
    this.lgListener.on('change', this.isBreakPointLg)

    this.xlListener =mediaquery.matchMediaSync(BreakPointConstants.RANGE_XL)
    this.xlListener.on('change', this.isBreakPointXl)

  }

  public unregister(){
    this.smListener.off('change', this.isBreakPointSm)
    this.mdListener.off('change', this.isBreakPointMd)
    this.lgListener.off('change', this.isBreakPointLg)
    this.xlListener.off('change', this.isBreakPointXl)
  }

}

export class BreakPointConstants{
  /**
   * 这个单位标识手机以下的
   * */
  static readonly BREAKPOINT_XS: string = 'xs'
  /**
   * 这个单位标识折叠屏
   * */
  static readonly BREAKPOINT_SM: string = 'sm'
  /**
   * 这个单位标识平板
   * */
  static readonly BREAKPOINT_MD: string = 'md'
  /**
   * 这个单位标识更大的屏幕
   * */
  static readonly BREAKPOINT_LG: string = 'lg'

  static readonly BREAKPOINT_XL: string = 'xl'

  /**
   * 这个断点数据
   * */
  static readonly BREAKPOINT_VALUE: Array<string> = ['320vp', '600vp', '840vp', '1200vp']
  /**
   * 关于列的数量
   * */
  static readonly COLUMN_SM: number = 4
  static readonly COLUMN_MD: number = 8
  static readonly COLUMN_LG: number = 12

  static readonly GUTTER_X: number = 12

  static readonly SPAN_SM: number = 4
  static readonly SPAN_MD: number = 6
  static readonly SPAN_LG: number = 8

  static readonly OFFSET_MD: number = 1
  static readonly OFFSET_LG: number = 2

  static readonly CURRENT_BREAK_POINT: string = 'currentBreakPoint'

  static readonly FONT_SIZE_SM: number = 12
  static readonly FONT_SIZE_MD: number = 16
  static readonly FONT_SIZE_LG: number = 18

  static readonly COVER_MARGIN_SN: number = 10
  static readonly COVER_MARGIN_MD: number = 30
  static readonly COVER_MARGIN_LG: number = 40

  static readonly RANGE_SM: string = '(320vp<=width<600vp)'
  static readonly RANGE_MD: string = '(600vp<=width<840vp)'
  static readonly RANGE_LG: string = '(840vp<=width<1200vp)'
  static readonly RANGE_XL: string = '(1200vp<=width)'
}

@Component
export  struct  EmptyView {
  private defaultHeight: string = '100%'
  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center
    }){
      Image('https://hbimg.huabanimg.com/64040f275307f37d8fa0491f115f80cdab911bc14c77-FBQjRV_fw658')
        .width(100)
      Text('页面空空如也')
        .fontColor(Color.Gray)
    }.width('100%')
    .height(this.defaultHeight)
  }
}
