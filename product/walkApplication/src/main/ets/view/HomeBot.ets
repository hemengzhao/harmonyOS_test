import { IHomeCartItem } from "../viewModel/homeModel"
import { router } from "@kit.ArkUI"
import { callPhone } from "@ohos/common"

let RelConB: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {
  'top': { 'anchor': 'row1', 'align': VerticalAlign.Bottom },
  'left': { 'anchor': 'row1', 'align': HorizontalAlign.Start }
}

@Component
export struct HomeBotBox {
  @State catrList: IHomeCartItem[] = [{
    id: 1,
    imgUrl: '1',
    name: '专车'
  },{id: 2,
    imgUrl: '2',
    name: '租车'
  },{id: 3,
    imgUrl: '3',
    name: '顺风车'
  },{id: 4,
    imgUrl: '4',
    name: '代驾'
  }]

  @Builder Box(color: ResourceColor){
    Column()
      .width(12)
      .height(12)
      .backgroundColor(color)
      .shadow({ radius: 20, color: color, offsetX: 0, offsetY: 0})
      .borderRadius('50%')
  }

  onCartClick = (item: IHomeCartItem) => {
    if(item.id === 1){
      router.pushUrl({
        url: 'pages/TakeTaxiPage'
      })
    } else if (item.id === 2){

    }
  }
  @Builder CartBox(){
    Row(){
      ForEach(this.catrList, (item: IHomeCartItem) => {
        Column(){
          Image($r(`app.media.home_cart${item.imgUrl}`)).width(36)
          Text(item.name).fontSize(16)

        }.onClick(() => this.onCartClick(item))
      }, (item: IHomeCartItem) => item.imgUrl)

    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
    .padding({top: 70, bottom: 20, left: 10, right: 10})
    .borderRadius(30)
    .backgroundColor('#ECECEC')
    .margin({
      top: -50
    })
    .zIndex(-1)
    .alignRules({
      'top': { 'anchor': 'row2', 'align': VerticalAlign.Bottom },
    })
  }
  build() {
    Column(){
       RelativeContainer(){
         Column(){

         }
         .height(80)
         .width(200)
         .borderRadius({
           topLeft: 30
         })
         .backgroundColor('#99DC64')
         .id("row1")

         Row(){
           Column(){
             this.Box('#FF6B00')
             Text('........')
               .lineHeight(6)
               .width(4)
             this.Box('#99DC64')
           }
           Column(){
             Column(){

               TextInput({
                 placeholder: '当前位置',
               })
                 .width('100%')
                 .textAlign(TextAlign.Start)
                 .backgroundColor(Color.Transparent)
                 .placeholderColor('#FF6B00')
                 .placeholderFont({
                   size: 20,
                 })
                 .fontColor('#FF6B00')
                 .fontSize(18)
                 .focusable(false)
                 .onClick(() => {
                   router.pushUrl({
                     url: 'pages/SeachPage', params: {
                     type: 'go'
                   }})
                 })
             }
             Divider().vertical(false).height(20).color('#182431').opacity(0.6).margin({ left: 8, right: 8 })
             Column(){
               TextInput({
                 placeholder: '请输入目的地',
               }).backgroundColor(Color.Transparent)
                 .caretColor('#99DC64')
                 .fontColor('#99DC64')
                 .placeholderColor('#333333')
                 .focusable(false)
                 .placeholderFont({
                   size: 20,
                   weight: FontWeight.Bold
                 }).fontSize(20).onClick(() => {
                 router.pushUrl({
                   url: 'pages/SeachPage', params: {
                     type: 'to'
                   }})
               })
             }
           }.padding({left: 20, right: 20})
         }.id("row2")
         .borderRadius(30)
         .backgroundColor(Color.White)
         .padding(15)
         .alignRules(RelConB)
         .margin({top: -40})

         this.CartBox()
        }.width('100%')
      .height('100%')
    }
    .padding(20)
    .height('100%')

  }
}