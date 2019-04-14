---
title: "Example Guide"
layout: post
tags: [tag1, tag2, tag3]
author: "r/selfhosted"
assets: "/guides/assets/example-guide/"
---
Guide summary. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius pulvinar neque quis molestie. Donec efficitur magna vitae elementum placerat. Vivamus a justo ornare, vestibulum nisi tristique, aliquam ligula. Nullam neque tortor, condimentum vestibulum diam ac, congue feugiat neque. Donec lobortis venenatis mi. Maecenas leo libero, dapibus ultrices lacus non, posuere mollis dolor. Nunc vitae euismod enim. Morbi blandit ante mi. Sed vestibulum tellus non efficitur sollicitudin. Integer orci odio, porta at finibus sit amet, molestie eget purus. Mauris vestibulum mi ac malesuada cursus. Suspendisse elementum mauris sed metus lobortis, at tincidunt dui pharetra. In hac habitasse platea dictumst. Aliquam ac tempor urna.

## Subheading

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum varius pulvinar neque quis molestie. Donec efficitur magna vitae elementum placerat. Vivamus a justo ornare, vestibulum nisi tristique, aliquam ligula. Nullam neque tortor, condimentum vestibulum diam ac, congue feugiat neque. Donec lobortis venenatis mi. Maecenas leo libero, dapibus ultrices lacus non, posuere mollis dolor. Nunc vitae euismod enim. Morbi blandit ante mi. Sed vestibulum tellus non efficitur sollicitudin. Integer orci odio, porta at finibus sit amet, molestie eget purus. Mauris vestibulum mi ac malesuada cursus. Suspendisse elementum mauris sed metus lobortis, at tincidunt dui pharetra. In hac habitasse platea dictumst. Aliquam ac tempor urna.

### A list
* Entry 1
* Entry 2
* Entry 3

A non-highlighted codeblock
```
if (true) {
	//Do nothing
}
```

Highlighting!
{% highlight python %}
#!/usr/bin/python3

from engine import RunForrestRun

"""Test code for syntax highlighting!"""

class Foo:
	def __init__(self, var):
		self.var = var
		self.run()

	def run(self):
		RunForrestRun()  # run along!
{% endhighlight %}

Example image asset:
`![alt_text]({{ "image.png" | prepend: page.assets | relative_url }})`