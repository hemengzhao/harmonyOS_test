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
