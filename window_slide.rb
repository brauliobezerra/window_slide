#!/usr/bin/env ruby
#encoding: utf-8

if ARGV.size < 3
	puts "
Use: 

	window_slide.rb 'title' x,y,width,height 'command'

Where:

	title = unique title of window, or part of it
	command = command to execute if the window doesn't exist yet

Example:

	./window_slide.rb 'Example Domain' 100,100,500,500 'firefox --new-window http://example.com/'
"

	exit
end


$windowName     = ARGV[0]
$position       = ARGV[1]
$executeCommand = ARGV[2]

maxWaitingTime = 10.0 # seconds
retryDelay     = 0.25 # seconds








def findWindow
	`xdotool search --name '#{$windowName}'`.strip
end

windowID = findWindow

if windowID == ''
	puts "Window not found. Opening it..."
	`#{$executeCommand} &`

	curtime = 0.0 # seconds
	delay = 0.25
	until findWindow == '' and curtime <= maxWaitingTime
		puts 'waiting...'
		curtime += retryDelay
		sleep      retryDelay
	end

	windowID = findWindow
end

currentWindow = `xdotool getactivewindow`.strip

if windowID == currentWindow
	# hide
	`xdotool windowminimize #{windowID}`
else
	# show
	`xdotool windowactivate         #{windowID}`
	`wmctrl  -i -r                  #{windowID} -b add,above,skip_taskbar`
	`wmctrl  -i -r                  #{windowID} -b remove,maximized_vert,maximized_horz`
	`wmctrl  -i -r                  #{windowID} -e 0,#{$position}`
	`xdotool set_desktop_for_window #{windowID} -1`
	# TODO don't change properties if not needed (maybe this will avoid some repaints)
end

