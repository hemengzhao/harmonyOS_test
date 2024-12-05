import {myRequestGet} from '@ohos/common'

export function findSwiperDataApi<T, K>(){
  return myRequestGet<T, K>('/home/swiperdata')
}

export function findCatitemsDataApi<T, K>(){
  return myRequestGet<T, K>('/home/catitems')
}

export function findProductDataApi<T, K>(){
  return myRequestGet<T, K>('/goods/search')
}

export function findProductDataByIdApi<T, K>(params: K){
  return myRequestGet<T, K>('/goods/searchById', params)
}