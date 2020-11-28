# Learn Turbolinks

## Overview

* Uses [turbolinks](https://github.com/turbolinks/turbolinks) for caching page results: The demo app alows you to compare the behavior of a rails app with and without Turbolinks. Turbolinks caches pages so they will show up quickly the second time they are retrieved.

* Uses [turbolinks-prefetch](https://github.com/huacnlee/turbolinks-prefetch) for initiating page load on mouse hover instead of on click. This gives you results around 100-300ms faster than waiting for a click. (This doesn't seem to help if you are using a mobile browser.) 

* The script [setup.sh](./setup.sh) serves two purposes:
    * It generates two simple demo apps, each with 3 pages. The first demo app does not have turbolinks and the second does. This demonstrates the speed benefits of turbolinks.
    * Its contents show the minimal development steps for creating this demo app.



## Run Demo App


1. First clone repo:

```
git clone git@github.com:johnreitano/learn-turbolinks.git
cd learn-turbolinks
```

2. Running demo app without turbolinks. Run the following:

```
./setup.sh without-turbolinks
```

Then visit http://localhost:4000, click on each of the links Home, Dogs, and Puppies. Click a second time on each of the links and notice how the pages take over 1 second to load.

3. Running demo app with turbolinks enabled. In another terminal window, run:

```
./setup.sh with-turbolinks
```

Now visit (note new port) http://localhost:4100, click on each of the links Home, Dogs, and Puppies. Click a second time on each of the links and notice how now the pages load instantly.
