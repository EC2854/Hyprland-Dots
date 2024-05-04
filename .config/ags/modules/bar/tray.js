// import { SystemTray } from "../../imports.js"
// import { Widget } from "../../imports.js";
const SystemTray = await Service.import("systemtray");
const { Box } = Widget;

const SysTrayItem = item => Widget.Button({
    child: Widget.Icon().bind('icon', item, 'icon'),
    tooltipMarkup: item.bind('tooltip_markup'),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
});

export const sysTray = () => Box({
    class_name: 'tray',
    children: SystemTray.bind('items').transform(i => i.map(SysTrayItem))
})
