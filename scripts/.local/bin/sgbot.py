# pylint: disable=line-too-long, missing-docstring, too-few-public-methods, invalid-name, too-many-arguments
import time
import logging
import requests
from bs4 import BeautifulSoup as bs

import config

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(name)s %(levelname)s %(message)s',)
LOG = logging.info

class Giveaway:
    def __init__(self, name, points, href, entries, remaining, created):
        self.name = name
        self.points = points
        self.chance = 1 / (entries + remaining * (entries/created))
        self.href = "https://www.steamgifts.com" + href

    def enter(self):
        user_agent = {"User-agent": config.USER_AGENT}
        cookie = {"PHPSESSID": config.SESSION}
        req = requests.get(self.href, headers=user_agent, cookies=cookie)

        soup = bs(req.text, 'html5lib')
        token = soup.find('input', attrs={'name': 'xsrf_token'})['value']
        code = soup.find('input', attrs={'name': 'code'})['value']

        formData = {'xsrf_token': token, 'do': 'entry_insert', 'code': code}
        requests.post('https://www.steamgifts.com/ajax.php', headers=user_agent, cookies=cookie, data=formData)

    def __str__(self):
        return "{} ({}P) [{}] Chance: {}".format(self.name, self.points, self.href, self.chance)

    def __repr__(self):
        return "{} ({}P) [{}] Chance: {}".format(self.name, self.points, self.href, self.chance)


def load_giveaways(biggame=False):
    """ Return sorted list of Giveaways worth 10 points or more """
    #url_pattern = "https://www.steamgifts.com/giveaways/search?page={}&type=new"
    url_pattern = "https://www.steamgifts.com/giveaways/search?page={}"
    user_agent = {"User-agent": config.USER_AGENT}
    cookie = {"PHPSESSID": config.SESSION}

    def points_span(tag):
        return tag.name == 'span' and 'P' in tag.text

    giveaways = []
    for page in [1, 2, 3, 4]: # load first 4 pages
        req = requests.get(url_pattern.format(page), headers=user_agent, cookies=cookie)
        soup = bs(req.text, 'html5lib')
        for g in soup.find_all('div', attrs={'class': 'giveaway__row-outer-wrap'}):
            if g.find('div', class_='is-faded'):
                # skip already entered giveaways
                continue
            remaining = convert_time(*g.find(lambda tag: tag.name == 'span' and "remain" in tag.text).text.split()[:2])
            if remaining == 0:
                # skip giveaways ending in less than a minute
                continue
            entries = int(''.join([i for i in g.find(lambda tag: tag.name == 'span' and 'entr' in tag.text).text.split()[0] if i.isnumeric()]))
            entries = max(entries, 1)
            created = convert_time(*g.find(lambda tag: tag.name == 'span' and "ago" in tag.text).text.split()[:2])
            created = max(created, 1)
            if None in (remaining, entries, created):
                print(remaining, entries, created)
                print(g)
            game = g.find('a')
            name = game.text
            link = game['href']
            points = int(''.join([p for p in g.find(points_span).text if p.isdigit()]))
            giveaways.append(Giveaway(name=name,
                                      points=points,
                                      href=link,
                                      entries=entries,
                                      created=created,
                                      remaining=remaining))
    giveaways = [g for g in giveaways if g.points > 8]
    if biggame:
        giveaways.sort(key=lambda g: g.points, reverse=True)
    else:
        giveaways.sort(key=lambda g: g.chance, reverse=True)
    return giveaways


def get_user_points():
    url = "https://www.steamgifts.com/"
    user_agent = {"User-agent": config.USER_AGENT}
    cookies = {"PHPSESSID": config.SESSION}
    req = requests.get(url, headers=user_agent, cookies=cookies)
    soup = bs(req.text, 'html5lib')
    return int(soup.find('span', class_="nav__points").text)


def convert_time(n, what):
    n = int(''.join(filter(lambda x: x.isnumeric(), n)))
    if "minute" in what:
        return n
    if "hour" in what:
        return n * 60
    if "day" in what:
        return n * 24 * 60
    if "second" in what:
        return 0
    if "week" in what:
        return n * 7 * 24 * 60

def loop():
    biggame = False
    while True:
        points = get_user_points()
        LOG("Current points: {}".format(points))
        if points > 60:
            giveaways = load_giveaways(biggame)
            biggame = not biggame
            for g in giveaways:
                if g.points > points:
                    continue
                LOG("Entering giveaway: {}".format(g))
                g.enter()
                points -= g.points
                LOG("{} points reamaining".format(points))
        LOG("Going to sleep")
        time.sleep(8*60)


if __name__ == "__main__":
    LOG("Starting SteamGifts bot")
    loop()
