import json
import re

from bs4 import BeautifulSoup
from selenium import webdriver

# binary = FirefoxBinary('C:\\Program Files\\Mozilla Firefox\\firefox.exe')  # local firefox installation
driver = webdriver.Firefox()


# driver.get('http://www.google.com/')

def list_to_string(s):
    # initialize an empty string
    str1 = ""
    return str1.join(s)


meta_score_block = []  # store metascore block
user_score_block = []  # store user score block

summary = []  # store plot summary
stuff = []

url = "https://www.metacritic.com/movie/the-emoji-movie"

# url = "https://www.metacritic.com/movie/the-invisible-man"
driver.get(url)

page_content = driver.page_source

soup = BeautifulSoup(page_content, "html.parser")

title = soup.title.string
clean_title = title.split('Reviews')
#  print(clean_title[0])

for a in soup.find_all('span', attrs={'class': 'metascore_w header_size movie positive'}):
    meta_score_block.append(a.string)
if len(meta_score_block) == 0:
    for a in soup.find_all('span', attrs={'class': 'metascore_w header_size movie mixed'}):
        meta_score_block.append(a.string)
if len(meta_score_block) == 0:
    for a in soup.find_all('span', attrs={'class': 'metascore_w header_size movie negative'}):
        meta_score_block.append(a.string)
meta_score = list_to_string(meta_score_block)
#  print(meta_score)

for a in soup.find_all('span', attrs={'class': 'metascore_w user larger movie positive'}):
    user_score_block.append(a.string)
if len(user_score_block) == 0:
    for a in soup.find_all('span', attrs={'class': 'metascore_w user larger movie mixed'}):
        user_score_block.append(a.string)
if len(user_score_block) == 0:
    for a in soup.find_all('span', attrs={'class': 'metascore_w user larger movie negative'}):
        user_score_block.append(a.string)
user_score = list_to_string(user_score_block)
#  print(user_score)

a_string = ""
for a in soup.find_all('span'):
    a_string += str(a.string)
    a_string += "\n"
runtime = re.findall("[0-9]+ min", a_string)
#  print(runtime[0])

data = {
    "Title": clean_title[0],
    "Metascore": meta_score,
    "Userscore": user_score,
    "Runtime": runtime[0]
}
with open('data.txt', 'w') as outfile:
    json.dump(data, outfile)
driver.close()
