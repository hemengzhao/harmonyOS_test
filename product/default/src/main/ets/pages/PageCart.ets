import  {Cart} from '../view/Cart'
@Entry
@Component
struct PageCart {
  @State message: string = 'Hello World';
  build() {
     Column(){
       Cart()
     }.height('100%')
    .width('100%')
  }
}