import { MyDataSource, preferencesUtil } from '@ohos/common';
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
    }
  }
}