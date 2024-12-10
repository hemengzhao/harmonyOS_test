import {myRequestGet} from '@ohos/common'

export function findSwiperDataApi<T, K>(){
  console.log('findSwiperDataApi      =====>')
  return myRequestGet<T, K>('/harmony/home/swilper')
}

export function findCatitemsDataApi<T, K>(){
  return myRequestGet<T, K>('/harmony/activityType')
}

export function findProductDataApi<T, K>(){
  return myRequestGet<T, K>('/goods/search')
}

export function findProductDataByIdApi<T, K>(params: K){
  return myRequestGet<T, K>('/goods/searchById', params)
}