This folder contains codes for backend parts of the Ithaca Housing App.

The house data are crawled from website https://ithaca.craigslist.org/search/apa. 

src/web_scraper.py: the script for data crawling (converted from an ipynb file)
api.txt: the api
src/house.json & src/houses.db: the local data maintained 


The front end can either 
1) request to get data currently stored in local db (may only contain recently updated but not the latest data) in some sorting order, or 
2) request to refresh the data, which triggers a method in web_sraper.py to crawl the latest data only and store into db.

We have deployed it and made sure it worked. We acknowledge there may be a small issue with sorting by post date when updating the db with new data crawled and inserting them into the db. But we will fix that soon and on the whole the api works well.



