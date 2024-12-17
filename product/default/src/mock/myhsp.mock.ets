
import  {mediaquery} from '@kit.ArkUI'
import { http } from "@kit.NetworkKit";

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

export class BasicConstants {
  static readonly Full_WIDTH= '100%'
  static readonly Full_HEIGTH= '100%'
  static readonly FONT_SIZE_SMALL= '14vp'
  static readonly FONT_SIZE_NORMAL= '16vp'
  static readonly FONT_SIZE_BIG= '20vp'
  static readonly  BASE_URL = 'http://10.21.90.52:3000'
}
export function myRequest<T, K>(
  url: string,
  method: http.RequestMethod,
  requestData?: K
){
  const httpRequest = http.createHttp()
  return new Promise((resolve:(value: RequestData<T>) => void,
    reject: (value?: string)=> void
  )=> {
    httpRequest.request(BasicConstants.BASE_URL + url, {
      method: method,
      header: {
        'content-type': "application/json"
      },
      extraData: JSON.stringify(requestData) || '',
      connectTimeout: 6000,
      readTimeout: 6000
    }, (err: Error, data: http.HttpResponse) => {
      if(!err){
        resolve(JSON.parse(data.result as string))
      } else {
        reject(err.message)
      }
    })
  })

}


interface RequestData<T> {
  status: boolean;
  message: string;
  data: T;
}
export function myRequestGet<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.GET, requestData)
}

export function myRequestPost<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.POST, requestData)
}

export function myRequestPut<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.PUT, requestData)
}

export function myRequestDelete<T, K>(url: string, requestData?: K): Promise<RequestData<T>>{
  return myRequest(url, http.RequestMethod.DELETE, requestData)
}


export  class BasicDataSource<T> implements IDataSource {
  // 存放数据监听器
  private listeners: DataChangeListener[] = [];

  // 这个数据就是用于存放我们的循环数据
  private originDataArray: T[] = [];

  // 计算一共有多少数据
  public totalCount(): number {
    return 0;
  }

  // 获取数据
  public getData(index: number): T {
    return this.originDataArray[index];
  }

  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  // originDataArray里面的数据都会被监听
  // LazyForEach 调用
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      console.info('add listener');
      this.listeners.push(listener);
    }
  }

  // 该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      console.info('remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.ADD, index: index}]);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.CHANGE, index: index}]);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
      // 写法2：listener.onDatasetChange([{type: DataOperationType.DELETE, index: index}]);
    })
  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
      // 写法2：listener.onDatasetChange(
      //         [{type: DataOperationType.EXCHANGE, index: {start: from, end: to}}]);
    })
  }

  notifyDatasetChange(operations: DataOperation[]): void {
    this.listeners.forEach(listener => {
      listener.onDatasetChange(operations);
    })
  }
}


export class MyDataSource<T> extends BasicDataSource<T> {
  private dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): T {
    return this.dataArray[index];
  }

  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  public pushAllData(data: T[]): void{
    for (let index = 0; index < data.length; index++) {
      this.pushData(data[index])
    }
  }
}
export class CartModel {
  id?:number
  goods_name?:string
  goods_big_logo?: string
  goods_code?:string
  goods_price?:number
  goods_count?: number
  goods_checked?: number
}