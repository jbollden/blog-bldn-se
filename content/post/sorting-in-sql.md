+++
author = ""
comments = true
date = "2012-12-04T15:42:00"
draft = false
image = ""
menu = ""
share = true
slug = "sorting-in-sql"
tags = ["sql"]
title = "Sorting in SQL"

+++

It's not completely uncommon to come across databases set to use collations and/or code pages where the ORDER BY clause won't sort as expected; e.g. Åke might be sorted before Carl.

A quick fix to this is to use either the CAST()- or the CONVERT()-function on the text field you wish to sort by. I tend to use CAST() since it's ANSI standard. However, CONVERT() works with all data types, while CAST() don't. For this exercise this is not an issue, data type BINARY works with both functions.

The following example will sort the result case sensitive, ascended by the name-column:

    SELECT uid, name
    FROM users
    ORDER BY CAST(name AS BINARY);

By using the LOWER()- or the UPPER()-function on the name-column will give a case insensitive sorting, which might be useful at times.
