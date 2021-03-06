JsOsaDAS1.001.00bplist00�Vscript_	�ObjC.import("Cocoa");

ObjC.registerSubclass({
	name: "AppDelegate",
	methods: {
		"btnClickHandler": {
			types: ["void", ["id"]],
			implementation: function (sender) {
				var panel = $.NSOpenPanel.openPanel;
				panel.title = "Choose an Image";
				
				var allowedTypes = ["jpg", "png", "gif"];
				// NOTE: We bridge the JS array to an NSArray here.
				panel.allowedFileTypes = $(allowedTypes);
				
				if (panel.runModal == $.NSOKButton) {
					// NOTE: panel.URLs is an NSArray not a JS array
					var imagePath = panel.URLs.objectAtIndex(0).path;
					textField.stringValue = imagePath;
					
					var img = $.NSImage.alloc.initByReferencingFile(imagePath);
					var imgView = $.NSImageView.alloc.initWithFrame(
						$.NSMakeRect(0, windowHeight, img.size.width, img.size.height));
					
					window.setFrameDisplay(
						$.NSMakeRect(
							0, 0, 
							(img.size.width > minWidth) ? img.size.width : minWidth,
							((img.size.height > minHeight) ? img.size.height : minHeight) + ctrlsHeight
						),
						true
					);
					
					imgView.setImage(img);
					window.contentView.addSubview(imgView);
					window.center;
				}
			}
		}
	}
});

var appDelegate = $.AppDelegate.alloc.init;

var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSMiniaturizableWindowMask;
var windowHeight = 85;
var windowWidth = 600;
var ctrlsHeight = 80;
var minWidth = 400;
var minHeight = 340;
var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(
	$.NSMakeRect(0, 0, windowWidth, windowHeight),
	styleMask,
	$.NSBackingStoreBuffered,
	false
);

var textFieldLabel = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 40), 200, 24));
textFieldLabel.stringValue = "Image: (jpg, png, or gif)";
textFieldLabel.drawsBackground = false;
textFieldLabel.editable = false;
textFieldLabel.bezeled = false;
textFieldLabel.selectable = true;

var textField = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 60), 205, 24));
textField.editable = false;

var btn = $.NSButton.alloc.initWithFrame($.NSMakeRect(230, (windowHeight - 62), 150, 25));
btn.title = "Choose an Image...";
btn.bezelStyle = $.NSRoundedBezelStyle;
btn.buttonType = $.NSMomentaryLightButton;
btn.target = appDelegate;
btn.action = "btnClickHandler";

window.contentView.addSubview(textFieldLabel);
window.contentView.addSubview(textField);
window.contentView.addSubview(btn);

window.center;
window.title = "Choose and Display Image Example";
window.makeKeyAndOrderFront(window);                              	� jscr  ��ޭ