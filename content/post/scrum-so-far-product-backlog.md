+++
author = ""
comments = true
date = "2015-08-12T15:03:00"
draft = false
image = ""
menu = ""
share = true
slug = "scrum-so-far-product-backlog"
tags = ["scrum"]
title = "Scrum, so far - product backlog"

+++

A product backlog is a prioritised list of items yet to be added to the product. An item is something that someone wants to be part of the product. The product backlog is responsibility of the Product Owner.

In my opinion the easiest way to administrate the product backlog is as a shared spreadsheet document (Google Docs, Office 365, Dropbox, network share, etc.). The main reason is the ease of use, e.g. adding columns, colour coding, filtering, and sorting.

There are, however, some columns I believe is mandatory in a product backlog:

<dl>
<dt>Id</dt>
<dd>A unique identifier for the item, auto incremented integers works well.</dd>

<dt>Name</dt>
<dd>Just a few words describing the item. Think of it as a phrase or heading you most commonly will use in a conversation about the item, e.g. "Change account information", "Edit account".</dd>

<dt>Description</dt>
<dd><p>This text should not be written in a technical language, but rather in a business-like manner. Expressed in another way, try to answer the question of what, sometimes why, and not how.</p>

<p>A very powerful technique is to use <a href="https://en.wikipedia.org/wiki/User_story">user stories</a> and there's a lot written on this. I use it in the simple form presented by Mike Cohn (<a href="http://www.mountaingoatsoftware.com/blog/advantages-of-the-as-a-user-i-want-user-story-template">blog post</a>): "As a [type of user], I want [some goal] so that [some reason]", (the "so that"-clause is optional). This form puts me, the reader of the item in the mental position of being a [type of user]. To exemplify:
<ul>
<li>As a logged in customer, I want to be able to edit my account information.</li>
<li>As an end-user, I want to change my password every ninetieth day.</li>
<li>As a logging system, I want to retrieve new log files on a daily basis so that they can be stored centrally.</li>
</ul>
</p>
<p>Even though it may sound and look silly to set other systems as [type of user] this form stills puts the reader in a mental position to understand the purpose.</p>

<p>Following the user story I add information needed to understand or define parts of the user story. Looking at the first example I would suggest that the [type of user] "customer" is defined/described centrally, outside the item since it most likely will be part of many items, a note could be added regarding this.</p>

<p>In the same example the "account information" has to be specified, in this case I would add the definition to the item and not centrally.</p></dd>

<dt>Importance</dt>
<dd>Use unique integers to note the item's importance, the higher the number the more important it is. Leave gaps, this will allow you to easily insert other items without the need to edit all other items.

<dt>Guesstimate</dt>
<dd><p>The initial estimate of the team. There are many different ways to do an estimate but I advocate the use of workdays to give the guesstimate on an item. The number of undisturbed workdays for one person with full knowledge and all applicable skills to complete the item is the guesstimate.</p>

<p>This discussion usually appear during the backlog refinement meeting, and while discussing the team will often start to break down the item into tasks to better understand the work needed. As a Product Owner it will be tempting to write down these tasks and hold them over the team's head during the sprint planning.</p>

<p>My suggestion is that you don't do that, tasks have no place in the product backlog. However, if the team wants to remember what they've been talking about this could be put in the notes column.</p></dd>

<dt>Notes</dt>
<dd>In this column answers to the question of how can be added. If there are foreseeable problems with the implementation of the item or perhaps external dependencies, then this would be perfect to add here.<dd>
</dl>

With the above columns in a spreadsheet a basic structure for a product backlog is in place. Depending  on the product, there might be other columns needed.

A rule of thumb that I use when it comes to formulating an item is: In the context of the product's current state each item still to be added should be self-contained and non-dependant of any other item in the product backlog.

Before I can explain this I first have to answer the question of what happens to an item in the product backlog once it's been added to the product, and, subsequently, when is an item from the product backlog added to the product.

An item is added to the product once the team has included it in the sprint backlog, which means the item in turn is removed from the product backlog (it may return should the team be unsuccessful in doing its part to actually add the item to the product at the end of the sprint, but much more on this in other article).

Why you should try to avoid items depending on other items is mainly an issue of manoeuvrability. Let's say item B is dependant of item A, this will mean that item A will always have higher importance than item B otherwise B cannot be added to the product. I would suggest making a new item C from A and B and examine if C might be added to the product, otherwise the scope of C might have to change.

But what if A is already added to the product? In that case A is "in the context of the product's current state" and is not part of the product backlog, hence B is not dependant of A.

The initial product backlog is often the result of a series of workshops you as a Product Owner has facilitated, then when the team has started on the product items comes from left and right, high and low. As a Product Owner this might feel overwhelming. At this point you should remember that someone appointed you to be the owner of this product, and you do this through the product backlog. A well-managed and -maintained product backlog will help the team, the product and the organisation to excel, without it Scrum will be hard.

As a last note, I'm afraid I have to state the obvious, there's one product backlog for each product even if the Product Owner has multiple products and only one Scrum team, don't cut corners with this.

*This post is part of [a set of articles](/2015/08/07/scrum-so-far-a-set-of-articles/) on the subject of "Scrum, so far".*

