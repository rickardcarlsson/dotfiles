/*** MaterialFox ***/
/**  Mandatory	  **/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // default is false
user_pref("svg.context-properties.content.enabled", true); 				// default is false

/**  Recommended  (uncomment to apply) **/
/* Replicate Chrome behaviour for clipped tabs */
user_pref("browser.tabs.tabClipWidth", 83); 							// default is 140

/* Replicate Chrome's "Not Secure" text on HTTP */
user_pref("security.insecure_connection_text.enabled", true);

/* Allow tabs to shrink more; tabs in overflow will look the same as pinned tabs */
user_pref("materialFox.reduceTabOverflow", true);

/* Disable un-wanted but built-in extensions and features. */
user_pref('browser.pocket.enabled', false);
user_pref('extensions.pocket.enabled', false);

/* Forcing webrender is way more performant, 
 will probably be enabled by default in the future 
*/
user_pref('gfx.webrender.all', true);
user_pref('gfx.webrender.enabled', true);

// force OpenGL acceleration to prevent tearing on 1080 60fps videos.
user_pref("layers.acceleration.force-enabled", true); 

// disable alt key toggling the menu bar [RESTART]
user_pref("ui.key.menuAccessKey", 0); 
user_pref("ui.key.menuAccessKeyFocuses", false);

/* 2032: disable audio autoplay in non-active tabs [FF51+]
 * [1] https://www.ghacks.net/2016/11/14/firefox-51-blocks-automatic-audio-playback-in-non-active-tabs/ ***/
user_pref("media.block-autoplay-until-in-foreground", true);

// Sidebar position right.
user_pref("sidebar.position_start", false);

// Dont remember my passwords.
user_pref("signon.rememberSignons", false);

// Disable spellcheck.
user_pref("layout.spellcheckDefault", 0);

/* Backspace as go back */
user_pref("browser.backspace_action", 0);

user_pref("browser.startup.homepage", "about:home");
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.display.use_system_colors", true);


user_pref("browser.startup.page", 3);
user_pref("browser.tabs.warnOnClose", false);

user_pref("systemUsesDarkTheme", 1);

user_pref("reader.color_scheme", "dark");
user_pref("reader.content_width", 7);
user_pref("reader.font_size", 8);

user_pref("extensions.webextensions.restrictedDomains", "");

user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);
user_pref("devtools.theme", dark);
