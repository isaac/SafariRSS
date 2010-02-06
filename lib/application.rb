begin
 require 'hotcocoa'
rescue LoadError
  require 'rubygems'
  require 'hotcocoa'
end

class Application

  include HotCocoa
  
  def start
    application :name => "SafariRSS" do |app|
      gurl = 'GURL'.unpack('N').first
      NSAppleEventManager.sharedAppleEventManager.setEventHandler self, andSelector:"getURL:reply:", forEventClass:gurl , andEventID:gurl
    end
  end
  
  def getURL(event, reply:reply)
    url = event.paramDescriptorForKeyword('----'.unpack('N').first).stringValue.gsub('feed://', 'http://')
    NSWorkspace.sharedWorkspace.openURL NSURL.URLWithString("http://www.google.com/reader/view/feed/#{url}")
    NSApplication.sharedApplication.terminate nil
  end
  
end

Application.new.start