import requests
from bs4 import BeautifulSoup
from tqdm import tqdm
import pandas as pd
import csv


def crawl(link):
  
    # dict_crawl_data = {}
    item = []
    origiitem = []
    manuitem = []
    imgitem = []
    # itemtype =[]
    
    ind = range(len(link))
    # num = 0
    for i in tqdm(ind):
      
      response = requests.get(link[i], headers={'User-Agent' : 'Mozilla/5.0'})
      response.encoding = 'utf-8'
      print('확인 = ' + response.url)
      
      if 'adult_im' in response.text :
          print('성인제품 넘어가기')
          continue
      else :
          if response.status_code == 200:
              soup = BeautifulSoup(response.text, 'html.parser')
              
              # 제품 번호
              pdNo = soup.find('img', class_='likePrdIcon')
              #썸네일 이미지
              thumbImg = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.xans-element-.xans-product.xans-product-image.imgArea > div.keyImg.item > div.thumbnail > a > img')
              #토탈 제목
              totalName = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > h2').text
              # 가격
              pdPrice = soup.select_one('#span_product_price_text')
              # 원작명
              pdOriginal = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > div.xans-element-.xans-product.xans-product-detaildesign > table > tbody > tr:nth-child(6) > td > span')
              # 제조사
              pdManu = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > div.xans-element-.xans-product.xans-product-detaildesign > table > tbody > tr:nth-child(7) > td > span')
              # 코드
              pdCode = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > div.xans-element-.xans-product.xans-product-detaildesign > table > tbody > tr:nth-child(8) > td > span')
              # 재질
              pdMaterial = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > div.xans-element-.xans-product.xans-product-detaildesign > table > tbody > tr:nth-child(9) > td > span')
              # 크기
              pdSize = soup.select_one('#contents_product > div.xans-element-.xans-product.xans-product-detail > div.detailArea > div.infoArea > div.info > div.xans-element-.xans-product.xans-product-detaildesign > table > tbody > tr:nth-child(10) > td > span')
              
              # 메인 사진
              pdDetailImgs = soup.find('div', {'class' : 'cont'}).find_all('img',{'data-result' :"success"})
              
              pdDeImg = []
              for t in pdDetailImgs:
                pdDeImg.append('https://figurepresso.com'+ t.attrs['ec-data-src'])
              
              
              # 제목 편집
              totalName = totalName.replace('[','')
              totalName = totalName.split(']')
              pdName = totalName[len(totalName)-1].strip()
              
              saleDue = ""
              saleStatus = totalName[0]
              if('/' in saleStatus):
                saleDue = saleStatus.split('/')[1]
                if('~' in saleDue):
                    saleDue = saleDue.split('~')[0]
                if('입고예정' in saleDue):
                    saleDue = saleDue.replace('입고예정','').strip()
              print('--------------------')
              print(saleDue)
              # print(totalName[0])
              # print(totalName)
              
              
              deitem =[]
              deorigi = []
              demanu = []
              # detype =[]
              
              
              if pdMaterial is not None and pdNo.attrs['product_no'] is not None and thumbImg is not None and '(' not in pdName:
                if 'PVC' in pdMaterial.text  :  
                  deitem.append(pdNo.attrs['product_no'])   #product_no
                  deitem.append(pdName)     #pruduct_name
                  deitem.append(pdOriginal.text)
                  deitem.append(pdManu.text)
                  #deitem.append(pdCode.text+'_') #manufacturer_code
                  deitem.append('10') #product_class
                  deitem.append(saleDue) #class_month
                  deitem.append(pdPrice.text.split('원')[0].replace(',','')) #sales_cost
                  deitem.append(int(int(pdPrice.text.split('원')[0].replace(',',''))*0.7)) #purchase_cost
                  deitem.append("https:" + thumbImg.attrs['src']) #thumbnail_img
                  deitem.append(pdMaterial.text) #materials
                  deitem.append(pdSize.text) #size
                  
                  deorigi.append(pdOriginal.text) 
                  demanu.append(pdManu.text)
                  
                  for g in range(len(pdDeImg)) :
                    deimg = []
                    deimg.append(pdNo.attrs['product_no'])
                    deimg.append(pdDeImg[g])
                    imgitem.append(deimg)
                      
                  item.append(deitem)
                  origiitem.append(deorigi)
                  manuitem.append(demanu)
              
                  
              
          # 큰 크롤데이터에 아이템 추가
    
    with open('D:/lecture/python/my/pdtable.csv', 'a', newline='',encoding='cp949') as w :
        wr = csv.writer(w)
        for i in range(len(item)) :
          wr.writerow(item[i])
    with open('D:/lecture/python/my/pdorigi.csv', 'a', newline='',encoding='cp949') as f :
        fr = csv.writer(f)
        for q in range(len(origiitem)) :
          fr.writerow(origiitem[q])
    with open('D:/lecture/python/my/pdmanu.csv', 'a', newline='',encoding='cp949') as m :
        mr = csv.writer(m)
        for n in range(len(manuitem)) :
          mr.writerow(manuitem[n])
    with open('D:/lecture/python/my/pdimg.csv', 'a', newline='',encoding='cp949') as z : 
        zr = csv.writer(z)
        for b in range(len(imgitem)) :
          zr.writerow(imgitem[b])
    
    # print(item)
# crawl(['https://figurepresso.com/product/%EC%9E%85%EA%B3%A0%EC%99%84%EB%A3%8C%EB%B0%98%ED%94%84%EB%A0%88%EC%8A%A4%ED%86%A0%EB%94%94%EC%A7%80%EB%AA%AC-%EC%96%B4%EB%93%9C%EB%B2%A4%EC%B3%90-dxf-%EC%96%B4%EB%93%9C%EB%B2%A4%EC%B2%98-%EC%95%84%EC%B9%B4%EC%9D%B4%EB%B8%8C-%EC%8A%A4%ED%8E%98%EC%85%9C-%ED%8C%8C%ED%94%BC%EB%AA%AC/46852/category/1669/display/1/'])
