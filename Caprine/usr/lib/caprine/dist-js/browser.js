"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isNewDesign = void 0;
const electron_better_ipc_1 = require("electron-better-ipc");
const electron_util_1 = require("electron-util");
const elementReady = require("element-ready");
const selectors_1 = require("./browser/selectors");
const config_1 = require("./config");
const autoplay_1 = require("./autoplay");
const conversation_list_1 = require("./browser/conversation-list");
const selectedConversationSelector = '._5l-3._1ht1._1ht2';
const selectedConversationNewDesign = '[role=navigation] [role=grid] [role=row] [role=gridcell] [role=link][aria-current]';
const preferencesSelector = '._10._4ebx.uiLayer._4-hy';
//const preferencesSelectorNewDesign = '[aria-label=Preferences]';
const preferencesSelectorNewDesign = 'div[class="rq0escxv l9j0dhe7 du4w35lb"] > div:nth-of-type(3) > div';
const messengerSoundsSelector = `${preferencesSelector} ._374d ._6bkz`;
const conversationMenuSelector = '.uiLayer:not(.hidden_elem) [role=menu]';
const conversationMenuSelectorNewDesign = '[role=menu].l9j0dhe7.swg4t2nn';
async function withMenu(isNewDesign, menuButtonElement, callback) {
    const { classList } = document.documentElement;
    // Prevent the dropdown menu from displaying
    classList.add('hide-dropdowns');
    // Click the menu button
    menuButtonElement.click();
    // Wait for the menu to close before removing the 'hide-dropdowns' class
    const menuLayer = isNewDesign ? document.querySelector('.j83agx80.cbu4d94t.l9j0dhe7.jgljxmt5.be9z9djy > div:nth-child(2) > div') : document.querySelector('.uiContextualLayerPositioner:not(.hidden_elem)');
    if (menuLayer) {
        const observer = new MutationObserver(() => {
            if (isNewDesign ? !menuLayer.hasChildNodes() : menuLayer.classList.contains('hidden_elem')) {
                classList.remove('hide-dropdowns');
                observer.disconnect();
            }
        });
        observer.observe(menuLayer, isNewDesign ? { childList: true } : { attributes: true, attributeFilter: ['class'] });
    }
    else {
        // Fallback in case .uiContextualLayerPositioner is missing
        classList.remove('hide-dropdowns');
    }
    await callback();
}
async function withSettingsMenu(isNewDesign, callback) {
    // If ui is new, get the new settings menu
    const settingsMenu = isNewDesign ?
        (await elementReady('.rq0escxv.l9j0dhe7.du4w35lb.j83agx80.cbu4d94t.pfnyh3mw.d2edcug0.hpfvmrgz.aovydwv3.p8cu3f6v.kb5gq1qc.taijpn5t.b0upgy8r .j83agx80.pfnyh3mw .ozuftl9m [role=button]', { stopOnDomReady: false })) :
        (await elementReady('._30yy._6ymd._2agf,._30yy._2fug._p', { stopOnDomReady: false }));
    await withMenu(isNewDesign, settingsMenu, callback);
}
async function selectMenuItem(isNewDesign, itemNumber) {
    let selector;
    if (isNewDesign) {
        // Wait for menu to show up
        await elementReady(conversationMenuSelectorNewDesign, { stopOnDomReady: false });
        const items = document.querySelectorAll(`${conversationMenuSelectorNewDesign} [role=menuitem]`);
        selector = itemNumber <= items.length ? items[itemNumber - 1] : null;
    }
    else {
        selector = document.querySelector(`${conversationMenuSelector} > li:nth-child(${itemNumber}) a`);
    }
    if (selector) {
        selector.click();
    }
}
async function selectOtherListViews(isNewDesign, itemNumber) {
    // In case one of other views is shown
    clickBackButton();
    await withSettingsMenu(isNewDesign, () => {
        selectMenuItem(isNewDesign, itemNumber);
    });
}
function clickBackButton() {
    const backButton = document.querySelector('._30yy._2oc9');
    if (backButton) {
        backButton.click();
    }
}
electron_better_ipc_1.ipcRenderer.answerMain('show-preferences', async () => {
    const newDesign = await isNewDesign();
    if (isPreferencesOpen(newDesign)) {
        return;
    }
    await openPreferences(newDesign);
});
electron_better_ipc_1.ipcRenderer.answerMain('new-conversation', async () => {
    if (await isNewDesign()) {
        document.querySelector('[href="/new/"]').click();
    }
    else {
        document.querySelector('._30yy[data-href$="/new"]').click();
    }
});
electron_better_ipc_1.ipcRenderer.answerMain('log-out', async () => {
    if (config_1.default.get('useWorkChat')) {
        document.querySelector('._5lxs._3qct._p').click();
        // Menu creation is slow
        setTimeout(() => {
            const nodes = document.querySelectorAll('._54nq._9jo._558b._2n_z li:last-child a');
            nodes[nodes.length - 1].click();
        }, 250);
    }
    else {
        const newDesign = await isNewDesign();
        await withSettingsMenu(newDesign, () => {
            if (newDesign) {
                selectMenuItem(newDesign, 11);
            }
            else {
                const nodes = document.querySelectorAll('._54nq._2i-c._558b._2n_z li:last-child a');
                nodes[nodes.length - 1].click();
            }
        });
    }
});
electron_better_ipc_1.ipcRenderer.answerMain('find', () => {
    var _a;
    const searchBox = (_a = 
    // Old UI
    document.querySelector('._58al')) !== null && _a !== void 0 ? _a : 
    // Newest UI
    document.querySelector('[aria-label="Search Messenger"]');
    searchBox.focus();
});
async function openSearchInConversation() {
    var _a, _b;
    const mainView = document.querySelector('.rq0escxv.l9j0dhe7.du4w35lb.j83agx80.g5gj957u.rj1gh0hx.buofh1pr.hpfvmrgz.i1fnvgqd.gs1a9yip.owycx6da.btwxx1t3.jb3vyjys.nwf6jgls');
    const rightSidebarIsClosed = Boolean(mainView.querySelector('div:only-child'));
    if (rightSidebarIsClosed) {
        document.documentElement.classList.add('hide-r-sidebar');
        (_a = document.querySelector('[aria-label="Conversation Information"]')) === null || _a === void 0 ? void 0 : _a.click();
    }
    await elementReady(selectors_1.default.rightSidebarButtons, { stopOnDomReady: false });
    const buttonList = document.querySelectorAll(selectors_1.default.rightSidebarButtons);
    console.log(buttonList);
    if (buttonList.length > 4) {
        buttonList[4].click();
    }
    // If right sidebar was closed when shortcut was clicked, then close it back.
    if (rightSidebarIsClosed) {
        (_b = document.querySelector('[aria-label="Conversation Information"]')) === null || _b === void 0 ? void 0 : _b.click();
        // Observe sidebar so when it's hidden, remove the utility class. This prevents split
        // display of sidebar.
        const sidebarObserver = new MutationObserver(records => {
            const removedRecords = records.filter(({ removedNodes }) => removedNodes.length > 0 && removedNodes[0].tagName === 'DIV');
            // In case there is a div removed, hide utility class and stop observing
            if (removedRecords.length > 0) {
                document.documentElement.classList.remove('hide-r-sidebar');
                sidebarObserver.disconnect();
            }
        });
        sidebarObserver.observe(mainView, { childList: true, subtree: true });
    }
}
electron_better_ipc_1.ipcRenderer.answerMain('search', (isNewDesign) => {
    if (isNewDesign) {
        openSearchInConversation();
    }
    else {
        document.querySelector('._3szo:nth-of-type(1)').click();
    }
});
electron_better_ipc_1.ipcRenderer.answerMain('insert-gif', () => {
    var _a, _b;
    const gifElement = (_b = (_a = 
    // Old UI
    document.querySelector('._yht')) !== null && _a !== void 0 ? _a : 
    // New UI
    [...document.querySelectorAll('._7oam')].find(element => element.querySelector('svg path[d^="M27.002,13.5"]'))) !== null && _b !== void 0 ? _b : 
    // Newest UI
    document.querySelector('.tkr6xdv7 .pmk7jnqg.kkf49tns.cgat1ltu.sw24d88r.i09qtzwb.g3zh7qmp.flx89l3n.mb8dcdod.chkx7lpg [aria-hidden=false]');
    gifElement.click();
});
electron_better_ipc_1.ipcRenderer.answerMain('insert-emoji', async () => {
    const newDesign = await isNewDesign();
    const emojiElement = newDesign ?
        document.querySelector('.cxmmr5t8 .tojvnm2t.a6sixzi8.abs2jz4q.a8s20v7p.t1p8iaqh.k5wvi7nf.q3lfd5jv.pk4s997a.bipmatt0.cebpdrjk.qowsmv63.owwhemhu.dp1hu0rb.dhp61c6y.iyyx5f41 [role=button]') :
        (await elementReady('._5s2p, ._30yy._7odb', {
            stopOnDomReady: false
        }));
    emojiElement.click();
});
electron_better_ipc_1.ipcRenderer.answerMain('insert-sticker', () => {
    var _a, _b;
    const stickerElement = (_b = (_a = 
    // Old UI
    document.querySelector('._4rv6')) !== null && _a !== void 0 ? _a : 
    // New UI
    [...document.querySelectorAll('._7oam')].find(element => element.querySelector('svg path[d^="M22.5,18.5 L27.998,18.5"]'))) !== null && _b !== void 0 ? _b : 
    // Newest UI
    document.querySelector('.tkr6xdv7 .pmk7jnqg.kkf49tns.cgat1ltu.sw24d88r.i09qtzwb.g3zh7qmp.flx89l3n.mb8dcdod.tntlmw5q [aria-hidden=false]');
    stickerElement.click();
});
electron_better_ipc_1.ipcRenderer.answerMain('attach-files', () => {
    var _a;
    const filesElement = (_a = 
    // Old UI
    document.querySelector('._5vn8 + input[type="file"], ._7oam input[type="file"]')) !== null && _a !== void 0 ? _a : 
    // Newest UI
    document.querySelector('.tkr6xdv7 .pmk7jnqg.kkf49tns.cgat1ltu.sw24d88r.i09qtzwb.g3zh7qmp.flx89l3n.mb8dcdod.lbhrjshz [aria-hidden=false]');
    filesElement.click();
});
electron_better_ipc_1.ipcRenderer.answerMain('focus-text-input', () => {
    var _a;
    const textInput = (_a = 
    // Old UI
    document.querySelector('._7kpg ._5rpu')) !== null && _a !== void 0 ? _a : 
    // Newest UI
    document.querySelector('[role=textbox][contenteditable=true]');
    textInput.focus();
});
electron_better_ipc_1.ipcRenderer.answerMain('next-conversation', nextConversation);
electron_better_ipc_1.ipcRenderer.answerMain('previous-conversation', previousConversation);
electron_better_ipc_1.ipcRenderer.answerMain('mute-conversation', async ({ isNewDesign }) => {
    await openMuteModal(isNewDesign);
});
electron_better_ipc_1.ipcRenderer.answerMain('delete-conversation', async ({ isNewDesign }) => {
    await deleteSelectedConversation(isNewDesign);
});
electron_better_ipc_1.ipcRenderer.answerMain('hide-conversation', async ({ isNewDesign }) => {
    const index = selectedConversationIndex(isNewDesign);
    if (index !== -1) {
        await hideSelectedConversation(isNewDesign);
        const key = index + 1;
        await jumpToConversation(isNewDesign, key);
    }
});
async function openHiddenPreferences(isNewDesign) {
    if (!isPreferencesOpen(isNewDesign)) {
        document.documentElement.classList.add('hide-preferences-window');
        const style = document.createElement('style');
        // Hide both the backdrop and the preferences dialog
        style.textContent = `${preferencesSelector} ._3ixn, ${preferencesSelector} ._59s7 { opacity: 0 !important }`;
        document.body.append(style);
        await openPreferences(isNewDesign);
        if (!isNewDesign) {
            // Will clean up itself after the preferences are closed
            document.querySelector(preferencesSelector).append(style);
        }
        return true;
    }
    return false;
}
async function toggleSounds({ isNewDesign, checked }) {
    const shouldClosePreferences = await openHiddenPreferences(isNewDesign);
    const soundsCheckbox = document.querySelector(messengerSoundsSelector);
    if (typeof checked === 'undefined' || checked !== soundsCheckbox.checked) {
        soundsCheckbox.click();
    }
    if (shouldClosePreferences) {
        await closePreferences(isNewDesign);
    }
}
electron_better_ipc_1.ipcRenderer.answerMain('toggle-sounds', toggleSounds);
electron_better_ipc_1.ipcRenderer.answerMain('toggle-mute-notifications', async ({ isNewDesign, defaultStatus }) => {
    const shouldClosePreferences = await openHiddenPreferences(isNewDesign);
    const notificationCheckbox = document.querySelector(selectors_1.default.notificationCheckbox);
    if (!isNewDesign) {
        if (defaultStatus === undefined) {
            notificationCheckbox.click();
        }
        else if ((defaultStatus && notificationCheckbox.checked) ||
            (!defaultStatus && !notificationCheckbox.checked)) {
            notificationCheckbox.click();
        }
    }
    if (shouldClosePreferences) {
        await closePreferences(isNewDesign);
    }
    return !isNewDesign && !notificationCheckbox.checked;
});
electron_better_ipc_1.ipcRenderer.answerMain('toggle-message-buttons', () => {
    document.body.classList.toggle('show-message-buttons', config_1.default.get('showMessageButtons'));
});
electron_better_ipc_1.ipcRenderer.answerMain('show-active-contacts-view', async () => {
    const newDesign = await isNewDesign();
    await selectOtherListViews(newDesign, newDesign ? 2 : 3);
});
electron_better_ipc_1.ipcRenderer.answerMain('show-message-requests-view', async () => {
    const newDesign = await isNewDesign();
    await selectOtherListViews(newDesign, newDesign ? 3 : 4);
});
electron_better_ipc_1.ipcRenderer.answerMain('show-hidden-threads-view', async () => {
    const newDesign = await isNewDesign();
    await selectOtherListViews(newDesign, newDesign ? 4 : 5);
});
electron_better_ipc_1.ipcRenderer.answerMain('toggle-unread-threads-view', async () => {
    await selectOtherListViews(false, 6);
});
electron_better_ipc_1.ipcRenderer.answerMain('toggle-video-autoplay', () => {
    autoplay_1.toggleVideoAutoplay();
});
electron_better_ipc_1.ipcRenderer.answerMain('reload', () => {
    location.reload();
});
function setDarkMode() {
    setDarkModeElement(document.documentElement);
    updateVibrancy();
}
function setDarkModeElement(element) {
    if (electron_util_1.is.macos && config_1.default.get('followSystemAppearance')) {
        electron_util_1.api.nativeTheme.themeSource = 'system';
    }
    else {
        electron_util_1.api.nativeTheme.themeSource = config_1.default.get('darkMode') ? 'dark' : 'light';
    }
    element.classList.toggle('dark-mode', electron_util_1.api.nativeTheme.shouldUseDarkColors);
    element.classList.toggle('light-mode', !electron_util_1.api.nativeTheme.shouldUseDarkColors);
    element.classList.toggle('__fb-dark-mode', electron_util_1.api.nativeTheme.shouldUseDarkColors);
    element.classList.toggle('__fb-light-mode', !electron_util_1.api.nativeTheme.shouldUseDarkColors);
}
async function observeDarkMode() {
    /* Main document's class list */
    const observer = new MutationObserver((records) => {
        // Find records that had class attribute changed
        const classRecords = records.filter(record => record.type === 'attributes' && record.attributeName === 'class');
        // Check if dark mode classes exists
        const isDark = classRecords.some(record => {
            const { classList } = record.target;
            return classList.contains('dark-mode') && classList.contains('__fb-dark-mode');
        });
        // If config and class list don't match, update class list
        if (electron_util_1.api.nativeTheme.shouldUseDarkColors !== isDark) {
            setDarkMode();
        }
    });
    observer.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] });
    /* Added nodes (dialogs, etc.) */
    const observerNew = new MutationObserver((records) => {
        const nodeRecords = records.filter(record => record.addedNodes.length > 0);
        for (const nodeRecord of nodeRecords) {
            for (const newNode of nodeRecord.addedNodes) {
                const { classList } = newNode;
                const isLight = classList.contains('light-mode') || classList.contains('__fb-light-mode');
                if (electron_util_1.api.nativeTheme.shouldUseDarkColors === isLight) {
                    setDarkModeElement(newNode);
                }
            }
        }
    });
    /* Observe only elements where new nodes may need dark mode */
    const menuElements = await elementReady('.j83agx80.cbu4d94t.l9j0dhe7.jgljxmt5.be9z9djy > div:nth-of-type(2) > div', { stopOnDomReady: false });
    if (menuElements) {
        observerNew.observe(menuElements, { childList: true });
    }
    // Attribute notation needed here to guarantee exact (not partial) match.
    //const modalElements = await elementReady('div[class="rq0escxv l9j0dhe7 du4w35lb"] > div:nth-of-type(3) > div', { stopOnDomReady: false });
    const modalElements = await elementReady(preferencesSelectorNewDesign, { stopOnDomReady: false });
    if (modalElements) {
        observerNew.observe(modalElements, { childList: true });
    }
}
function setPrivateMode(isNewDesign) {
    document.documentElement.classList.toggle('private-mode', config_1.default.get('privateMode'));
    if (electron_util_1.is.macos) {
        conversation_list_1.sendConversationList(isNewDesign);
    }
}
function updateVibrancy() {
    const { classList } = document.documentElement;
    classList.remove('sidebar-vibrancy', 'full-vibrancy');
    switch (config_1.default.get('vibrancy')) {
        case 'sidebar':
            classList.add('sidebar-vibrancy');
            break;
        case 'full':
            classList.add('full-vibrancy');
            break;
        default:
    }
    electron_better_ipc_1.ipcRenderer.callMain('set-vibrancy');
}
function updateSidebar() {
    const { classList } = document.documentElement;
    classList.remove('sidebar-hidden', 'sidebar-force-narrow', 'sidebar-force-wide');
    switch (config_1.default.get('sidebar')) {
        case 'hidden':
            classList.add('sidebar-hidden');
            break;
        case 'narrow':
            classList.add('sidebar-force-narrow');
            break;
        case 'wide':
            classList.add('sidebar-force-wide');
            break;
        default:
    }
}
async function updateDoNotDisturb(isNewDesign) {
    const shouldClosePreferences = await openHiddenPreferences(isNewDesign);
    if (!isNewDesign) {
        const soundsCheckbox = document.querySelector(messengerSoundsSelector);
        toggleSounds(await electron_better_ipc_1.ipcRenderer.callMain('update-dnd-mode', soundsCheckbox.checked));
    }
    if (shouldClosePreferences) {
        await closePreferences(isNewDesign);
    }
}
function renderOverlayIcon(messageCount) {
    const canvas = document.createElement('canvas');
    canvas.height = 128;
    canvas.width = 128;
    canvas.style.letterSpacing = '-5px';
    const ctx = canvas.getContext('2d');
    ctx.fillStyle = '#f42020';
    ctx.beginPath();
    ctx.ellipse(64, 64, 64, 64, 0, 0, 2 * Math.PI);
    ctx.fill();
    ctx.textAlign = 'center';
    ctx.fillStyle = 'white';
    ctx.font = '90px sans-serif';
    ctx.fillText(String(Math.min(99, messageCount)), 64, 96);
    return canvas;
}
electron_better_ipc_1.ipcRenderer.answerMain('update-sidebar', () => {
    updateSidebar();
});
electron_better_ipc_1.ipcRenderer.answerMain('set-dark-mode', setDarkMode);
electron_better_ipc_1.ipcRenderer.answerMain('set-private-mode', setPrivateMode);
electron_better_ipc_1.ipcRenderer.answerMain('update-vibrancy', () => {
    updateVibrancy();
});
electron_better_ipc_1.ipcRenderer.answerMain('render-overlay-icon', (messageCount) => {
    return {
        data: renderOverlayIcon(messageCount).toDataURL(),
        text: String(messageCount)
    };
});
electron_better_ipc_1.ipcRenderer.answerMain('render-native-emoji', (emoji) => {
    const canvas = document.createElement('canvas');
    const context = canvas.getContext('2d');
    canvas.width = 256;
    canvas.height = 256;
    context.textAlign = 'center';
    context.textBaseline = 'middle';
    if (electron_util_1.is.macos) {
        context.font = '256px system-ui';
        context.fillText(emoji, 128, 154);
    }
    else {
        context.textBaseline = 'bottom';
        context.font = '225px system-ui';
        context.fillText(emoji, 128, 256);
    }
    const dataUrl = canvas.toDataURL();
    return dataUrl;
});
electron_better_ipc_1.ipcRenderer.answerMain('zoom-reset', ({ isNewDesign }) => {
    setZoom(isNewDesign, 1);
});
electron_better_ipc_1.ipcRenderer.answerMain('zoom-in', ({ isNewDesign }) => {
    const zoomFactor = config_1.default.get('zoomFactor') + 0.1;
    if (zoomFactor < 1.6) {
        setZoom(isNewDesign, zoomFactor);
    }
});
electron_better_ipc_1.ipcRenderer.answerMain('zoom-out', ({ isNewDesign }) => {
    const zoomFactor = config_1.default.get('zoomFactor') - 0.1;
    if (zoomFactor >= 0.8) {
        setZoom(isNewDesign, zoomFactor);
    }
});
electron_better_ipc_1.ipcRenderer.answerMain('jump-to-conversation', async (key) => {
    await jumpToConversation(await isNewDesign(), key);
});
async function nextConversation() {
    const newDesign = await isNewDesign();
    const index = selectedConversationIndex(newDesign, 1);
    if (index !== -1) {
        await selectConversation(newDesign, index);
    }
}
async function previousConversation() {
    const newDesign = await isNewDesign();
    const index = selectedConversationIndex(newDesign, -1);
    if (index !== -1) {
        await selectConversation(newDesign, index);
    }
}
async function jumpToConversation(isNewDesign, key) {
    const index = key - 1;
    await selectConversation(isNewDesign, index);
}
// Focus on the conversation with the given index
async function selectConversation(isNewDesign, index) {
    const list = isNewDesign ?
        await elementReady(selectors_1.default.conversationListNewDesign, { stopOnDomReady: false }) :
        await elementReady(selectors_1.default.conversationList, { stopOnDomReady: false });
    if (!list) {
        console.error('Could not find conversations list', selectors_1.default.conversationList);
        return;
    }
    const conversation = list.children[index];
    if (!conversation) {
        console.error('Could not find conversation', index);
        return;
    }
    (isNewDesign ? conversation.querySelector('[role=link]') : conversation.firstChild.firstChild).click();
}
function selectedConversationIndex(isNewDesign, offset = 0) {
    var _a;
    const selected = (_a = 
    // Old UI
    document.querySelector(selectedConversationSelector)) !== null && _a !== void 0 ? _a : 
    // Newest UI
    document.querySelector(selectedConversationNewDesign);
    if (!selected) {
        return -1;
    }
    const newSelected = isNewDesign ?
        selected.parentNode.parentNode.parentNode :
        selected;
    const list = [...newSelected.parentNode.children];
    const index = list.indexOf(newSelected) + offset;
    return ((index % list.length) + list.length) % list.length;
}
function setZoom(isNewDesign, zoomFactor) {
    const node = document.querySelector('#zoomFactor');
    node.textContent = `${isNewDesign ? selectors_1.default.conversationSelectorNewDesign : selectors_1.default.conversationSelector} {zoom: ${zoomFactor} !important}`;
    config_1.default.set('zoomFactor', zoomFactor);
}
async function withConversationMenu(isNewDesign, callback) {
    var _a, _b, _c, _d, _e;
    let menuButton = null;
    if (isNewDesign) {
        const conversation = (_d = (_c = (_b = (_a = document.querySelector(`${selectedConversationNewDesign}`)) === null || _a === void 0 ? void 0 : _a.parentElement) === null || _b === void 0 ? void 0 : _b.parentElement) === null || _c === void 0 ? void 0 : _c.parentElement) === null || _d === void 0 ? void 0 : _d.parentElement;
        menuButton = (_e = conversation === null || conversation === void 0 ? void 0 : conversation.querySelector('[aria-label=Menu][role=button]')) !== null && _e !== void 0 ? _e : null;
    }
    else {
        menuButton = document.querySelector(`${selectedConversationSelector} [aria-haspopup=true] [role=button]`);
    }
    if (menuButton) {
        await withMenu(isNewDesign, menuButton, callback);
    }
}
async function openMuteModal(isNewDesign) {
    await withConversationMenu(isNewDesign, () => {
        selectMenuItem(isNewDesign, isNewDesign ? 2 : 1);
    });
}
/*
This function assumes:
- There is a selected conversation.
- That the conversation already has its conversation menu open.

In other words, you should only use this function within a callback that is provided to `withConversationMenu()`, because `withConversationMenu()` makes sure to have the conversation menu open before executing the callback and closes the conversation menu afterwards.
*/
function isSelectedConversationGroup(isNewDesign) {
    const separator = isNewDesign ?
        document.querySelector(`${conversationMenuSelectorNewDesign} [role=menuitem]:nth-child(4)`) :
        document.querySelector(`${conversationMenuSelector} > li:nth-child(6)[role=separator]`);
    return Boolean(separator);
}
async function hideSelectedConversation(isNewDesign) {
    await withConversationMenu(isNewDesign, () => {
        const [isGroup, isNotGroup] = isNewDesign ? [5, 6] : [4, 3];
        selectMenuItem(isNewDesign, isSelectedConversationGroup(isNewDesign) ? isGroup : isNotGroup);
    });
}
async function deleteSelectedConversation(isNewDesign) {
    await withConversationMenu(isNewDesign, () => {
        const [isGroup, isNotGroup] = isNewDesign ? [6, 7] : [5, 4];
        selectMenuItem(isNewDesign, isSelectedConversationGroup(isNewDesign) ? isGroup : isNotGroup);
    });
}
async function openPreferences(isNewDesign) {
    await withSettingsMenu(isNewDesign, () => {
        selectMenuItem(isNewDesign, 1);
    });
    await elementReady(isNewDesign ? preferencesSelectorNewDesign : preferencesSelector, { stopOnDomReady: false });
}
function isPreferencesOpen(isNewDesign) {
    return isNewDesign ?
        Boolean(document.querySelector('[aria-label=Preferences]')) :
        Boolean(document.querySelector('._3quh._30yy._2t_._5ixy'));
}
async function closePreferences(isNewDesign) {
    if (isNewDesign) {
        const closeButton = await elementReady(selectors_1.default.closePreferencesButton, { stopOnDomReady: false });
        closeButton === null || closeButton === void 0 ? void 0 : closeButton.click();
        // Wait for the preferences window to be closed, then remove the class from the document
        const preferencesOverlayObserver = new MutationObserver(records => {
            const removedRecords = records.filter(({ removedNodes }) => removedNodes.length > 0 && removedNodes[0].tagName === 'DIV');
            // In case there is a div removed, hide utility class and stop observing
            if (removedRecords.length > 0) {
                document.documentElement.classList.remove('hide-preferences-window');
                preferencesOverlayObserver.disconnect();
            }
        });
        const preferencesOverlay = document.querySelector('div[class="rq0escxv l9j0dhe7 du4w35lb"] > div:nth-of-type(3) > div');
        return preferencesOverlayObserver.observe(preferencesOverlay, { childList: true });
    }
    const doneButton = document.querySelector('._3quh._30yy._2t_._5ixy');
    doneButton.click();
}
function insertionListener(event) {
    if (event.animationName === 'nodeInserted' && event.target) {
        event.target.dispatchEvent(new Event('mouseover', { bubbles: true }));
    }
}
async function observeAutoscroll() {
    const mainElement = await elementReady('._4sp8', { stopOnDomReady: false });
    if (!mainElement) {
        return;
    }
    const scrollToBottom = () => {
        const scrollableElement = document.querySelector('[role=presentation] .scrollable');
        if (scrollableElement) {
            scrollableElement.scroll({
                top: Number.MAX_SAFE_INTEGER,
                behavior: 'smooth'
            });
        }
    };
    const hookMessageObserver = async () => {
        const chatElement = await elementReady('[role=presentation] .scrollable [role = region] > div[id ^= "js_"]', { stopOnDomReady: false });
        if (chatElement) {
            // Scroll to the bottom when opening different conversation
            scrollToBottom();
            const messageObserver = new MutationObserver((record) => {
                const newMessages = record.filter(record => {
                    // The mutation is an addition
                    return record.addedNodes.length > 0 &&
                        // ... of a div       (skip the "seen" status change)
                        record.addedNodes[0].tagName === 'DIV' &&
                        // ... on the last child       (skip previous messages added when scrolling up)
                        chatElement.lastChild.contains(record.target);
                });
                if (newMessages.length > 0) {
                    // Scroll to the bottom when there are new messages
                    scrollToBottom();
                }
            });
            messageObserver.observe(chatElement, { childList: true, subtree: true });
        }
    };
    hookMessageObserver();
    // Hook it again if conversation changes
    const conversationObserver = new MutationObserver(hookMessageObserver);
    conversationObserver.observe(mainElement, { childList: true });
}
// Listen for emoji element dom insertion
document.addEventListener('animationstart', insertionListener, false);
// Inject a global style node to maintain custom appearance after conversation change or startup
document.addEventListener('DOMContentLoaded', async () => {
    const newDesign = await isNewDesign();
    const style = document.createElement('style');
    style.id = 'zoomFactor';
    document.body.append(style);
    // Set the zoom factor if it was set before quitting
    const zoomFactor = config_1.default.get('zoomFactor');
    setZoom(newDesign, zoomFactor);
    // Enable OS specific styles
    document.documentElement.classList.add(`os-${process.platform}`);
    // Restore sidebar view state to what is was set before quitting
    updateSidebar();
    // Activate Dark Mode if it was set before quitting
    setDarkMode();
    // Observe for dark mode changes
    observeDarkMode();
    // Activate Private Mode if it was set before quitting
    setPrivateMode(newDesign);
    // Configure do not disturb
    if (electron_util_1.is.macos) {
        await updateDoNotDisturb(newDesign);
    }
    // Prevent flash of white on startup when in dark mode
    // TODO: find a CSS-only solution
    if (!electron_util_1.is.macos && config_1.default.get('darkMode')) {
        document.documentElement.style.backgroundColor = '#1e1e1e';
    }
    // Disable autoplay if set in settings
    autoplay_1.toggleVideoAutoplay();
    // Hook auto-scroll observer
    observeAutoscroll();
});
// Handle title bar double-click.
window.addEventListener('dblclick', (event) => {
    const target = event.target;
    const titleBar = target.closest('._36ic._5l-3,._5742,._6-xk,._673w');
    if (!titleBar) {
        return;
    }
    electron_better_ipc_1.ipcRenderer.callMain('titlebar-doubleclick');
}, {
    passive: true
});
window.addEventListener('load', () => {
    if (location.pathname.startsWith('/login')) {
        const keepMeSignedInCheckbox = document.querySelector('#u_0_0');
        keepMeSignedInCheckbox.checked = config_1.default.get('keepMeSignedIn');
        keepMeSignedInCheckbox.addEventListener('change', () => {
            config_1.default.set('keepMeSignedIn', !config_1.default.get('keepMeSignedIn'));
        });
    }
});
// Toggles styles for inactive window
window.addEventListener('blur', () => {
    document.documentElement.classList.add('is-window-inactive');
});
window.addEventListener('focus', () => {
    document.documentElement.classList.remove('is-window-inactive');
});
// It's not possible to add multiple accelerators
// so this needs to be done the old-school way
document.addEventListener('keydown', async (event) => {
    // The `!event.altKey` part is a workaround for https://github.com/electron/electron/issues/13895
    const combineKey = electron_util_1.is.macos ? event.metaKey : event.ctrlKey && !event.altKey;
    if (!combineKey) {
        return;
    }
    if (event.key === ']') {
        await nextConversation();
    }
    if (event.key === '[') {
        await previousConversation();
    }
    const number = Number.parseInt(event.code.slice(-1), 10);
    if (number >= 1 && number <= 9) {
        await jumpToConversation(await isNewDesign(), number);
    }
});
// Pass events sent via `window.postMessage` on to the main process
window.addEventListener('message', async ({ data: { type, data } }) => {
    if (type === 'notification') {
        showNotification(data);
    }
    if (type === 'notification-reply') {
        await sendReply(data.reply);
        if (data.previousConversation) {
            await selectConversation(await isNewDesign(), data.previousConversation);
        }
    }
});
function showNotification({ id, title, body, icon, silent }) {
    const image = new Image();
    image.crossOrigin = 'anonymous';
    image.src = icon;
    image.addEventListener('load', () => {
        const canvas = document.createElement('canvas');
        const context = canvas.getContext('2d');
        canvas.width = image.width;
        canvas.height = image.height;
        context.drawImage(image, 0, 0, image.width, image.height);
        electron_better_ipc_1.ipcRenderer.callMain('notification', {
            id,
            title,
            body,
            icon: canvas.toDataURL(),
            silent
        });
    });
}
async function sendReply(message) {
    const inputField = document.querySelector('[contenteditable="true"]');
    if (!inputField) {
        return;
    }
    const previousMessage = inputField.textContent;
    // Send message
    inputField.focus();
    insertMessageText(message, inputField);
    const sendButton = await elementReady('._30yy._38lh', { stopOnDomReady: false });
    if (!sendButton) {
        console.error('Could not find send button');
        return;
    }
    sendButton.click();
    // Restore (possible) previous message
    if (previousMessage) {
        insertMessageText(previousMessage, inputField);
    }
}
function insertMessageText(text, inputField) {
    // Workaround: insert placeholder value to get execCommand working
    if (!inputField.textContent) {
        const event = document.createEvent('TextEvent');
        event.initTextEvent('textInput', true, true, window, '_', 0, '');
        inputField.dispatchEvent(event);
    }
    document.execCommand('selectAll', false, undefined);
    document.execCommand('insertText', false, text);
}
electron_better_ipc_1.ipcRenderer.answerMain('notification-callback', (data) => {
    window.postMessage({ type: 'notification-callback', data }, '*');
});
electron_better_ipc_1.ipcRenderer.answerMain('notification-reply-callback', async (data) => {
    const previousConversation = selectedConversationIndex(await isNewDesign());
    data.previousConversation = previousConversation;
    window.postMessage({ type: 'notification-reply-callback', data }, '*');
});
async function isNewDesign() {
    return Boolean(await elementReady('._9dls', { stopOnDomReady: false }));
}
exports.isNewDesign = isNewDesign;
electron_better_ipc_1.ipcRenderer.answerMain('check-new-ui', async () => {
    return isNewDesign();
});
