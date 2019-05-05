#!/usr/bin/env python
# coding: utf-8

# In[1]:


import app
import sys
import json
import urllib
import requests
from bs4 import BeautifulSoup
from selenium.webdriver.chrome.options import Options
from selenium import webdriver

# get_ipython().system(' pip install selenium')


# In[40]:


# import BeautifulSoup4
# import urllib2


# In[35]:


base_url = "https://ithaca.craigslist.org/search/apa"
house_list = []  # list of dicts
new_house_list = []
num_pages = 16


# In[37]:


# get num_pages

page = urllib.request.urlopen(base_url)
soup = BeautifulSoup(page, "html.parser")
num_tag = soup.find("span", attrs={"class": "totalcount"})
if num_tag is not None:
    num_houses = int(num_tag.text)
    num_pages = num_houses / 120

# print(num_pages)


# In[30]:


def add_all_houses(info):
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
                pass
        except:
            location = "Please click link for location information"

        try:
            # house info url
            url = i.find("a", attrs={"class": "result-image gallery"})["href"]
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
    global new_house_list
    page = urllib.request.urlopen(url)
    soup = BeautifulSoup(page, "html.parser")
    info = soup.find_all("li", attrs={"class": "result-row"})
    add_all_houses(info)


# In[32]:


def get_all_data():
    global house_list
    global new_house_list
    for i in range(int(num_pages)):
        try:
            get_from_url(base_url + ("" if i == 0 else ("?s=" + str(i * 120))))
            print("successfully parse page", i)
        except:
            continue

    print(len(house_list))


# In[34]:


def data_to_json():
    with open("house.json", "w") as outfile:
        json.dump(house_list, outfile)


# Methods for refreshing (only collect and add new data to db):

# In[ ]:


def add_new_houses():
    global new_house_list
    stop = False  # stop = True after finding a first existing house in db

    for pg in range(int(num_pages)):
        if stop:
            break

        url = base_url + ("" if pg == 0 else ("?s=" + str(pg * 120)))
        page = urllib.request.urlopen(url)
        soup = BeautifulSoup(page, "html.parser")
        info = soup.find_all("li", attrs={"class": "result-row"})

        for i in info:
            description = i.find(
                "a", attrs={"class": "result-title hdrlnk"}
            ).text  # description

            # check whether the house is already in db
            if app.exists(description):
                stop = True
                break

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
                location = i.find(
                    "span", attrs={"class": "result-hood"}
                ).text  # location
                try:
                    location = location.strip(" (").strip(")")
                except:
                    pass
            except:
                location = "Please click link for location information"

            try:
                # house info url
                url = i.find("a", attrs={"class": "result-image gallery"})["href"]
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
            new_house_list.append(house)


# In[41]:


add_new_houses()
app.add_houses(new_house_list)


# In[ ]:
