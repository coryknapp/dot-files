-- Auto reload config file
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


-- window moving/organizing stuff -- " {{{
-- left and right window half
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "h", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "l", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- move the current window to the bottom half of the screen without changing the
-- x dimensions/locations.
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "j", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y + (max.h/2)
  f.h = max.h / 2;
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "k", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.y = max.y
  f.h = max.h / 2;
  win:setFrame(f)
end)

-- make (almost) full screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "i", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h - 8;
  win:setFrame(f)
end)

-- }}}

-- Making Vim handy -- {{{
xCodeToVimScriptString= [[on run
    set current_document_path to "" 
    tell application "Xcode"
        set last_word_in_main_window to (word -1 of (get name of window 1))
        if (last_word_in_main_window is "Edited") then
            display notification "Please save the current document and try again"
            -- eventually we could automatically save the document when this becomes annoying
        else
			set current_document to document 1 whose name ends with last_word_in_main_window
            set current_document_path to path of current_document
        end if
    end tell
    tell application "MacVim"
        if (current_document_path is not "") then
            activate
            open current_document_path
        end if
    end tell
end run]]

genericToVimScriptString = [[on run
	tell application "System Events"
		set activeApp to name of first application process whose frontmost is true
	end tell
	tell application activeApp
		set top_window to window 1
		set top_doc to document of top_window
		set current_document_path to path of top_doc
	end tell
	tell application "MacVim"
		if (current_document_path is not "") then
			activate
			open current_document_path
		end if
	end tell
end run]]

hs.hotkey.bind({"ctrl"}, "o", function()
	local frontAppBundleId = hs.application.frontmostApplication():bundleID()
	hs.alert.show( frontAppBundleId )
	if frontAppBundleId == "com.apple.dt.Xcode" then
		local success, results = hs.applescript.applescript(xCodeToVimScriptString)
		if success == true then
			hs.alert.show("Opening in vim (XCode)")	
		else
			hs.alert.show("Failed to open (bad script)" )
			print( hs.inspect.inspect( results ) )
		end
	else -- use generic applescript
		local success, results = hs.applescript.applescript(genericToVimScriptString)
		if success then
			hs.alert.show("Opening in vim (Generic)")	
		else
			hs.alert.show("Failed to open (bad script)")
			print( hs.inspect.inspect( results ) )
		end
			
	end
	

end)

-- }}}
