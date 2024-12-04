import {BreakPointConstants} from '../constants/BreadkPointConstants'
import  {mediaquery} from '@kit.ArkUI'

export class BreakPointSystem{
  private currentBreakPoint: string = BreakPointConstants.BREAKPOINT_XS

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
      this.updateCurrentBreakPoint(BreakPointConstants.BREAKPOINT_SM)
    }
  }

  private isBreakPointMd = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将md单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.BREAKPOINT_MD)
    }
  }

  private isBreakPointLg = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将lg单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.BREAKPOINT_LG)
    }
  }

  private isBreakPointXl = (mediaqueryResult: mediaquery.MediaQueryResult) => {
    if(mediaqueryResult.matches){
      //   将xl单位保存起来
      this.updateCurrentBreakPoint(BreakPointConstants.BREAKPOINT_XL)
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

  constructor() {

  }
}