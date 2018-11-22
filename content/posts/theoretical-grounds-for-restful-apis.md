+++
author = ""
comments = true
date = "2014-06-10T16:35:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "theoretical-grounds-for-restful-apis"
tags = ["api", "rest", "restful", "roa", "web"]
title = "Theoretical grounds for RESTful APIs"

+++

There is a lot said and written about REST and being RESTful, and in this post I give my two cents when it comes to what theoretical grounds I use when creating RESTful <abbr title="Application programming interface">API</abbr>s.

In the year 2000 Roy Thomas Fielding published his dissertation [Architectural Styles and the Design of Network-based Software Architectures](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm). The last sentence of the abstract's third paragraph reads:

> I then introduce the Representational State Transfer (REST) architectural style and describe how REST has been used to guide the design and development of the architecture for the modern Web.

It is in Chapter 5 Fielding at length introduces the Representational State Transfer. Fielding lists a number of constraints to be used in order to decide whether an application conforms to REST or not. If the application is conforming to the constraints it is said to be "RESTful".

When reading this dissertation one should not forget what it is; an academic text written in an academic context for an academic audience. Even though not all academic texts are written in a way that makes it difficult for non-academics to understand, I personally have a hard time following Fielding's line of thought. Therefore, I searched for books that could explain the concepts of REST and being RESTful in a more practical sense. I found three books, all from [O'Reilly Media](http://www.oreilly.com):

* Allamaraju, S. (2010). RESTful Web Services Cookbook. Sebastopol: O'Reilly Media.
* Richardson, L. & Amundsen, M. (2013). RESTful Web APIs. Sebastopol: O'Reilly Media.
* Richardson, L. & Ruby, S. (2007). RESTful Web Services. Sebastopol: O'Reilly Media.

In Appendix C Richardson and Amundsen (2013) explains the Fielding constraints in a more developer-friendly language. What they write in Appendix C is in a way a shorter version of the Wikipedia article on [Representational state transfer](http://en.wikipedia.org/wiki/Representational_state_transfer) but also in a way a deeper text. All in all, this book is a good read but it is very advanced and I would only recommend it to web service experts with experience in RESTful APIs.

Allamaraju (2010) is also a good book which follows O'Reilly's traditions of cookbooks; the author presents a problem and gives an answer, a recipe. It is a pretty straightforward book and I use it as reference when I am in need of recipes.

Richardson and Ruby (2007) introduces the [Resource-Oriented Architecture](http://en.wikipedia.org/wiki/Resource-oriented_architecture) (ROA) and in this they also summarise Fielding's constraints into four properties; addressability, statelessness, the uniform interface, and connectedness. Applying the principles of these four properties on the resources you have identified will help you make your API RESTful. This architecture is said to be resource-oriented, therefore I first need to define what is meant with a resource in ROA.

## Resource

Richardson and Ruby (2007) defines a resource as "anything that's important enough to be referenced as a thing in itself" (p. 83), this definition is also found in Richardson and Amundsen (2013, p. 30). Allamaraju (2010) defines it a bit more loosely as "anything that can be identified by a <abbr title="Uniform resource identifier">URI</abbr>" (p. 261). However, the most descriptive definition is found in the Glossary of Richardson and Amundsen, which reads:

> A resource can be anything: a web page, a person, that person's name, a measurement of his weight on a given day, his relationship to another person... anything at all. The only restriction is that a resource must have its own URI. Without a URI, there's nothing to talk about.<br />&nbsp;<br />
> A client will never directly interact with a resource. It only sees descriptions of a resource's state, written down in representations. (p. 361)

This defines what a resource is through examples, and at the same time introduces some key concepts regarding resources. First, a URI is required for each resource, i.e. a resource must be uniquely identified, and secondly, a client works with representations of a resource, not the resource itself.

You could think of a resource as a text file located on a server, this file is uniquely identified by its path and name on that server. Downloading the file to your computer will not alter the file on the server; rather you have a copy, a representation of the server's file.

## Properties of ROA

There are four principles of ROA according to Richardson and Ruby (2007). I see them as a summary of the Fielding constraints, and by applying them to each resource you have identified for your API you will be able to get far in getting a RESTful API.

### Addressability

Every resource needs to be available, which means that the resource needs a unique address, e.g. a file has a path and a name that makes it uniquely addressable. On the web this means that a resource has a <abbr title="Uniform resource locator">URL</abbr>, accessing that URL will retrieve a representation of that particular resource and not any other resource.

### Statelessness

A RESTful API should not need to bother about application state, which is the client's concern. This means that "every request is handled in isolation and evaluated against the current resource state" (Richardson & Ruby, 2007, p. 222) and the server are responsible for the resource state.

A simple way to exemplify statelessness is to think of a resource or an entire API that requires authorisation. Every request the client does have to contain information required to authorise the request, i.e. the server will not hold any information about the user being logged in other than validating the credentials sent with each particular request.

### The Uniform Interface

Most of today's applications are based on some sort of <abbr title="Create, Read, Update, and Delete">CRUD</abbr> actions, and when it comes to RESTful APIs there is no need to build functions for CRUD because they are already present in <abbr title="Hypertext Transfer Protocol">HTTP</abbr> which is most likely the protocol used for interactions between clients and the API of the server.

In HTTP there are a number of methods that among other things expresses the different parts of CRUD. In [Section 9](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html) of [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616.html) the different methods are defined. Fielding is one of the authors behind RFC 2616, the main document describing HTTP/1.1.

Even though I am aware that POST can be used as an update action I try to use just one method for each action. Through this I can be consistent in what each method is supposed to do. POST is also, in my mind, the most difficult method to use for anything else than the create action. The table below shows how I tend to use these methods:
<table>
		<tr>
			<th>CRUD</th>
			<th>HTTP</th>
		</tr>
		<tr>
			<td>Create</td>
			<td>POST</td>
		</tr>
		<tr>
			<td>Read</td>
			<td>GET</td>
		</tr>
		<tr>
			<td>Update</td>
			<td>PUT</td>
		</tr>
		<tr>
			<td>Delete</td>
			<td>DELETE</td>
		</tr>
</table>

Another, sometimes forgotten, part of the uniform interface is that HTTP actually includes predefined response codes that should be used; defined in [Section 10](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) of RFC 2616. If a resource is missing, respond with 404, if everything is OK, respond with 200; all in accordance with the definition of HTTP. To some extent, HTTP could actually be seen as a framework for REST.

### Connectedness

By applying what Richardson and Ruby (2007) terms connectedness to your API, you will get a service that guides the client in its use of the API. This is what Fielding terms "hypermedia as the engine of application state" ([HATEOAS](http://en.wikipedia.org/wiki/HATEOAS)). Connectedness is achieved through the use of links and forms. Richardson and Amundsen (2013) discuss HATEOAS at length. The main part of the book is centred on this; the hypermedia as the engine of application state.

How a web site is built for human use is the way I think of connectedness. These kinds of sites usually have some kind of menu, and the menu allows the human user to move from one page to another without having to construct URLs, the user just has to click on a link, a hyperlink. This does not mean that every representation in your API needs to include all possible links in the API. It means that enough information should be included in the representation to guide the client to the next step, or resource.

Let's say you are on a page that lists Volvo cars, and from this page it is not necessary to get to a list of Scania trucks with just one click, with one request. It is probably enough to give a link on the list of Volvo cars to a page listing different car brands, from there to a list of vehicle types, and so on. This could result in the following structure for the client to work with:
<ul>
	<li>vehicles
		<ul>
			<li>cars
				<ul>
					<li>SAAB</li>
					<li>Volvo</li>
					<li>...</li>
				</ul>
			</li>
			<li>trucks
				<ul>
					<li>Mack</li>
					<li>Scania</li>
					<li>...</li>
				</ul>
			</li>
		</ul>
	</li>
</ul>

## Two cents summary

Resources are things; therefore it is a good idea to use descriptive nouns to name them, and the name of the resource should be something meaningful since each resource has to be exposed to the outside world through URLs, web addresses, which the resource name will be part of. Should the resource not be exposed it would not be consumable by clients.

Further, let the server be responsible for resource state and let the client be responsible for application state. This means that the client should keep track of what the client, the application, is and has been doing, while the server should only focus on the state of the resource, e.g. what kind of information the resource is holding at the moment.

Use the built in functionality of HTTP as intended. There is no need to create new methods or new response codes, the built in will suffice. This also applies to the use of a method to something it was not designed to do; a GET request should do a read operation and not a deletion of that same resource. Deciding to use a uniform interface implies that, as a developer and as a consumer of the API, you submit to the intended use of the same uniform interface.

Finally, make sure the resources are connected, let the API be responsible for how resources relate to each other.

To be RESTful is in a way to be lazy since many of the mechanical parts are already in place. Creating RESTful APIs exudes DRY - Don't Repeat Yourself.
