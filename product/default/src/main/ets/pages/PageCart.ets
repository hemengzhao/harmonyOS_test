import { cartDBUtils, CartModel } from '@ohos/common';

@Entry
@Component
struct PageCart {
  @State myId: number = 0;
  @State count: number = 1;
  @State carts: CartModel[] = []
  findDataDB = async () => {
    const res =  await cartDBUtils.queryDataDB(['ID', 'GOODS_NAME', 'GOODS_COUNT', 'GOODS_BIG_LOGO', 'GOODS_CODE', 'GOODS_PRICE', 'GOODS_CHECKED'], 'MYCART')
    console.log(`findDataDB ====> 数据库查询结果： ${JSON.stringify(res)}`)
    this.carts = res
  }
  aboutToAppear(): void {
    this.findDataDB()
  }
  build() {
     Column(){
       TextInput({
        placeholder: '修改商品编号',
         text: $$this.myId
       })

       Button(){
         Text('删除')
       }.onClick(() => {
         cartDBUtils.deleteById('MYCART', this.myId)
       })

       TextInput({
         placeholder: '修改商品数量',
         text: $$this.count
       })

       Button(){
         Text('修改')
       }.onClick(() => {
         cartDBUtils.updateById('MYCART', this.myId, {
           'GOODS_COUNT': this.count,
         })
       })

       List(){
         ForEach(this.carts, (item: CartModel) => {
           ListItem(){
             Column(){
               Text(`ID: ${item.id}`)
               Text(`goods_name: ${item.goods_name}`)
               Text(`goods_count: ${item.goods_count}`)
             }
           }.width('100%')
           .height(120)
           .borderRadius(20)
           .backgroundColor(Color.White)
         }, (item: CartModel) => item.id?.toString())

       }
     }
     .backgroundColor(Color.Grey)
    .height('100%')
  }
}