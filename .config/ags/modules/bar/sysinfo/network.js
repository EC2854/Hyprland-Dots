import { Network } from "../../../imports.js"
import { Widget } from "../../../imports.js";
const { Box } = Widget;

const WifiIndicator = () => Widget.Box({
    children: [
        Widget.Icon({
            icon: Network.wifi.bind('icon_name'),
        }),
    ],
})

const WiredIndicator = () => Widget.Icon({
    icon: Network.wired.bind('icon_name'),
})

const NetworkIndicator = () => Widget.Stack({
    items: [
        ['wifi', WifiIndicator()],
        ['wired', WiredIndicator()],
    ],
    shown: Network.bind('primary').transform(p => p || 'wifi'),
})

export const NetworkWidget = () => Box({
    class_name: 'network',
    children: [NetworkIndicator()],
});
