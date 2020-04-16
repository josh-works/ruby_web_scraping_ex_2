### Basic Diagnostics

### 2020-04-16 3:40p 

Decided on an idea, I think. 

I've been reading _The Power Broker_, and Robert Moses's tactics seem exactly like what sort of stuff is listed in [this denver post](https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/) article.

So, I want to do something with data there.

_update, 2 hours in. I've almost finished scraping some random paragraphs for random strings. Thinking maybe my "extension" will be learning some cool UI thing in displaying it. Which will require saving it in a more complex form than I did last time around._

The article shows raw data, available as a CSV. I want to do something very similar as I did last time, in [https://random-hn-blog.herokuapp.com/](https://random-hn-blog.herokuapp.com/).

(just fixed it, broke Heroku build with a `Procfile` update.)

I'll search article text, figure out how to get any mentions of the listed Metropolitan Districts _listed in the main article content_ but not in any other portion of the page. 

So, we want these instances:

![wanted](/images/denver_post_01.jpg)


But not these instances:

![not wanted](/images/denver_post_02.jpg)

We'll have to figure out a little tiny bit about web scraping (searching `Nokogiri::XML::Element` text with a `regular expression` instead of an HTML element. Should be easy.)

I'm now 20 min into the project. Lets get started with Nokogiri in Pry!

(I'd open up a `parser.rb` file at the root to start copy/pasting code into for tracking progress with Nokogiri in Pry)

```ruby
# new pry session
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/"))
```

Head over to the article, find the first instance of the string `Metropolitan District`, using ctrl-f.

![find first element](/images/denver_post_03.jpg)

(I saved the article HTML in this repo, btw. If we set up tests later we'll use the saved version, to make sure we have consitency.)

To use `cURL` to save articles like this for parsing:

```
$ curl -L https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/ -o denver_post_metro_districts.html
$ open denver_post_metro_districts.html
```

We'll find every `p` html element that has a `text` value containing the words `metropolitian district`

So, I knew I needed a regex-based xpath selector.

I googled and found [How do I do a regex search in Nokogiri for text that matches a certain beginning?](https://stackoverflow.com/questions/1556028/how-do-i-do-a-regex-search-in-nokogiri-for-text-that-matches-a-certain-beginning)

I stumbled across the `contains` xpath selector, no idea how to use it. Found:

[XPath contains(text(),'some string') doesn't work when used with node with more than one Text subnode](https://stackoverflow.com/questions/3655549/xpath-containstext-some-string-doesnt-work-when-used-with-node-with-more)

And I played with their example in the earlier pry session:

```ruby
# lets find paragraphs inside the article body:
doc.css('.article-body').css('p')
doc.css('.article-body').css('p').count
=> 355
element = doc.css('.article-body').css('p').first

# lets grab the first paragraph, so we can figure out what to apply to the #map 
# we'll be calling on the above collection

element.xpath("//*[contains(text(), 'abc)]")
=> # error
element.xpath('//*[contains(text(), "abc")]')
=> # empty

element.xpath('//*[contains(text(), "a")]')
=> # huge result set!

element.xpath('//*[contains(text(), "watershed")]')
=> # a paragraph containing the word watershed!

element.xpath('//*[contains(text(), "Metropolitan District")]')
=> # big result!

element.xpath('//*[contains(text(), "Metropolitan District")]').to_a
=> # nailed it:
```

OK, we're getting close, really close:

![finding just the paragraphs we want](/images/denver_post_04.jpg)

Lets grab just those paragraph, in an array:

Ended up going with:

```ruby
# parser.rb
require 'nokogiri'
require 'open-uri'

# doc = Nokogiri::HTML(open("https://www.denverpost.com/2019/12/05/metro-districts-debt-democracy-colorado-housing-development/"))
doc = Nokogiri::HTML(open("denver_post_metro_districts.html"))

# paragraphs we want?

paragraphs = doc.css('.article-body').css('p')

sentences = paragraphs.map {|p| p.xpath('//*[contains(text(), "Metropolitan District")]') }

output = sentences.map do |sen|
  sen.map do |p|
    p.text
  end
end

# nailed it!
p output.first
```

Here's the output:

![nailed it](/images/denver_post_05.jpg)

---------------------

I'm ready to turn this script into a ruby class. 

Pre-refactor, commit `afcdca8`


Now it's two ruby classes, write the text by running

```
$ ruby writer.rb
```

### Sinatra Time!

OK, added Sinatra in about... 8 minutes? It's an ugly UI:

`app.rb`, `Gemfile`, `views/default.erb`

![uuuugly](/images/denver_post_06.jpg)

The repo is at `ab66bc0`

### Add Styles

adding `public/styles.css`




### Resources

- [Use the xpath function starts-with (Stack Overflow)](https://stackoverflow.com/a/1556128/3210178)
- [Web technology for developers: XPath/Functions/contains](https://developer.mozilla.org/en-US/docs/Web/XPath/Functions/contains)





























