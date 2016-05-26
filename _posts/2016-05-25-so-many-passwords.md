---
layout: post
title: 'Drowning in Passwords'
date: '2016-05-25T03:00:00-08:00'
modified_time: '2016-05-25T03:00:00-08:00'
author: Paul Ramsey
category: technology
tags:
- passwords
- lastpass
- security
comments: True
image: "2016/password.jpg"
---

I like the internet, I use a lot of sites, I don't fear online shopping or discussion or communication or banking. As a result, I have a pretty healthy footprint of accounts, and I have been finding recently that my brain can no longer keep up.

<img src="{{ site.images }}{{ page.image }}" alt="{{ page.title }}" width="580" height="287" />

So I've started using a password manager, [LastPass](https://lastpass.com/), which works just fine. 

Once I fully committed to it, the number of passwords managed started a slow and seemingly relentless climb, as over time I returned to all the many sites at which I had been forced to register accounts in the past. As a result, I've learned useful things:

* The number of sites I have accounts on is **far larger** than I thought. I have 40 entries in LastPass already, and I imagine I'm only about 2/3 of the way through adding all the sites I use more than once a year. Of those, easily a dozen are what you might call "important": banks, brokerages, email, OAuth sources (Twitter, Facebook, Google), etc. Far more sites than I kept separate passwords for!
* The centrality and **potential vulnerability of the email account** is hard to overstate. For 90% of the accounts I have added, the first step was "reset the password", since I had forgotten it. (In fact, that was my old access mechanism, since I accessed many sites so rarely.) And "reset" uses access to email as a source of proxy authentication. So, **0wn my email address, 0wn me**, entirely. If you haven't enabled [two-factor authentication](https://support.google.com/accounts/answer/185839?hl=en) on your email account yet, you need to, because of this.

Usually, improving security involves things getting **more inconvenient** but in the case of using a password manager, it has actually been a net improvement. No more time spent trying to remember which of the passwords in my limited brain key-chain I had used for a site. No more reset-password-and-wait for the many sites at which I had no idea what the password was.

LastPass has been very good, and I have only one note/caveat. The password manager works by installing a plug-in into your browser, so if you use multiple browsers (I use both Chrome and Safari regularly) you'll end up with multiple plugins. The preferences on those plugins are managed **separately**. Same thing if you use multiple computers (I do, desktop and laptop). Each plugin on each computer has separate preferences.

This is important because the LastPass preferences are, in my opinion, a little loose. Once you provide the master password, by default, the password vault remains unlocked and available until you actually shut down your browser. I can go days without shutting down my browser. So, I changed that preference to a time-out of 15 minutes instead. But I had to change it on every browser and on every computer I owned, which was not intuitive, since the plugin is good about sharing other information to other installs transparently (add a password on one browser, it's available on all).

So far I've been using the free version of LastPass, but as I move into the mobile world I will probably have to buck up for the paid version for support on mobile devices. Given how much it has simplified my life, I  won't begrudge them the dollars.

**Bonus paragraph:** Isn't saving all my passwords on a cloud service really dumb? Not so much. The passwords are only ever decrypted locally by the password manager plugin. The cloud just stores a big encrypted lump of passwords, and I have a lot of faith in [AES256](https://lastpass.com/whylastpass_technology.php). However, my security now has one big central point of failure: the master password. But since I only have to remember one master password, I have been able to make it nice and long, so any remote technical attack on my security is unlikely. That just leaves all the other kinds of attack (social engineering, keylogging, device theft, human factors, etc, etc).
