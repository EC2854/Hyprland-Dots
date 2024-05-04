const Network = await Service.import("network");

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

export const NetworkWidget = () => Widget.Stack({
    class_name: 'network',
    children: {
        'wifi': WifiIndicator(),
        'wired': WiredIndicator(),
    },
    shown: Network.bind('primary').transform(p => p || 'wifi'),
})
