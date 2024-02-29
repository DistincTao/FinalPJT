from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from bscrawler import crawl

from multiprocessing import Pool # Pool import하기

# 신규 상품 (총 2 페이지) https://figurepresso.com/product/list.html?cate_no=1669&page=2
# 입고 상품 (총 132 페이지) https://figurepresso.com/product/list.html?cate_no=25&page=132
# 예약 상품 (총 13) https://figurepresso.com/product/list.html?cate_no=1805&page=13

# 신규 상품 (총 페이지:2)
def get_links(pageno) :
    #baseUrl = "https://figurepresso.com"
    options = webdriver.ChromeOptions()
    options.add_argument("headless")
    driver = webdriver.Chrome(options=options) 
    start_time = time.time()

    detail_urls = []
    try :  
        targetUrl = "https://figurepresso.com/product/list.html?cate_no=25&page=" + str(pageno)
        driver.get(targetUrl)
        driver.implicitly_wait(2)
    
        items = driver.find_elements(By.CLASS_NAME, 'likePrdIcon')
        
        for item in items :
            id = item.get_attribute("product_no")
            thums_a_xpath = '//*[@id="anchorBoxId_'+id+'"]/div[1]/a'
            url = driver.find_element(By.XPATH, thums_a_xpath).get_attribute("href")
            detail_urls.append(url)  
        print('디테일 페이지 개수 : ', len(detail_urls))
        
    except :
        print("크롤링 실패")
    else :
        crawl(detail_urls)


    print("-------{}초 걸렸슴-------".format(time.time()-start_time))
    driver.quit()
    
    

def page_list() :
    list = []
    for i in range(1,100): # 페이지 수
        list.append(i)
    return list

# get_links(1)

if __name__=='__main__':
    start_time = time.time()
    pool = Pool(processes=4) # 4개의 프로세스를 사용합니다.
    pool.map(get_links, page_list()) 
    print("최종 --- %s초 걸렷슴 ---" % (time.time() - start_time))