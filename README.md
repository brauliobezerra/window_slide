# window_slide.rb

Script which shows/hides a windows the same way done in Guake Terminal.

To be used inside a global shortcut like F12 or Win+J.

## Requirements

* xdotool
* wmctrl
* ruby (_I hate bash confusing syntax_)

## Using

> ./window_slide.rb 'title' x,y,width,height 'command'

where:

* __title__: unique title of window, or part of it;
* __command__: = command to execute if the window doesn't exist yet.

## Examples

> ./window_slide.rb 'Finances.ods' 0,0,1920,800 'xdg-open ~/finances.ods'

> ./window_slide.rb 'Example Domain' 100,100,500,500 'firefox --new-window http://example.com/'

