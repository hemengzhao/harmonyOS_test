import { MyDataSource, preferencesUtil, kvStore } from '@ohos/common';
@Component
export struct Product{
  build() {
    Column(){
      Text('产品页面')
      Button('设置主主题 blue').onClick(() => {
        preferencesUtil.insert('theme', 'blue')
      })

      Button('获取主题 ').onClick(() => {
        preferencesUtil.readData('theme')
      })


      Button('存储kvStore ').onClick(() => {
        kvStore.insert('cart', '我是一个catr')
        kvStore.insert('userName', '小红')
        kvStore.insert('classes', JSON.stringify({ID: 1, NAME: 'XIAOLIU'}))
      })

      Button('获取kvStore ').onClick(() => {
        kvStore.getData('cart').then(res => {
          console.log(`cart   ===> ${res}`)
        })
        kvStore.getData('userName').then(res => {
          console.log(`userName  ===>  ${res}`)
        })
        kvStore.getData('classes').then(res => {
          console.log(`classes   ===> ${res}`)
        })
      })
    }
  }
}