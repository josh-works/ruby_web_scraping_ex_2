### Basic Diagnostics

### 2020-04-16 3:40p 

Decided on an idea, I think. 

I've been reading _The Power Broker_, and Robert Moses's tactics seem exactly like what sort of stuff is listed in [this denver post](https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/) article.

So, I want to do something with data there.

The article shows raw data, available as a CSV. I want to do something very similar as I did last time, in [https://random-hn-blog.herokuapp.com/](https://random-hn-blog.herokuapp.com/).

(just fixed it, broke Heroku build with a `Procfile` update.)

I'll search article text, figure out how to get any mentions of the listed Metropolitan Districts _listed in the main article content_ but not in any other portion of the page. 

So, we want these instances:

![wanted](/images/denver_post_01.jpg)


But not these instances:

![not wanted](/images/denver_post_02.jpg)

We'll have to figure out a little tiny bit about web scraping (searching `Nokogiri::XML::Element` text with a `regular expression` instead of an HTML element. Should be easy.)

I'm now 20 min into the project. Lets get testing with Nokogiri!

```ruby

```