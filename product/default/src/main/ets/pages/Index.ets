
import  {BreakPointSystem} from "@ohos/common"
import {MainPage} from 'homelibrary'

import  {Cart} from '../view/Cart'
import  {Personal} from '../view/Personal'
import  {Product} from '../view/Product'
import { BasicConstants } from '../Constants/BasicConstants';

@Entry
@Component
struct Index {
  @StorageProp('currentBreakPoint') currentBreakPoint: string = 'sm'
  private  breakPointSystem: BreakPointSystem = new BreakPointSystem()

  @State message: string = 'Hello World 123';
  @State currentIndex: number = 0

  private controller: TabsController = new TabsController()

  aboutToAppear(): void {
    this.breakPointSystem.register()
  }
  @Builder MyTabBar(
    title: string,
    targetIndex: number,
    normalImg: Resource,
    selectImg: Resource,
    ){
      Column({
        space: 3
      }){
        Image(targetIndex === this.currentIndex ? selectImg : normalImg).size({
          width: 32,
          height: 32
        })
        Text(title).fontColor(targetIndex === this.currentIndex ? '#e92f4f' : 'black')
      }
      .width(BasicConstants.Full_WIDTH)
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.controller.changeIndex(targetIndex)
    })
  }
  build() {
    Column() {


      Tabs({
        barPosition:this.currentBreakPoint === 'lg' ? BarPosition.Start : BarPosition.End,
        index: this.currentIndex,
        controller: this.controller
      }){
        TabContent(){
          MainPage()
        }.tabBar(this.MyTabBar('首页', 0, $r('app.media.tabbar_home'), $r('app.media.tabbar_home_active')))

        TabContent(){
            Product()
        }.tabBar(this.MyTabBar('产品', 1, $r('app.media.tabbar_can'), $r('app.media.tabbar_can_active')))

        TabContent(){
          Cart()
        }.tabBar(this.MyTabBar('购物车', 2, $r('app.media.tabbar_car'), $r('app.media.tabbar_car_active')))

        TabContent(){
          Personal()
        }.tabBar(this.MyTabBar('我的', 3, $r('app.media.tabbar_my'), $r('app.media.tabbar_my_active')))
      }
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .vertical(this.currentBreakPoint === 'lg')
      // .barWidth(100)
      .barHeight(this.currentBreakPoint === 'lg' ? 400 : 60)
      // .barBackgroundColor('')

    }
    .height(BasicConstants.Full_WIDTH)
    .width(BasicConstants.Full_HEIGTH)

  }
}