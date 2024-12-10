import { MyDataSource } from '@ohos/common';

interface MyObj {
  name: string
  id: number
}
@Entry
@Component
struct MyComponent {
  private data: MyDataSource<MyObj> = new MyDataSource();

  aboutToAppear() {
    for (let i = 0; i <= 100; i++) {
      this.data.pushData({
        name: '那么name'+i,
        id: i+1
      })
    }
  }

  build() {
    List({ space: 3 }) {
      LazyForEach(this.data, (item: MyObj) => {
        ListItem() {
          Row() {
            Text(item.name ).fontSize(50)
              .onAppear(() => {
                console.info("appear:" + item.name)
              })
          }.margin({ left: 10, right: 10 })
        }
      }, (item: MyObj) => item.id.toString())
    }.cachedCount(5)
  }
}