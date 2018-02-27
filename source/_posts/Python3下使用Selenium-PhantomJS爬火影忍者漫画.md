---
title: Python3下使用Selenium&PhantomJS爬火影忍者漫画
date: 2018-02-27 14:16:38
tags:
  - Spider
  - Selenium
  - PhantomJS
categories:
  - Spider
  - Selenium

---

近期学习爬虫，发现懂的越多，不懂的知识点越多（所以当个傻子还是很幸福的）。好记性不如烂笔头，之前都是把看到的资料链接直接挂到一些平台，比如知乎、简书、Github等。今天有点时间，就好好码一下字，排排版，方便以后查阅。

Selenium用来模拟浏览器的行为，比如点击、最大化、滚动窗口等；PhantomJS是一种浏览器，不过这种浏览器没有UI界面，感觉就像是专门为爬虫设计，优点很明显，可以有效减小内存的使用。

<!--more-->

## 爬虫使用到的模块
```Python
from selenium import webdriver
from myLogging import MyLogging
import os
import time
import re
```

myLogging模块是自己配置的日志包，想要的可以点击**_[这里](http://link.zhihu.com/?target=https%3A//github.com/ByiProX/DownloadPicsBySeleniumAndPhantomJS)_**自己看

爬虫很关键的一点就是能够看懂网页的源代码，记得当初刚刚真正开始接触编程的时候，有很长的一段时间在看HTML、CSS、JS的一些知识，虽然忘得很多，但是印象还是有的，对于后面看网页源代码很有帮助。学习爬虫，除了会基本的python知识以外，还要会网页的一些知识。

## 爬取图片思路：

  * 已知连接，分析网页的代码结构，看所需的数据是否需要切换frame，并定位所需数据的位于哪个标签之下
  * 采用不同的模块有不同的保存图片方式，如果采用request模块，保存图片方式是可以采用**requests.get(comicUrl).content**方法，使用该方法需要确定网页的地址。该项目中没有涉及request的使用，所以此后不再表述。对于selenium可以使用 **get_screenshot_as_file()** 方法，使用该方法强烈建议使用phantomjs，如果使用chrome浏览器，图片尺寸太大的话，会出现截图不完整，对比如下：
  ![对比](http://upload-images.jianshu.io/upload_images/2952111-2323c462a546dcc3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  * 找到下一张图片的连接位置并点击更新网页，一般来讲新网页与之前网页结构相同。
  * 在新网页的基础上保存图片，设置循环如此反复。

爬取网页的URL为：[爬取火影漫画第一话](http://link.zhihu.com/?target=http%3A//comic.kukudm.com/comiclist/3/3/1.htm)

## 代码

```Python
class DownloadPics(object):

    def __init__(self, url):
        self.url = url
        self.log = MyLogging()
        self.browser = self.get_browser()
        self.save_pics(self.browser)

    def get_browser(self):
        browser = webdriver.PhantomJS()
        try:
            browser.get(self.url)
        except:
            MyLogging.error('open the url %s failed' % self.url)
        browser.implicitly_wait(20)
        return browser

    def save_pics(self, browser):
        pics_title = browser.title.split('_')[0]
        self.create_dir(pics_title)
        os.chdir(pics_title)
        sum_page = self.find_total_page_num(browser)
        i = 1
        while i < sum_page:
            image_name = str(i) + '.png'
            browser.get_screenshot_as_file(image_name)  
            # 使用PhantomJS避免了截图的不完整，可以与Chrome比较
            self.log.info('saving image %s' % image_name)
            i += 1
            css_selector = "a[href='/comiclist/3/3/%s.htm']" % i  
            # 该方法感觉还不错呢，不过这个网站确实挺差劲的
            next_page = browser.find_element_by_css_selector(css_selector)
            next_page.click()
            time.sleep(2)
            # browser.implicitly_wait(20)

    def find_total_page_num(self, browser):
        page_element = browser.find_element_by_css_selector("table[cellspacing='1']")
        num = re.search(r'共\d+页', page_element.text).group()[1:-1]  
        return int(num)

    def create_dir(self, dir_name):
        if os.path.exists(dir_name):
            self.log.error('create directory %s failed cause a same directory exists' % dir_name)
        else:
            try:
                os.makedirs(dir_name)
            except:
                self.log.error('create directory %s failed' % dir_name)
            else:
                self.log.info('create directory %s success' % dir_name)

if __name__ == '__main__':
    start_url = 'http://comic.kukudm.com/comiclist/3/3/1.htm'
    DL = DownloadPics(start_url)
```

## 运行结果


![gif](http://upload-images.jianshu.io/upload_images/2952111-e7e2cf39116b5fea.gif?imageMogr2/auto-orient/strip)
