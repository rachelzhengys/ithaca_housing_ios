#!/usr/bin/env python
# coding: utf-8

# In[1]:


# get_ipython().system(' pip install selenium')


# In[2]:


# import BeautifulSoup4
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

# import urllib2
from bs4 import BeautifulSoup
import requests
import urllib
import json


# In[3]:


base_url = "https://ithaca.craigslist.org/search/apa"
house_list = []  # list of dicts


# In[30]:


def add_house_dicts(info):
    global house_list
    for i in info:
        description = i.find(
            "a", attrs={"class": "result-title hdrlnk"}
        ).text  # description
        postdate = i.find("time", attrs={"class": "result-date"}).text  # post date

        try:
            price = i.find("span", attrs={"class": "result-price"}).text  # price
            price = int(price[1:])
        except:
            price = -1

        try:
            house_type = i.find(
                "span", attrs={"class": "housing"}
            ).text  # type and size
            strs = house_type.split(" ")
            house_type = ""
            for s in strs:
                if len(s) > 0 and s[0].isdigit():
                    house_type = house_type + s + " "
        except:
            house_type = "Please click link for type and size information"

        try:
            location = i.find("span", attrs={"class": "result-hood"}).text  # location
            try:
                location = location.strip(" (").strip(")")
            except:
                location = location
        except:
            location = "Please click link for location information"

        try:
            url = i.find("a", attrs={"class": "result-image gallery"})[
                "href"
            ]  # house info url
        except:
            url = "Sorry, there's no link to the house info"

        try:
            house_page = urllib.request.urlopen(url)
            soup = BeautifulSoup(house_page, "html.parser")
            img_url = soup.find("img", attrs={"title": "1", "alt": "1"})[
                "src"
            ]  # image url
        except:
            img_url = "Please click link for house images"

        # construct house dict
        house = {}
        house["location"] = location
        house["price"] = price
        house["imageUrl"] = img_url
        house["description"] = description
        house["type"] = house_type
        house["postdate"] = postdate
        house["url"] = url

        house_list.append(house)


#         print(house)
#         print()


# In[31]:


def get_from_url(url):
    global house_list
    page = urllib.request.urlopen(url)
    soup = BeautifulSoup(page, "html.parser")
    info = soup.find_all("li", attrs={"class": "result-row"})
    add_house_dicts(info)


# In[32]:


def get_all_houses():
    global house_list

    for i in range(1):
        try:
            get_from_url(base_url + ("" if i == 0 else ("?s=" + str(i * 120))))
            print("successfully parse page", i)
        except:
            continue

    print(len(house_list))


# In[33]:


get_all_houses()
print("done")


# In[20]:


with open("house.json", "w") as outfile:
    json.dump(house_list, outfile)


# In[ ]:


# # use selenium to get dynamic html context
# options = Options()
# options.add_argument('--headless')
# options.add_argument('--disable-gpu')
# # driver = webdriver.Chrome(chrome_options=options)
# driver = webdriver.Chrome(executable_path='/Users/maoyue/Desktop/ithaca_housing_ios/Ithaca\ Housing\ Backend/src/chromedriver')
# driver.get(url)
# time.sleep(3)
# page = driver.page_source
# driver.quit()
# soup = BeautifulSoup(page, 'html.parser')


# In[ ]:

